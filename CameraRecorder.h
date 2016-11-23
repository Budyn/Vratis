//
//  CameraRecorder.h
//  Vratis
//
//  Created by Daniel Budynski on 16/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

@import AVFoundation;
#import <Foundation/Foundation.h>

@interface CameraRecorder : NSObject
@property (strong, nonatomic) AVCaptureSession *session;

@property (assign, nonatomic) BOOL isCameraAllowed;
@property (assign, nonatomic) BOOL isSetupSuccessful;

- (void)capturePhotoWithSettings:(AVCapturePhotoSettings *)settings withDelegate:(id<AVCapturePhotoCaptureDelegate>)delegate;

@end
