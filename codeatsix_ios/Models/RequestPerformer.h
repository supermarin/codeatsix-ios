//
//  Downloader.h
//  best
//
//  Created by Marin Usalj on 3/15/12.
//  Copyright (c) 2012 @mneorr | mneorr.com | linkedin.com/marin.usalj. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RequestPerformer;
@protocol RequestPerformerDelegate <NSObject>
- (void)requestFinishedByPerformer:(RequestPerformer *)downloader;
@end

@interface RequestPerformer : NSObject
@property(nonatomic, assign) BOOL verbose;

@property(nonatomic, assign) id delegate;
@property(nonatomic, readonly) NSData *downloadedData;
@property(nonatomic, readonly) NSString *downloadedString;


- (id)initWithDelegate:(id<RequestPerformerDelegate>)delegate;
- (void)downloadFromURL:(NSString *)URL; 
@end
