//
//  MapViewDataSource.h
//  Vratis
//
//  Created by Daniel Budynski on 24/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

@import Foundation;
@import CoreData;
#import "MapPoint.h"

@interface MapViewDataSource : NSObject
@property (strong, nonatomic) NSArray <MapPoint *> *mapPoints;

- (instancetype)initWithContext:(NSManagedObjectContext *)mapContext;
@end
