//
//  Downloader.m
//  best
//
//  Created by Marin Usalj on 3/15/12.
//  Copyright (c) 2012 @mneorr | mneorr.com | linkedin.com/marin.usalj. All rights reserved.
//

#import "RequestPerformer.h"
#import "ASIHTTPRequest.h"
#import "UIAlertView+SimplyShow.h"

@interface RequestPerformer ()
@property(nonatomic, retain) ASIHTTPRequest *currentRequest;
@end

@implementation RequestPerformer
@synthesize currentRequest, delegate, downloadedData, downloadedString, verbose;

- (id)initWithDelegate:(id<RequestPerformerDelegate>)theDelegate
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
    if (self.verbose) NSLog(@"requesting... %@", url);
    
    [self setCurrentRequest:nil];
    currentRequest = [[ASIHTTPRequest alloc] initWithURL:url];
    currentRequest.timeOutSeconds = 30;
    currentRequest.delegate = self;
    currentRequest.didFinishSelector = @selector(requestFinished:);
    [currentRequest startAsynchronous];
}



#pragma mark - Public


- (void)downloadFromURL:(NSString *)URL {
    [self setCurrentRequest:nil];
    [self hitTheServer:URL];
}

- (NSData *)downloadedData {
    return [self.currentRequest responseData];
}

- (NSString *)downloadedString {
    return [self.currentRequest responseString];
}

#pragma mark - ASIHTTP delegate

- (void)requestFinished:(ASIHTTPRequest *)request {

    [delegate requestFinishedByPerformer:self];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    [UIAlertView showWithTitle:@"Network error" andMessage:[[request error] localizedDescription]];
    [self setCurrentRequest:nil];
}

@end
