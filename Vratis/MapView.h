//
//  MapView.h
//  Vratis
//
//  Created by Daniel Budynski on 22/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

@import CoreLocation;
#import "MapPoint.h"

@interface MapView : UIView
- (void)updateMapWithPoints:(NSArray <MapPoint *> *)points;

@end
