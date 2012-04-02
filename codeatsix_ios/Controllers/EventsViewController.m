//
//  EventsViewController.m
//  codeatsix_ios
//
//  Created by Marin Usalj on 3/30/12.
//  Copyright (c) 2012 @mneorr | mneorr.com | linkedin.com/marin.usalj. All rights reserved.
//

#import "EventsViewController.h"
#import "Server.h"
#import "Event.h"
#import "JSONKit.h"
#import "EventCell.h"
#import "EventDetailsViewController.h"
#import "Secretary.h"
#import "ASIFormDataRequest.h"
#import "UserData.h"
#import "UIAlertView+SimplyShow.h"

@interface EventsViewController () {
    IBOutlet UITableView *eventsTableview;
    RequestPerformer *performer;
    NSArray *events;
}
@end

@implementation EventsViewController
@synthesize eventDateButton;
@synthesize eventTitleLabel;
@synthesize numberOfParticipantsLabel;
@synthesize eventDescriptionTextView;
@synthesize signUpButton;
static NSString *EVENT_CELL = @"EventCell";
static NSString *PERSON_DETAILS_SEGUE = @"EnterUserDetails";

#pragma mark - Private

- (NSArray *)createEventsFromDictionaries:(NSArray *)eventsInDicts {
    NSMutableArray *allEvents = [NSMutableArray new];
    
    for (NSDictionary *eventInDict in eventsInDicts)
        [allEvents addObject:[[Event alloc] initWithDictionary:eventInDict]];
    
    return allEvents;
}

- (NSArray *)upcomingEvents {
    @try {
        return [events subarrayWithRange:NSMakeRange(1, [events count])];
    }
    @catch (NSException *exception) {
        return 0;
    }
}

- (Event *)nextEvent {
    return [events objectAtIndex:0];
}

- (void)disableSignupButtonIfAlreadyApplied {
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


- (NSDictionary *)params {
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:[self nextEvent].event_id forKey:@"event_id"];
    [params setValue:[[UserData instance] personDictionary] forKey:@"person"];
    
    return params;
}

- (void)postEventApplicationToServer {
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[Server signupURL]]];
    [request addRequestHeader: @"Content-Type" value: @"application/json; charset=utf-8"];
    
    [request appendPostData:[[self params].JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setDelegate:self];
    [request startAsynchronous];
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
    
    [cell setEvent:[[self upcomingEvents] objectAtIndex:indexPath.section]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self upcomingEvents] count];
}


#pragma mark - Request performer delegate

- (void)requestFinishedByPerformer:(RequestPerformer *)downloader {

    events = [self createEventsFromDictionaries:
              [[[downloader downloadedString] objectFromJSONString] valueForKey:@"events"]];

    [eventsTableview reloadData];
    [self updateLabelsAndSignupButton];
    
    [UIView animateWithDuration:0.4 animations:^{
        [eventsTableview setAlpha:1];
    }];
}


#pragma mark - ASIHTTP delegate

- (void)requestFinished:(ASIHTTPRequest *)request {
    [UIAlertView showWithTitle:@"" 
                    andMessage:[[[request responseString] objectFromJSONString] valueForKey:@"message"]];

    NSLog(@"response: %@", [request responseString]);
}


#pragma mark - Person Details delegate

- (void)personDetailsHaveBeenStored {
    
    [self postEventApplicationToServer];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    performer = [[RequestPerformer alloc] initWithDelegate:self];
}

- (void)viewDidUnload {
    [self setEventDateButton:nil];
    [self setEventTitleLabel:nil];
    [self setNumberOfParticipantsLabel:nil];
    [self setEventDescriptionTextView:nil];
    [self setSignUpButton:nil];
    [super viewDidUnload];

    events = nil;
    performer = nil;
    eventsTableview = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [performer downloadFromURL:[Server eventsURL]];
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
    
    else
        [(EventDetailsViewController *)segue.destinationViewController 
            setEvent:[events objectAtIndex:[eventsTableview indexPathForSelectedRow].row]];
}


#pragma mark - IBActions


- (IBAction)signUpPressed:(id)sender {
    
    if ([[UserData instance] personDictionary])
        [self postEventApplicationToServer];

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
