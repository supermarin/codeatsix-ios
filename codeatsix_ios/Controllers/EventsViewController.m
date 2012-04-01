//
//  FirstViewController.m
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
static NSString *EVENT_CELL = @"EventCell";

#pragma mark - Private

- (NSArray *)createEventsFromDictionaries:(NSArray *)eventsInDicts {
    NSMutableArray *allEvents = [NSMutableArray new];
    
    for (NSDictionary *eventInDict in eventsInDicts)
        [allEvents addObject:[[Event alloc] initWithDictionary:eventInDict]];
    
    return allEvents;
}

- (NSArray *)upcomingEvents {
    return [events subarrayWithRange:NSMakeRange(1, [events count])];
}

- (Event *)nextEvent {
    return [events objectAtIndex:0];
}

- (void)updateLabels {
    eventTitleLabel.text = [self nextEvent].title;
    numberOfParticipantsLabel.text = [NSString stringWithFormat:@"%i", [[self nextEvent].persons count]];
}

#pragma mark - Tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Tableview datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:EVENT_CELL];
    
    [cell setEvent:[events objectAtIndex:indexPath.section]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [events count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


#pragma mark - Request performer delegate

- (void)requestFinishedByPerformer:(RequestPerformer *)downloader {

    events = [self createEventsFromDictionaries:[[[downloader downloadedString] objectFromJSONString] valueForKey:@"events"]];
    [eventsTableview reloadData];
    [self updateLabels];
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
    [(EventDetailsViewController *)segue.destinationViewController 
     setEvent:[events objectAtIndex:[eventsTableview indexPathForSelectedRow].row]];
}


#pragma mark - IBActions

- (IBAction)signUpPressed:(id)sender {
}
@end
