//
//  CameraRecorder.m
//  Vratis
//
//  Created by Daniel Budynski on 16/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import "CameraRecorder.h"
#import "NSError+Description.h"

@interface CameraRecorder()
@property (strong, nonatomic) AVCaptureDeviceInput *cameraInput;
@property (strong, nonatomic) AVCapturePhotoOutput *cameraOutput;
@property (assign, nonatomic) UIBackgroundTaskIdentifier backgroundRecordingID;
@end

@implementation CameraRecorder
- (instancetype)init {
    self = [super init];
    if (self) {
        _session = [[AVCaptureSession alloc] init];
        _isCameraAllowed = [[NSUserDefaults standardUserDefaults] boolForKey:@"isCameraAllowed"];
        _isSetupSuccessful = YES;
        [self configureSession];
        
    }
    return self;
}

- (void)configureSession {
    if (!(_session && _isCameraAllowed)) {
        NSLog(@"Configuration failed.");
        return;
    }
    
    [_session beginConfiguration];
    _session.sessionPreset = AVCaptureSessionPresetPhoto;
    AVCaptureDevice *backCamera = nil;
    for (AVCaptureDevice *device in [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo]) {
        if ([device position] == AVCaptureDevicePositionBack) {
            backCamera = device;
            break;
        }
    }
    NSAssert(backCamera, @"Back camera is not avaible.");
    
    NSError * __autoreleasing error = nil;
    AVCaptureDeviceInput *backCameraInput = [AVCaptureDeviceInput deviceInputWithDevice:backCamera error:&error];
    if (error) {
        [error fullDescription];
        _isSetupSuccessful = NO;
        [_session commitConfiguration];
        return;
    }
    
    if([_session canAddInput:backCameraInput]) {
        [_session addInput:backCameraInput];
        _cameraInput = backCameraInput;
    } else {
        NSLog(@"Could not add back camera INPUT to the session");
        _isSetupSuccessful = NO;
        [_session commitConfiguration];
        return;
    }
    
    AVCapturePhotoOutput *photoOutput = [[AVCapturePhotoOutput alloc] init];
    if ([_session canAddOutput:photoOutput]) {
        [_session addOutput:photoOutput];
        _cameraOutput = photoOutput;
        _cameraOutput.highResolutionCaptureEnabled = YES;
        _cameraOutput.livePhotoCaptureEnabled = NO;
    } else {
        NSLog(@"Could not add back camera OUTPUT to the session");
        _isSetupSuccessful = NO;
        [_session commitConfiguration];
        return;
    }
    
    _backgroundRecordingID = UIBackgroundTaskInvalid;
    [_session commitConfiguration];
    
}

- (void)capturePhotoWithSettings:(AVCapturePhotoSettings *)settings withDelegate:(id<AVCapturePhotoCaptureDelegate>)delegate {
    [self.cameraOutput capturePhotoWithSettings:settings delegate:delegate];
}

@end
