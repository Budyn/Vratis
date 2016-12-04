//
//  PhotoCaptureDelegate.m
//  Vratis
//
//  Created by Daniel Budynski on 12/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//
@import Photos;
#import "PhotoCaptureDelegate.h"
#import "Recognizer.h"

@interface PhotoCaptureDelegate()
@property (strong, nonatomic, readwrite) AVCapturePhotoSettings *requestedPhotoSettings;
@property (strong, nonatomic) void (^willCapturePhotoAnimation)();
@property (strong, nonatomic) void (^completed)(PhotoCaptureDelegate *photoCaptureDelegate);

@property (strong, nonatomic) NSData *photoData;
@property (strong, nonatomic) UIImage *greyImage;

@end

@implementation PhotoCaptureDelegate

- (instancetype)initWithRequestedPhotoSettings:(AVCapturePhotoSettings *)requestedPhotoSettings
                     willCapturePhotoAnimation:(void (^)())willCapturePhotoAnimation
                                     completed:(void (^)(PhotoCaptureDelegate *))completed {
    self = [super init];
    if (self) {
        self.requestedPhotoSettings = requestedPhotoSettings;
        self.willCapturePhotoAnimation = willCapturePhotoAnimation;
        self.completed = completed;
    }
    return self;
}

- (void)didFinish {
    self.completed( self );
}

- (void)captureOutput:(AVCapturePhotoOutput *)captureOutput willCapturePhotoForResolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings {
    self.willCapturePhotoAnimation();
}

- (void)captureOutput:(AVCapturePhotoOutput *)captureOutput didFinishProcessingPhotoSampleBuffer:(CMSampleBufferRef)photoSampleBuffer previewPhotoSampleBuffer:(CMSampleBufferRef)previewPhotoSampleBuffer resolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings bracketSettings:(AVCaptureBracketedStillImageSettings *)bracketSettings error:(NSError *)error
{
    if ( error != nil ) {
        NSLog( @"Error capturing photo: %@", error );
        return;
    }
    
    self.photoData = [AVCapturePhotoOutput JPEGPhotoDataRepresentationForJPEGSampleBuffer:photoSampleBuffer previewPhotoSampleBuffer:previewPhotoSampleBuffer];
}

- (void)captureOutput:(AVCapturePhotoOutput *)captureOutput didFinishCaptureForResolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings error:(NSError *)error {
    if (error) {
        NSLog( @"Error capturing photo: %@", error );
        [self didFinish];
        return;
    }
    if (!self.photoData) {
        NSLog( @"No photo data resource" );
        [self didFinish];
        return;
    }
    
    NSString *recognizedObjectString = [[Recognizer sharedInstance] recognizeImage:[UIImage imageWithData:self.photoData]];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Success" message:[NSString stringWithFormat:@"It is %@", recognizedObjectString] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    
    [self saveCreatedPhoto];
}

- (void)saveCreatedPhoto {
    [PHPhotoLibrary requestAuthorization:^( PHAuthorizationStatus status ) {
        if ( status == PHAuthorizationStatusAuthorized ) {
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                // TODO: HANDLE DELETION OF THE FOLDER
                PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
                fetchOptions.predicate = [NSPredicate predicateWithFormat:@"title = %@", @"Vratis"];
                PHAssetCollection *collection = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum
                                                                                         subtype:PHAssetCollectionSubtypeAny
                                                                                         options:fetchOptions].firstObject;
                
                PHAssetChangeRequest *creationRequest = [PHAssetCreationRequest creationRequestForAssetFromImage:[UIImage imageWithData:self.photoData]];
                PHObjectPlaceholder *placeholder = creationRequest.placeholderForCreatedAsset;
                
                PHFetchResult *photosAsset = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
                
                PHAssetCollectionChangeRequest *albumChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection
                                                                                                                              assets:photosAsset];
                [albumChangeRequest addAssets:@[placeholder]];
                
            } completionHandler:^( BOOL success, NSError * _Nullable error ) {
                if (!success) {
                    NSLog( @"Error occurred while saving photo to photo library: %@", error );
                }
                
                [self didFinish];
            }];
        }
        else {
            NSLog( @"Not authorized to save photo" );
            [self didFinish];
        }
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
