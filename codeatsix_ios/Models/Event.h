//
//  Event.h
//  codeatsix_ios
//
//  Created by Marin Usalj on 3/30/12.
//  Copyright (c) 2012 @mneorr | mneorr.com | linkedin.com/marin.usalj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Event : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *slug;
@property (strong, nonatomic) NSString *announcement;
@property (strong, nonatomic) NSString *report;
@property (strong, nonatomic) NSString *body;
@property (strong, nonatomic) NSNumber *event_id;
@property (strong, nonatomic) NSNumber *is_active;
@property (strong, nonatomic) NSDate *scheduled_at;


- (id)initWithDictionary:(NSDictionary *)dict;
@end
