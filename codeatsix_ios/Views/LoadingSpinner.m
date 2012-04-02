//
//  LoadingSpinner.m
//  YourDiscount
//
//  Created by Marin on 8/22/11.
//  Copyright (c) 2012 @mneorr | mneorr.com | linkedin.com/marin.usalj. All rights reserved.
//
#import "LoadingSpinner.h"
#import <QuartzCore/QuartzCore.h>

@implementation LoadingSpinner
@synthesize titleLabel;


- (void)setUp {
    self.alpha = 0.75;
    self.backgroundColor = [UIColor blackColor];
    [[self layer] setCornerRadius:8];
    [[self layer] setMasksToBounds:YES];
    
    CGRect labelFrame = CGRectMake(0, 
                                   0, 
                                   self.frame.size.width, 
                                   self.frame.size.height/2);
    
    titleLabel = [[UILabel alloc] initWithFrame:labelFrame];
    self.titleLabel.userInteractionEnabled = NO;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = UITextAlignmentCenter;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.text = @"Loading..";
    
    CGRect activityRect = CGRectMake((self.frame.size.width/2) - 23, 
                                     (self.titleLabel.frame.size.height/2) + 20, 
                                     37, 
                                     37);
    
    activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:activityRect];
    activityIndicatorView.hidesWhenStopped = YES;
    activityIndicatorView.userInteractionEnabled = NO;
    activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self setUp];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (!self) return nil;
    
    [self setUp];    
    
    return self;
}

- (void)drawRect:(CGRect)rect {

	[self insertSubview:self.titleLabel atIndex:0];
	[self insertSubview:activityIndicatorView atIndex:1];
}


-(void) startSpinning {
    [self setHidden:NO];
    [activityIndicatorView startAnimating];
}

-(void) stopSpinning {
    [self setHidden:YES];
    [activityIndicatorView stopAnimating];
}


@end
