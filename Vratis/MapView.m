//
//  MapView.m
//  Vratis
//
//  Created by Daniel Budynski on 22/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

@import MapKit;
@import UIKit;
#import "MapView.h"
#import "MapPoint.h"

#define wroclawLatitude 51.1098244
#define wroclawLongitude 17.0290703

@interface MapView() <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *map;

@end

@implementation MapView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self formMapCenterPosition];
    self.map.delegate = self;
}

- (void)formMapCenterPosition {
    CLLocationCoordinate2D cityLocation = CLLocationCoordinate2DMake(wroclawLatitude, wroclawLongitude);
    MKCoordinateRegion cityRegion = MKCoordinateRegionMakeWithDistance(cityLocation, 1000, 1000);
    _map.region = cityRegion;
}

#pragma mark Map Update
- (void)updateMapWithPoints:(NSArray<MapPoint *> *)points {
    if (points.count > 0) {
        for (MapPoint *point in points) {
            CLLocationCoordinate2D pointLocation = CLLocationCoordinate2DMake(point.latitude, point.longitude);
            MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
            pin.coordinate = pointLocation;
            pin.title = point.name;
            [self.map addAnnotation:pin];
        }
    } else {
        NSLog(@"Map points array is empty.");
    }
}

#pragma mark MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] init];
    annotationView.pinTintColor = [UIColor whiteColor];
    return annotationView;
}

@end
