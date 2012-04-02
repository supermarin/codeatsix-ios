//
//  PhoneSecretary.m
//  YourDiscount
//
//  Created by Marin on 8/19/11.
//  Copyright 2011 InGenius Labs. All rights reserved.
//

#import "Secretary.h"
#import <EventKit/EventKit.h>
#import "UIAlertView+SimplyShow.h"

@implementation Secretary

+ (void)showAlertToCallOrCancel:(NSString *)numberToCall {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:numberToCall delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Call", nil];
    alertView.delegate = self;
    [alertView show];
}


+ (void)tryToInsertEvent:(EKEvent *)event inStore:(EKEventStore *)store {
    NSError *error = nil;
    
    [store saveEvent:event span:EKSpanThisEvent error:&error];
    
    if (error) 
        @throw [NSException exceptionWithName:@"SaveToCalendarException" 
                                       reason:error.localizedDescription 
                                     userInfo:error.userInfo];   
}

#pragma mark - Public

+ (void)call:(NSString *)number {
    NSString *myRegex = @"(\\(|\\))";
    NSString *formattedPhoneNumber = [number stringByReplacingOccurrencesOfString:myRegex withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [number length])];
    
    [self showAlertToCallOrCancel:formattedPhoneNumber];
}

+ (void)addToCalendar:(NSString *)eventName 
            startDate:(NSDate *)startDate 
              endDate:(NSDate *)endDate 
             location:(NSString *)location {
    
    EKEventStore *store = [EKEventStore new];  
    EKEvent *event = [EKEvent eventWithEventStore:store];
    [event setCalendar:[store defaultCalendarForNewEvents]];
    [event setStartDate:startDate];
    [event setEndDate:endDate];
    [event setLocation:location];
    [event setTitle:eventName];
    
    @try {
        [self tryToInsertEvent:event inStore:store];
        [UIAlertView showWithTitle:@"Success" andMessage:@"Event succesfully inserted in your calendar!"];
    }
    @catch (NSException *exception) {
        [UIAlertView showWithTitle:@"Sorry" andMessage:@"There was a problem with inserting your event into calendar."];

    }    
}


#pragma mark - UIAlertView delegate

+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *phone = [alertView message];
    
    if (buttonIndex == [alertView cancelButtonIndex]) return;
    
    NSString *regex = @"(\\(|\\)| )";
    NSString *formattedPhoneNumber = [phone stringByReplacingOccurrencesOfString:regex withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [phone length])];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", formattedPhoneNumber]]]; 
}





@end
