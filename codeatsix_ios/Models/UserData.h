//
//  UserData.h
//  codeatsix_ios
//
//  Created by Marin Usalj on 4/2/12.
//  Copyright (c) 2012 @mneorr | mneorr.com | linkedin.com/marin.usalj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject

+ (id)instance;

- (NSDictionary *)personDictionary;
- (void)storePersonFirstName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email;

@end
