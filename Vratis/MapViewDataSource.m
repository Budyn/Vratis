//
//  MapViewDataSource.m
//  Vratis
//
//  Created by Daniel Budynski on 24/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import "MapViewDataSource.h"
#import "MapPoint.h"
#import "NSError+Description.h"

@interface MapViewDataSource () <NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSFetchedResultsController *fetchController;
@property (strong, nonatomic) NSManagedObjectContext *mapContext;
@property (strong, nonatomic) dispatch_queue_t fetchQueue;

@end

@implementation MapViewDataSource
- (instancetype)initWithContext:(NSManagedObjectContext *)mapContext {
    self = [super init];
    if (self) {
        _fetchQueue = dispatch_queue_create("fetch-queue", DISPATCH_QUEUE_SERIAL);
        _mapPoints = [NSArray array];
        _mapContext = mapContext;
        
        dispatch_sync(_fetchQueue, ^{
            [self createMapPoints];
            [self initizalizeFetchResultController];
            [self performInitialFetch];
        });
    }
    return self;
}

- (void)createMapPoints {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isMapFirstLaunched"]) {
        NSAssert(_mapContext, @"Context is not initialized. I am not able add new objects to DB.");
        
        NSArray *pointName = @[@"Stary Ratusz",
                               @"Galeria SkyTower",
                               @"Hala Stulecia",
                               @"Panorama Racławicka"];
        
        NSArray *pointLatitudeCooridnates = @[@51.109592,
                                              @51.094696,
                                              @51.106770,
                                              @51.110124];
        
        NSArray *pointLongitudeCooridnates = @[@17.032059,
                                              @17.019061,
                                              @17.077211,
                                              @17.044373];
        
        for (NSUInteger i = 0; i < pointName.count; i++) {
            MapPoint *point = [NSEntityDescription insertNewObjectForEntityForName:@"MapPoint" inManagedObjectContext:self.mapContext];
            point.name = [pointName objectAtIndex:i];
            point.latitude = [[pointLatitudeCooridnates objectAtIndex:i] doubleValue];
            point.longitude = [[pointLongitudeCooridnates objectAtIndex:i] doubleValue];
        }
        
        [self saveContext];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isMapFirstLaunched"];
    }
}

#pragma mark Core Data
- (void)saveContext {
    NSError * __autoreleasing error = nil;
    if (![_mapContext save:&error]) {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    }
}

- (void)initizalizeFetchResultController {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    request.entity = [NSEntityDescription entityForName:@"MapPoint" inManagedObjectContext:self.mapContext];
    request.sortDescriptors = @[sortDescriptor];

    NSFetchedResultsController *fetchResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                                            managedObjectContext:self.mapContext
                                                                                              sectionNameKeyPath:nil
                                                                                                        cacheName:@"mapCache"];
    fetchResultController.delegate = self;
    _fetchController = fetchResultController;
}

- (BOOL)performInitialFetch {
    NSAssert(_fetchController, @"Fetch controller is not initialized");
    BOOL fetchFailed = YES;
    NSError * __autoreleasing error = nil;
    if (![_fetchController performFetch:&error]) {
        [error fullDescription];
    } else {
        // Updated public interface
        _mapPoints = _fetchController.fetchedObjects;
        fetchFailed = NO;
    }
    return fetchFailed;
}

#pragma mark NSFetchedResultsController
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    if (controller.fetchedObjects.count <= 0) {
        NSLog(@"Map source is now empty. I am not going to update map points.");
    } else {
        self.mapPoints = controller.fetchedObjects;
    }
}

@end
