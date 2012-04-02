//
//  PersonDetailsViewController.m
//  codeatsix_ios
//
//  Created by Marin Usalj on 4/2/12.
//  Copyright (c) 2012 @mneorr | mneorr.com | linkedin.com/marin.usalj. All rights reserved.
//

#import "PersonDetailsViewController.h"
#import "UserData.h"

@implementation PersonDetailsViewController

@synthesize firstNameField;
@synthesize lastNameField;
@synthesize emailField;
@synthesize delegate;

#pragma mark - Private

- (UIBarButtonItem *)sendButtonItem {
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
                                                         target:self 
                                                         action:@selector(sendPressed:)];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setRightBarButtonItem:[self sendButtonItem]];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - TextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == emailField) 
        [self sendPressed:textField];
    
    return YES;
}


#pragma mark - Public



#pragma mark - IBActions

- (void)sendPressed:(id)sender {
    if (firstNameField.text.length < 1 ||
        lastNameField.text.length < 1 ||
        emailField.text.length < 1) return;
    
    [[UserData instance] storePersonFirstName:firstNameField.text lastName:lastNameField.text email:emailField.text];
    
    [self.delegate personDetailsHaveBeenStored];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidUnload {
    [self setFirstNameField:nil];
    [self setLastNameField:nil];
    [self setEmailField:nil];
    [super viewDidUnload];
}
@end
