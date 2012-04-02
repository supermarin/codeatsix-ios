//
//  Event.m
//  codeatsix_ios
//
//  Created by Marin Usalj on 3/30/12.
//  Copyright (c) 2012 @mneorr | mneorr.com | linkedin.com/marin.usalj. All rights reserved.
//

#import "Event.h"

@implementation Event
@synthesize body, slug, title, report, event_id, is_active, announcement, scheduled_at, persons;

- (id)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (!self) return nil;
    
    [self unpackFromDictionary:dict];
    
    return self;
}



#pragma mark - Private

- (NSDate *)initializeDateFromString:(NSString *)dateInString {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss z"];
    
    return [formatter dateFromString:dateInString];
}

- (void)unpackFromDictionary:(NSDictionary *)dict {
    self.body = [dict valueForKey:@"body"];
    self.slug = [dict valueForKey:@"slug"];
    self.report = [dict valueForKey:@"report"];
    self.announcement = [dict valueForKey:@"announcement"];
    self.title = [dict valueForKey:@"title"];
    self.event_id = [dict valueForKey:@"id"];
    self.scheduled_at = [dict valueForKey:@"scheduled_at"];
    self.persons = [dict valueForKey:@"persons"];
    self.scheduled_at = [self initializeDateFromString:[dict valueForKey:@"scheduled_at"]];
}

#pragma mark - Public

- (NSString *)formattedEventDate {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:3600]];
    [formatter setDateFormat:@"EEEE, dd.MM.yyyy 'at' hh:mm"];
    
    return [formatter stringFromDate:self.scheduled_at];
}



@end
