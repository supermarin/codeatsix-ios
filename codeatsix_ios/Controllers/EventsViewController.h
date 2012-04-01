//
//  FirstViewController.h
//  codeatsix_ios
//
//  Created by Marin Usalj on 3/30/12.
//  Copyright (c) 2012 @mneorr | mneorr.com | linkedin.com/marin.usalj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestPerformer.h"

@interface EventsViewController : UIViewController<RequestPerformerDelegate, UITableViewDelegate, UITableViewDataSource>


@property (strong, nonatomic) IBOutlet UIButton *eventDateButton;
@property (strong, nonatomic) IBOutlet UILabel *eventTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberOfParticipantsLabel;


- (IBAction)signUpPressed:(id)sender;

@end
