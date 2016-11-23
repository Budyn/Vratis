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

#define wroclawLatitude 51.1098244
#define wroclawLongitude 17.0290703

@interface MapView() <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *map;

@end

@implementation MapView

- (void)awakeFromNib {
    [super awakeFromNib];
    CLLocationCoordinate2D wroclawLocation = CLLocationCoordinate2DMake(wroclawLatitude, wroclawLongitude);
    MKCoordinateRegion wroclawRegion = MKCoordinateRegionMakeWithDistance(wroclawLocation, 1000, 1000);
    self.map.region = wroclawRegion;
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = wroclawLocation;
    point.title = @"Plac Solny";

    [self.map addAnnotation:point];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
