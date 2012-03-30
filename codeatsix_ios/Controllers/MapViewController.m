//
//  MapViewController.m
//  codeatsix_ios
//
//  Created by Marin Usalj on 3/30/12.
//  Copyright (c) 2012 @mneorr | mneorr.com | linkedin.com/marin.usalj. All rights reserved.
//

#import "MapViewController.h"
#import "MeetupLocation.h"

@interface MapViewController () {
    MeetupLocation *infinumLocation;
}
@end

@implementation MapViewController
@synthesize mapView;


#pragma mark - Private

- (void)centerTheMapAroundInfinum {
    
    mapView.region = 
    MKCoordinateRegionMake(infinumLocation.coordinate, 
                           MKCoordinateSpanMake(0.008, 0.008));
    
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    infinumLocation = [MeetupLocation new];
    [self centerTheMapAroundInfinum];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [mapView addAnnotation:infinumLocation];
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    infinumLocation = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
