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

@interface DatabaseTableDataSource()
@property (strong, nonatomic) PHFetchResult <PHAsset *> *fetchResult;
@end

@implementation DatabaseTableDataSource

- (void)performFetch: (void (^)(NSError* error))completion {
    __block NSError *error = nil;
    
    [PHPhotoLibrary requestAuthorization:^( PHAuthorizationStatus status ) {
        if ( status == PHAuthorizationStatusAuthorized ) {
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
                fetchOptions.predicate = [NSPredicate predicateWithFormat:@"title = %@", @"Database"];
                
                PHAssetCollection *collection = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum
                                                                                         subtype:PHAssetCollectionSubtypeAny
                                                                                         options:fetchOptions].firstObject;
                self.fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
                completion(error);
            } completionHandler:^( BOOL success, NSError * _Nullable error ) {
                if (!success) {
                    completion(error);
                }
            }];
        } else {
            error = [NSError errorWithDomain:NSOSStatusErrorDomain code:0 userInfo:@{@"description:" : @"Access to PHPhotoLibrary failed"}];
            completion(error);
        }
    }];
}

#pragma mark UITableDataViewSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fetchResult.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DatabaseTableCell *cell = (DatabaseTableCell *)[tableView dequeueReusableCellWithIdentifier:@"databaseTC"];
    
    PHAsset *asset = [self.fetchResult objectAtIndex:indexPath.row];
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.normalizedCropRect = CGRectMake(0, 0, 100, 100);
    
    CGSize rect = CGSizeMake(100.0, 100.0);
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:rect contentMode:PHImageContentModeAspectFit options:options resultHandler:^void(UIImage *image, NSDictionary *info) {
        
        cell.thumbnailPhoto.image = image;
    }];
    
    return cell;
}

@end
