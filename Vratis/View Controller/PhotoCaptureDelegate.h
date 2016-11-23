//
//  PhotoCaptureDelegate.h
//  Vratis
//
//  Created by Daniel Budynski on 12/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//
@import AVFoundation;
#import <UIKit/UIKit.h>

@interface PhotoCaptureDelegate : NSObject <AVCapturePhotoCaptureDelegate>
- (instancetype)initWithRequestedPhotoSettings:(AVCapturePhotoSettings *) requestedPhotoSettings
                     willCapturePhotoAnimation:(void (^)()) willCapturePhotoAnimation
                                     completed:(void (^)(PhotoCaptureDelegate *photoCaptureDelegate)) completed;

@property (nonatomic, readonly) AVCapturePhotoSettings *requestedPhotoSettings;
@property (nonatomic) UIImage *dataImage;

@end
