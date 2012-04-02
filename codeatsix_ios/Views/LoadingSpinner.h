//
//  LoadingSpinner.h
//  YourDiscount
//
//  Created by Marin on 8/22/11.
//  Copyright (c) 2012 @mneorr | mneorr.com | linkedin.com/marin.usalj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadingSpinner : UIView {
    UIActivityIndicatorView *activityIndicatorView;
}

@property (nonatomic, readonly) UILabel *titleLabel;

-(void) startSpinning;
-(void) stopSpinning;

@end
