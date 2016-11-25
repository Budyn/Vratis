//
//  MapPoint.m
//  Vratis
//
//  Created by Daniel Budynski on 25/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import "MapPoint.h"

@implementation MapPoint
- (instancetype)initWithMapPointWithName:(NSString *)name latitude:(double)latitude longitude:(double)longitude {
    self = [super init];
    if (self) {
        _name = name;
        _latitude = latitude;
        _longitude = longitude;
    }
    return self;
}

@end
