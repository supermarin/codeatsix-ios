//
//  EventsManager.m
//  codeatsix_ios
//
//  Created by Marin Usalj on 4/2/12.
//  Copyright (c) 2012 @mneorr | mneorr.com | linkedin.com/marin.usalj. All rights reserved.
//

#import "EventsManager.h"
#import "UIAlertView+SimplyShow.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "Event.h"
#import "UserData.h"
#import "Server.h"

@interface EventsManager ()
@property(nonatomic, retain) ASIHTTPRequest *currentRequest;
@end


@implementation EventsManager
@synthesize delegate, currentRequest;


- (id)initWithDelegate:(id<EventsManagerDelegate>)theDelegate
{
    self = [super init];
    if (!self) return nil;
    
    self.delegate = theDelegate;
    
    return self;
}

- (void)dealloc {
    [currentRequest clearDelegatesAndCancel];
    [self setCurrentRequest:nil];
}


#pragma mark - Private

- (void)hitTheServer:(NSString *)urlString {
    NSURL *url = [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    [self setCurrentRequest:nil];
    currentRequest = [[ASIHTTPRequest alloc] initWithURL:url];
    currentRequest.timeOutSeconds = 30;
    currentRequest.delegate = self;
    currentRequest.didFinishSelector = @selector(eventsRetrievingRequestFinished:);
    [currentRequest startAsynchronous];
}

- (NSDictionary *)paramsForEvent:(Event *)event {
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:event.event_id forKey:@"event_id"];
    [params setValue:[[UserData instance] personDictionary] forKey:@"person"];
    
    return params;
}

- (void)signupOnEvent:(Event *)event {
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[Server signupURL]]];
    [request addRequestHeader: @"Content-Type" value: @"application/json; charset=utf-8"];
    
    [request appendPostData:[[self paramsForEvent:event].JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(signupRequestFinished:)];
    [request startAsynchronous];
}

- (NSArray *)createEventsFromDictionaries:(NSArray *)eventsInDicts {
    NSMutableArray *allEvents = [NSMutableArray new];
    
    for (NSDictionary *eventInDict in eventsInDicts)
        [allEvents addObject:[[Event alloc] initWithDictionary:eventInDict]];
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"scheduled_at" ascending:YES];
    return [allEvents sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]];
}


#pragma mark - Public

- (void)retrieveEvents {
    [self hitTheServer:[Server eventsURL]];
}


#pragma mark - ASIHTTP delegate

- (void)signupRequestFinished:(ASIHTTPRequest *)request {

    [delegate successfullyAppliedToEventWithMessage:
     [[[request responseString] objectFromJSONString] valueForKey:@"message"]];
}


- (void)eventsRetrievingRequestFinished:(ASIHTTPRequest *)request {
    
    [delegate eventsManager:self didRetrieveEvents:[self createEventsFromDictionaries:
                                                    [[[request responseString] objectFromJSONString] valueForKey:@"events"]]];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    [UIAlertView showWithTitle:@"Network error" andMessage:[[request error] localizedDescription]];
    [self setCurrentRequest:nil];
}
@end
