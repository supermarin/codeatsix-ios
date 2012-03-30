//
//  Event.m
//  codeatsix_ios
//
//  Created by Marin Usalj on 3/30/12.
//  Copyright (c) 2012 @mneorr | mneorr.com | linkedin.com/marin.usalj. All rights reserved.
//

#import "Event.h"

@implementation Event
@synthesize body, slug, title, report, event_id, is_active, announcement, scheduled_at;

- (id)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (!self) return nil;
    

    
    return self;
}



#pragma mark - Private

- (void)unpackFromDictionary:(NSDictionary *)dict {
    self.body = [dict valueForKey:@"body"];
    self.slug = [dict valueForKey:@"slug"];
    self.report = [dict valueForKey:@"report"];
    self.scheduled_at = [dict valueForKey:@"scheduled_at"];
    self.announcement = [dict valueForKey:@"announcement"];
    self.title = [dict valueForKey:@"title"];
    self.event_id = [dict valueForKey:@"id"];
}

@end
