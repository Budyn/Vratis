//
//  MapViewController.h
//  Vratis
//
//  Created by Daniel Budynski on 22/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

@import CoreData;
@import UIKit;
#import "Page.h"

@interface MapViewController : Page
@property (strong, nonatomic) NSManagedObjectContext *mapContext;

@end
