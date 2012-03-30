//
//  MapViewController.m
//  codeatsix_ios
//
//  Created by Marin Usalj on 3/30/12.
//  Copyright (c) 2012 @mneorr | mneorr.com | linkedin.com/marin.usalj. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize mapView;


#pragma mark - Private

- (CLLocationCoordinate2D)infinumLocation {
    
    return CLLocationCoordinate2DMake(45.792784, 15.962706);
}

- (void)centerTheMapAroundInfinum {
    
    mapView.region = 
    MKCoordinateRegionMake([self infinumLocation], 
                           MKCoordinateSpanMake(0.008, 0.008));
    
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self centerTheMapAroundInfinum];
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
