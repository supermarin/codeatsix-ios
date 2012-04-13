//
//  EventsViewController.m
//  codeatsix_ios
//
//  Created by Marin Usalj on 3/30/12.
//  Copyright (c) 2012 @mneorr | mneorr.com | linkedin.com/marin.usalj. All rights reserved.
//

#import "EventsViewController.h"
#import "Event.h"
#import "EventCell.h"
#import "Secretary.h"
#import "UserData.h"
#import "UIAlertView+SimplyShow.h"
#import "LoadingSpinner.h"

@interface EventsViewController () {
    IBOutlet UITableView *eventsTableview;
    IBOutlet LoadingSpinner *spinner;
    
    EventsManager *manager;
    NSArray *events;
}
@end

@implementation EventsViewController
@synthesize eventDateButton;
@synthesize eventTitleLabel;
@synthesize numberOfParticipantsLabel;
@synthesize eventDescriptionTextView;
@synthesize signUpButton;
@synthesize noEventsView;
static NSString *EVENT_CELL = @"EventCell";
static NSString *PERSON_DETAILS_SEGUE = @"EnterUserDetails";


#pragma mark - Private

- (NSArray *)upcomingEvents {
    @try {
        return [events subarrayWithRange:NSMakeRange(1, [events count] - 1)];
    }
    @catch (NSException *exception) {
        return 0;
    }
}

- (Event *)nextEvent {
    return [events objectAtIndex:0];
}

- (void)disableSignupButtonIfAlreadyApplied {
    signUpButton.enabled = YES;
    
    for (NSDictionary *person in [self nextEvent].persons) {
        
        if ([[person valueForKey:@"email"] isEqualToString:[[[UserData instance] personDictionary] valueForKey:@"email"]])
            signUpButton.enabled = NO;
    }
}

- (void)updateLabelsAndSignupButton {
    
    eventTitleLabel.text = [self nextEvent].title;
    numberOfParticipantsLabel.text = [NSString stringWithFormat:@"%i", [[self nextEvent].persons count]];
    eventDescriptionTextView.text = [self nextEvent].announcement;
    [eventDateButton setTitle:[self nextEvent].formattedEventDate forState:UIControlStateNormal];
    
    [self disableSignupButtonIfAlreadyApplied];
}

- (void)presentUserDetailsController {
    PersonDetailsViewController *controller = [[self storyboard] instantiateViewControllerWithIdentifier:@"PersonDetailsController"];
    
    [controller setDelegate:self];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Tableview datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:EVENT_CELL];
    
    [cell setEvent:[[self upcomingEvents] objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self upcomingEvents] count];
}
 

#pragma mark - Events Manager delegate

- (void)eventsManager:(EventsManager *)manager didRetrieveEvents:(NSArray *)theEvents {

    events = theEvents;
    
    if ([events count] > 0) {
        [eventsTableview reloadData];
        [self updateLabelsAndSignupButton];
        
        [UIView animateWithDuration:0.4 animations:^{
            [eventsTableview setAlpha:1];
            [noEventsView setAlpha:0];
        }];
    }
    
    else {
        [UIView animateWithDuration:0.4 animations:^{
            [noEventsView setAlpha:1];
            [eventsTableview setAlpha:0];
        }];
    }

    
    [spinner stopSpinning];
}

- (void)successfullyAppliedToEventWithMessage:(NSString *)message {
    [UIAlertView showWithTitle:@"" andMessage:message];
    
    signUpButton.enabled = NO;
}


#pragma mark - Person Details delegate

- (void)personDetailsHaveBeenStored {
    
    [manager signupOnEvent:[self nextEvent]];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    manager = [[EventsManager alloc] initWithDelegate:self];
    [spinner.titleLabel setText:@"Retrieving events..."];
    [spinner startSpinning];
}

- (void)viewDidUnload {
    [self setEventDateButton:nil];
    [self setEventTitleLabel:nil];
    [self setNumberOfParticipantsLabel:nil];
    [self setEventDescriptionTextView:nil];
    [self setSignUpButton:nil];
    [self setNoEventsView:nil];
    [super viewDidUnload];

    events = nil;
    manager = nil;
    eventsTableview = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [manager retrieveEvents];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Segues


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:PERSON_DETAILS_SEGUE])
        [(PersonDetailsViewController *)segue.destinationViewController setDelegate:self];
}


#pragma mark - IBActions


- (IBAction)signUpPressed:(id)sender {
    
    if ([[UserData instance] personDictionary])
        [manager signupOnEvent:[self nextEvent]];

    else
        [self presentUserDetailsController];
    
}

- (IBAction)addToCalendarPressed:(id)sender {
    
    [Secretary addToCalendar:[self nextEvent].title 
                   startDate:[self nextEvent].scheduled_at
                     endDate:[[self nextEvent].scheduled_at dateByAddingTimeInterval:7200]
                    location:@"Infinum, Odranska 1"];
}
@end
