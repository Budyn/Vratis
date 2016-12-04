//
//  DatabaseTableDataSource.m
//  Vratis
//
//  Created by Daniel Budynski on 30/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

@import Photos;

#import "DatabaseTableDataSource.h"
#import "DatabaseTableCell.h"

#import "RecognizerDataSource.h"

@interface DatabaseTableDataSource()
@property (strong, nonatomic) RecognizerDataSource *recognizerDataSource;
@end

@implementation DatabaseTableDataSource
- (instancetype) init {
    self = [super init];
    if (self) {
        _recognizerDataSource = [[RecognizerDataSource alloc] init];
    }
    return self;
}

- (void)fetch:(void (^)(NSError *error))completion {
    [self.recognizerDataSource performFetch:^(NSError *error){
        completion(error);
    }];
}

#pragma mark UITableDataViewSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recognizerDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DatabaseTableCell *cell = (DatabaseTableCell *)[tableView dequeueReusableCellWithIdentifier:@"databaseTC"];
    
    PHAsset *asset = [self.recognizerDataSource assetForIndex:indexPath.row];
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.normalizedCropRect = CGRectMake(0, 0, 100, 100);
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    
    CGSize rect = CGSizeMake(100.0, 100.0);
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:rect contentMode:PHImageContentModeAspectFill options:options resultHandler:^void(UIImage *image, NSDictionary *info) {
        
        cell.thumbnailPhoto.image = image;
    }];
    
    return cell;
}

@end
