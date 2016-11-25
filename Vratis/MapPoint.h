//
//  MapPoint.h
//  Vratis
//
//  Created by Daniel Budynski on 25/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface MapPoint : NSObject
@property (assign, nonatomic) double latitude;
@property (assign, nonatomic) double longitude;
@property (strong, nonatomic) NSString *name;

- (instancetype)initWithMapPointWithName:(NSString *)name latitude:(double)latitude longitude:(double)longitude;
@end
