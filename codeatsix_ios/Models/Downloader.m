//
//  Downloader.m
//  best
//
//  Created by Marin Usalj on 3/15/12.
//  Copyright (c) 2012 @mneorr | mneorr.com | linkedin.com/marin.usalj. All rights reserved.
//

#import "Downloader.h"
#import "ASIHTTPRequest.h"
#import "UIAlertView+SimplyShow.h"

@interface Downloader ()
@property(nonatomic, retain) ASIHTTPRequest *currentRequest;
@end

@implementation Downloader
@synthesize currentRequest, delegate, downloadedData, downloadedString, verbose;

- (id)initWithDelegate:(id<DownloaderDelegate>)theDelegate
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
    [self hitTheServer:URL];
}

#pragma mark - ASIHTTP delegate

- (void)requestFinished:(ASIHTTPRequest *)request {
    
    downloadedData = [request responseData];
    downloadedString = [request responseString];
        
    [delegate requestFinishedByDownloader:self];
    [self setCurrentRequest:nil];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    [UIAlertView showWithTitle:@"Network error" andMessage:[[request error] localizedDescription]];
    [self setCurrentRequest:nil];
}

@end
