//
//  MOMapPoint.h
//  Vratis
//
//  Created by Daniel Budynski on 24/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface MOMapPoint : NSManagedObject
@property (assign, nonatomic) double latitude;
@property (assign, nonatomic) double longitude;
@property (strong, nonatomic) NSString *name;

@end
