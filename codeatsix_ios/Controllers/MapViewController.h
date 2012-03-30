//
//  MapViewController.h
//  codeatsix_ios
//
//  Created by Marin Usalj on 3/30/12.
//  Copyright (c) 2012 @mneorr | mneorr.com | linkedin.com/marin.usalj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
