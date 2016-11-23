//
//  MediaRecorder.h
//  Vratis
//
//  Created by Daniel Budynski on 15/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

@import AVFoundation;
#import <Foundation/Foundation.h>

@interface MediaRecorder : NSObject
- (AVCaptureSession *)photoSession;
- (void)startSession;
- (void)stopSession;

- (BOOL)isSetup;
- (BOOL)isCameraAvailable;
- (void)setSetupStatus:(BOOL)status;
- (void)setCameraStatus:(BOOL)status;

- (void)capturePhotoWithSettings:(AVCapturePhotoSettings *)settings withDelegate:(id<AVCapturePhotoCaptureDelegate>)delegate;
@end
