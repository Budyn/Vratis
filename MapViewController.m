//
//  MapViewController.m
//  Vratis
//
//  Created by Daniel Budynski on 22/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import "MapViewController.h"
#import "MapView.h"
#import "MapViewDataSource.h"

#import "NSError+Description.h"
#import "NotificationString.h"

@interface MapViewController () <CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet MapView *mapView;
@property (strong, nonatomic) MapViewDataSource *dataSource;

@end

@implementation MapViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [[MapViewDataSource alloc] initWithContext:self.mapContext];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMap) name:mapDataSourceHasChange object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.mapView updateMapWithPoints:self.dataSource.mapPoints];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.mapView removeFromSuperview];
}

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
