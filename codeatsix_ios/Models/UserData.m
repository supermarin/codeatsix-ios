//
//  UserData.m
//  codeatsix_ios
//
//  Created by Marin Usalj on 4/2/12.
//  Copyright (c) 2012 @mneorr | mneorr.com | linkedin.com/marin.usalj. All rights reserved.
//

#import "UserData.h"

@implementation UserData

#pragma mark - Singleton
static NSString *PERSON_DICT_KEY = @"personDictionary";
static UserData *singleton;

- (id)initForSingleton {
    self = [super init];
    if (!self) return nil;
    
    return self;
}

+ (id)instance {
    @synchronized(self) {
        if (singleton) return singleton;
        
        singleton = [[self alloc] initForSingleton];
        return singleton;
    }
}


#pragma mark - Public

- (NSDictionary *)personDictionary {
    return [[NSUserDefaults standardUserDefaults] objectForKey:PERSON_DICT_KEY];
}

- (void)storePersonFirstName:(NSString *)firstName 
                  lastName:(NSString *)lastName 
                     email:(NSString *)email {
    
    NSMutableDictionary *personData = [NSMutableDictionary new];
    [personData setValue:firstName forKey:@"first_name"];
    [personData setValue:lastName forKey:@"last_name"];
    [personData setValue:email forKey:@"email"];
    
    [[NSUserDefaults standardUserDefaults] setObject:personData forKey:PERSON_DICT_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
