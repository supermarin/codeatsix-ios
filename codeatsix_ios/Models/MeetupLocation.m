//
//  MeetupLocation.m
//  codeatsix_ios
//
//  Created by Marin Usalj on 3/30/12.
//  Copyright (c) 2012 @mneorr | mneorr.com | linkedin.com/marin.usalj. All rights reserved.
//

#import "MeetupLocation.h"

@implementation MeetupLocation

#pragma mark MKAnnotation protocol

- (CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake(45.792784, 15.962706);
}

- (NSString *)title {
    return @"Infinum d.o.o";
}

- (NSString *)subtitle {
    return @"Odranska 1";
}


@end
