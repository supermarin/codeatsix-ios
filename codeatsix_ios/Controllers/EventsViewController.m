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

@interface EventsViewController () {
    IBOutlet UITableView *eventsTableview;
    RequestPerformer *performer;
    NSArray *events;
}
@end

@implementation EventsViewController
static NSString *EVENT_CELL = @"EventCell";

#pragma mark - Private

- (NSArray *)createEventsFromDictionaries:(NSArray *)eventsInDicts {
    NSMutableArray *allEvents = [NSMutableArray new];
    
    for (NSDictionary *eventInDict in eventsInDicts)
        [allEvents addObject:[[Event alloc] initWithDictionary:eventInDict]];
    
    return allEvents;
}




#pragma mark - Tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Tableview datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:EVENT_CELL];
    
    [cell setEvent:[events objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [events count];
}

#pragma mark - Request performer delegate

- (void)requestFinishedByPerformer:(RequestPerformer *)downloader {

    events = [self createEventsFromDictionaries:[[downloader downloadedString] objectFromJSONString]];
    [eventsTableview reloadData];
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    performer = [[RequestPerformer alloc] initWithDelegate:self];
}

- (void)viewDidUnload {
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


@end
