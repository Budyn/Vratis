//
//  MapViewController.m
//  Vratis
//
//  Created by Daniel Budynski on 22/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

@import CoreLocation;

#import "MapViewController.h"
#import "MapView.h"
#import "MapViewDataSource.h"

#import "NSError+Description.h"
#import "NotificationString.h"

@interface MapViewController () <CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet MapView *mapView;
@property (strong, nonatomic) MapViewDataSource *dataSource;
//@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation MapViewController
- (void)dealloc {
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _dataSource = [[MapViewDataSource alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMap) name:mapDataSourceHasChange object:nil];
//    self.locationManager = [[CLLocationManager alloc] init];
//    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    self.locationManager.distanceFilter = 50;
//    
//    self.locationManager.delegate = self;
//    
//    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
//        [self.locationManager requestWhenInUseAuthorization];
//    }
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(photoCreated) name:@"photoCreated" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.mapView updateMapWithPoints:self.dataSource.mapPoints];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.mapView removeFromSuperview];
}
//- (void)photoCreated {
//    [self.locationManager requestLocation];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Setters & Getters
- (MapView *)mapView {
    return (MapView *)self.view;
}

#pragma mark Notifications handling
- (void)updateMap {
    NSArray <MapPoint *> *points = self.dataSource.mapPoints;
    [self.mapView updateMapWithPoints:points];
}

//#pragma mark CLLoactionManagerDelegate
//- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
//        [defaults setBool:YES forKey:@"isGPSAllowed"];
//        //[self.locationManager startUpdatingLocation];
//    } else {
//        [defaults setBool:NO forKey:@"isGPSAllowed"];
//        //[self.locationManager stopUpdatingLocation];
//    }
//    [defaults synchronize];
//}
//
//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
//    [self.mapView addAnnotationForLocation:[locations lastObject] name:@"Photo created!"];
//}
//
//- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
//    [error fullDescription];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
