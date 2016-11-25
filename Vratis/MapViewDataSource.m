//
//  MapViewDataSource.m
//  Vratis
//
//  Created by Daniel Budynski on 24/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import "MapViewDataSource.h"
#import "MOMapPoint.h"
#import "NSError+Description.h"

@interface MapViewDataSource ()
@property (strong, nonatomic) NSManagedObjectContext *mapContext;

@end

@implementation MapViewDataSource
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initializeCoreDataStack];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (![defaults boolForKey:@"isMapUpdated"]) {
            [self createMapPoints];
            
            [defaults setBool:YES forKey:@"isMapUpdated"];
            [defaults synchronize];
        }
    }
    return self;
}

- (void)createMapPoints {
    NSArray *pointName = @[@"Stary Ratusz",
                           @"Galeria SkyTower",
                           @"Hala Stulecia",
                           @"Panorama Racławicka"];
    NSArray *pointLatitudeCooridnates = @[@51.109592,
                                          @51.109100,
                                          @51.106770,
                                          @51.110124];
    
    NSArray *pointLongitudeCooridnates = @[@17.032059,
                                          @17.018584,
                                          @17.077211,
                                          @17.044373];
    
    
    for (NSUInteger index = 0; index < pointName.count; index = index + 1) {
        MOMapPoint *point = [NSEntityDescription insertNewObjectForEntityForName:@"POI" inManagedObjectContext:self.mapContext];
        point.name = [pointName objectAtIndex:index];
        point.latitude = [[pointLatitudeCooridnates objectAtIndex:index] doubleValue];
        point.longitude = [[pointLongitudeCooridnates objectAtIndex:index] doubleValue];
        [self saveContext];
    }
}

#pragma mark Core Data Stack
- (void)initializeCoreDataStack {
    // NSManagedObjectModel
    NSURL *mapModelURL = [[NSBundle mainBundle] URLForResource:@"MapModel" withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:mapModelURL];
    
    //NSPersistantCordinator
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    //NSManagedObjectContext
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    context.persistentStoreCoordinator = coordinator;
    self.mapContext = context;
    
    // Document Directory
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsURL = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *persistantStoreURL = [documentsURL URLByAppendingPathComponent:@"MapModel.sqlite"];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        NSError *error = nil;
        NSPersistentStoreCoordinator * coordinator = [self.mapContext persistentStoreCoordinator];
        NSPersistentStore *store = [coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                             configuration:nil
                                                                       URL:persistantStoreURL
                                                                   options:nil
                                                                     error:&error];
        NSAssert(store != nil, @"Error initializing PSC: %@\n%@", [error localizedDescription], [error userInfo]);
    });
}

- (void)saveContext {
    NSError * __autoreleasing error = nil;
    if ([self.mapContext save:&error] == NO) {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    }
}

- (NSArray <MapPoint *> *)fetchMapPoints {
    NSError * __autoreleasing error = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"POI"];
    NSArray *fetchResults = [self.mapContext executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *pointArray = [NSMutableArray array];
    for (MapPoint *point in fetchResults) {
        [pointArray addObject:point];
    }
    
    if (error) {
        [error fullDescription];
    }
    return [NSArray arrayWithArray:pointArray];
}

@end
