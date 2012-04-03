//
//  EventsManager.h
//  codeatsix_ios
//
//  Created by Marin Usalj on 4/2/12.
//  Copyright (c) 2012 @mneorr | mneorr.com | linkedin.com/marin.usalj. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EventsManager, Event;
@protocol EventsManagerDelegate <NSObject>
- (void)eventsManager:(EventsManager *)manager didRetrieveEvents:(NSArray *)events; 
- (void)successfullyAppliedToEventWithMessage:(NSString *)message; 
@end

@interface EventsManager : NSObject

@property (assign, nonatomic) id<EventsManagerDelegate> delegate;

- (id)initWithDelegate:(id<EventsManagerDelegate>)theDelegate;
- (void)signupOnEvent:(Event *)event; 
- (void)retrieveEvents;

@end
