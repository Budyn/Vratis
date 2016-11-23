//
//  MediaRecorder.m
//  Vratis
//
//  Created by Daniel Budynski on 15/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import "MediaRecorder.h"
#import "NSError+Description.h"

@interface MediaRecorder()
@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureDeviceInput *cameraInput;
@property (strong, nonatomic) AVCapturePhotoOutput *cameraOutput;

@property (assign, nonatomic) BOOL isCameraAllowed;
@property (assign, nonatomic) BOOL isSetupSuccessful;
@end

@implementation MediaRecorder
- (instancetype)init {
    self = [super init];
    if (self) {
        self.isCameraAllowed = [[NSUserDefaults standardUserDefaults] boolForKey:@"isCameraAllowed"];
        self.isSetupSuccessful = YES;
        self.session = [[AVCaptureSession alloc] init];
        [self configureCaptureSession];
    }
    return self;
}

#pragma mark Session Configuration
- (void)configureCaptureSession {
    if (![self isCameraAllowed]) {
        return;
    }
    
    [self.session beginConfiguration];
    self.session.sessionPreset = AVCaptureSessionPresetPhoto;
    
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
        self.isSetupSuccessful = NO;
        [self.session commitConfiguration];
        return;
    }
    
    if([self.session canAddInput:backCameraInput]) {
        [self.session addInput:backCameraInput];
        self.cameraInput = backCameraInput;
        
    } else {
        NSLog(@"Could not add back camera INPUT to the session");
        self.isSetupSuccessful = NO;
        [self.session commitConfiguration];
        return;
    }
    
    AVCapturePhotoOutput *photoOutput = [[AVCapturePhotoOutput alloc] init];
    if ([self.session canAddOutput:photoOutput]) {
        [self.session addOutput:photoOutput];
        self.cameraOutput = photoOutput;
        self.cameraOutput.highResolutionCaptureEnabled = YES;
        self.cameraOutput.livePhotoCaptureEnabled = NO;
    } else {
        NSLog(@"Could not add back camera OUTPUT to the session");
        self.isSetupSuccessful = NO;
        [self.session commitConfiguration];
        return;
    }
    [self.session commitConfiguration];
}

#pragma mark Setters & Getters
- (AVCaptureSession *)photoSession {
    return self.session;
}

- (BOOL)isSetup {
    if (self.isSetupSuccessful) {
        NSLog(@"Setup is successful");
    } else {
        NSLog(@"Setup is not configured");
    }
    return self.isSetupSuccessful;
}

- (BOOL)isCameraAvailable {
    if (self.isCameraAllowed) {
        NSLog(@"Camera is allowed");
    } else {
        NSLog(@"Camera is not allowed - session can't be configured");
    }
    return self.isCameraAllowed;
}
- (void)setSetupStatus:(BOOL)status {
    self.isSetupSuccessful = status;
}

- (void)setCameraStatus:(BOOL)status {
    self.isCameraAllowed = status;
}


#pragma mark Session actions
- (void)startSession {
    if (self.isSetupSuccessful) {
        [self.session startRunning];
    } else {
        NSLog(@"%@: Setup is not successful, can't start running.", [self class]);
    }
}

- (void)stopSession {
    if (self.isSetupSuccessful) {
        [self.session stopRunning];
    } else {
        NSLog(@"%@: Setup is not successful, can't stop running.", [self class]);
    }
}

- (void)capturePhotoWithSettings:(AVCapturePhotoSettings *)settings withDelegate:(id<AVCapturePhotoCaptureDelegate>)delegate {
    [self.cameraOutput capturePhotoWithSettings:settings delegate:delegate];
}

@end
