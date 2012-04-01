//
//  EventDetailsViewControllerViewController.m
//  codeatsix_ios
//
//  Created by Marin Usalj on 3/30/12.
//  Copyright (c) 2012 @mneorr | mneorr.com | linkedin.com/marin.usalj. All rights reserved.
//

#import "EventDetailsViewController.h"
#import "Event.h"

@interface EventDetailsViewController ()

@end

@implementation EventDetailsViewController
@synthesize event;
@synthesize announcementLabel;

#pragma mark - Private



#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO
                                             animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {

    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


#pragma mark - Public

- (void)setEvent:(Event *)newEvent {
    if ([newEvent isEqual:event]) return;
    
    event = newEvent;
    self.title = event.title;
}

#pragma mark - IBActions

- (void)viewDidUnload {
    [self setAnnouncementLabel:nil];
    [super viewDidUnload];
}
@end
