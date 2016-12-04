//
//  RecognizerDataSource.m
//  Vratis
//
//  Created by Daniel Budynski on 03/12/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import "RecognizerDataSource.h"

#import "NSError+Description.h"

@interface RecognizerDataSource()
@property (strong, nonatomic) PHFetchResult <PHAsset *> *fetchResult;

@end

@implementation RecognizerDataSource

#pragma mark Setters & Getters
- (NSUInteger)count {
    return (self.fetchResult) ? self.fetchResult.count : 0;
}

- (PHAsset *)assetForIndex:(NSUInteger)index {
    return [self.fetchResult objectAtIndex:index];
}
- (UIImage *)imageForIndex:(NSUInteger)index {
    PHAsset *asset = [self.fetchResult objectAtIndex:index];
    __block UIImage *assetImage = nil;
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    CGSize size = CGSizeMake(1920, 1080);
    [[PHImageManager defaultManager] requestImageForAsset:asset
                                               targetSize:size
                                              contentMode:PHImageContentModeDefault
                                                  options:options
                                            resultHandler:^void(UIImage *image, NSDictionary *info) {
                                                assetImage = image;
                                            }];
    return assetImage;
}

- (void)performFetch:(void (^)(NSError* error))completion {
    __block NSError *error = nil;
    
    [PHPhotoLibrary requestAuthorization:^( PHAuthorizationStatus status ) {
        if ( status == PHAuthorizationStatusAuthorized ) {
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
                fetchOptions.predicate = [NSPredicate predicateWithFormat:@"title = %@", @"Database"];
                
                PHAssetCollection *collection = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum
                                                                                         subtype:PHAssetCollectionSubtypeAny
                                                                                         options:fetchOptions].firstObject;
                _fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
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

@end
