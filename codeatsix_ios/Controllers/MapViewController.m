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

- (UIButton *)setUpRightCalloutAccessoryButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [button addTarget:self action:@selector(getDirectionsPressed:) forControlEvents:UIControlEventTouchUpInside];
    return button;
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
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}


#pragma mark - MKMapView delegate

- (void)mapView:(MKMapView *)theMapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view.annotation isEqual:mapView.userLocation]) return;
    
    view.rightCalloutAccessoryView = [self setUpRightCalloutAccessoryButton];
}

#pragma mark - IBActions

- (IBAction)getDirectionsPressed:(id)sender {
    NSString* url = [NSString stringWithFormat: @"http://maps.google.com/maps?daddr=%f,%f&saddr='Current Location'",                   
                     infinumLocation.coordinate.latitude, infinumLocation.coordinate.longitude];
    
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:
                                                 [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
}

@end
