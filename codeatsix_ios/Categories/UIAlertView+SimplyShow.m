//
//  UIAlertView+SimplyShow.m
//  best
//
//  Created by Marin Usalj on 3/15/12.
//  Copyright (c) 2012 @mneorr | mneorr.com | linkedin.com/marin.usalj. All rights reserved.
//

#import "UIAlertView+SimplyShow.h"

@implementation UIAlertView (SimplyShow)

+ (void)showWithTitle:(NSString *)title andMessage:(NSString *)message {
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}


@end
