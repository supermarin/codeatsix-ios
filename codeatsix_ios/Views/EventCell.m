//
//  EventCell.m
//  codeatsix_ios
//
//  Created by Marin Usalj on 3/30/12.
//  Copyright (c) 2012 @mneorr | mneorr.com | linkedin.com/marin.usalj. All rights reserved.
//

#import "EventCell.h"
#import "Event.h"

@implementation EventCell
@synthesize eventTitleLabel, event;

- (void)dealloc {
    eventTitleLabel = nil;
    event = nil;
}

- (void)setEvent:(Event *)newEvent {
    if ([event isEqual:newEvent]) return;
    
    event = newEvent;
    eventTitleLabel.text = self.event.title;
}
@end
