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
@property (strong, nonatomic) NSArray <MapPoint *> *pointArray;

@end

@implementation MapView

- (void)awakeFromNib {
    [super awakeFromNib];
    CLLocationCoordinate2D wroclawLocation = CLLocationCoordinate2DMake(wroclawLatitude, wroclawLongitude);
    MKCoordinateRegion wroclawRegion = MKCoordinateRegionMakeWithDistance(wroclawLocation, 1000, 1000);
    self.map.region = wroclawRegion;
    
    self.mapSource = [[MapViewDataSource alloc] init];
    self.pointArray = [self.mapSource fetchMapPoints];
    
    for (MapPoint *point in self.pointArray) {
        CLLocationCoordinate2D pinLocation = CLLocationCoordinate2DMake([point latitude], [point longitude]);
        MKPointAnnotation *pinPoint = [[MKPointAnnotation alloc] init];
        pinPoint.title = [point name];
        pinPoint.coordinate = pinLocation;
        [self.map addAnnotation:pinPoint];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
