//
//  PersonDetailsViewController.h
//  codeatsix_ios
//
//  Created by Marin Usalj on 4/2/12.
//  Copyright (c) 2012 @mneorr | mneorr.com | linkedin.com/marin.usalj. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PersonDetailsDelegate <NSObject>
- (void)personDetailsHaveBeenStored;
@end

@interface PersonDetailsViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *firstNameField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;

@property (assign, nonatomic) id<PersonDetailsDelegate> delegate;

@end
