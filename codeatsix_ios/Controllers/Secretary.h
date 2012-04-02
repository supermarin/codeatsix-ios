//
//  PhoneSecretary.h
//  YourDiscount
//
//  Created by Marin on 8/19/11.
//  Copyright 2011 InGenius Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Secretary : NSObject <UIAlertViewDelegate>


+ (void)call:(NSString *)number;

+ (void)addToCalendar:(NSString *)eventName 
            startDate:(NSDate *)startDate 
              endDate:(NSDate *)endDate 
             location:(NSString *)location;


@end
