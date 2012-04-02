//
//  EventCell.h
//  codeatsix_ios
//
//  Created by Marin Usalj on 3/30/12.
//  Copyright (c) 2012 @mneorr | mneorr.com | linkedin.com/marin.usalj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Event;

@interface EventCell : UITableViewCell

@property(strong, nonatomic) Event *event;
@property(strong, nonatomic) IBOutlet UILabel *eventTitleLabel;
@property(strong, nonatomic) IBOutlet UILabel *personsCountLabel;
@property(strong, nonatomic) IBOutlet UILabel *eventDateLabel;
@end
