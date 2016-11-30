//
//  CameraViewController.m
//  Vratis
//
//  Created by Daniel Budynski on 26/10/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//
@import AVFoundation;

#import "CameraViewController.h"
#import "CameraView.h"
#import "PhotoCaptureDelegate.h"

#import "NSError+Description.h"

@interface CameraViewController ()
@property (strong, nonatomic) IBOutlet CameraView *cameraView;

@property (strong, nonatomic) AVCaptureSession *session;

@property (strong, nonatomic) AVCaptureDeviceInput *cameraInput;
@property (strong, nonatomic) AVCapturePhotoOutput *cameraOutput;

@property (strong, nonatomic) NSMutableDictionary<NSNumber *, PhotoCaptureDelegate *> *inProgressPhotoCaptureDelegates;

@property (strong, nonatomic) dispatch_queue_t sessionQueue;

@property (assign, nonatomic) BOOL isCameraAllowed;
@property (assign, nonatomic) BOOL isSetupSuccessful;
@property (assign, nonatomic) UIBackgroundTaskIdentifier backgroundRecordingID;


@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.session = [[AVCaptureSession alloc] init];
    [self.cameraView setCaptureSession:self.session];
    
    self.sessionQueue = dispatch_queue_create("session queue", DISPATCH_QUEUE_SERIAL);
    self.isSetupSuccessful = YES;
    
    self.isCameraAllowed = [[NSUserDefaults standardUserDefaults] boolForKey:@"isCameraAllowed"];
    
    dispatch_async(self.sessionQueue, ^{
        [self configureCameraAccess];
        [self configureCaptureSession];
    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    dispatch_async(self.sessionQueue, ^{
        if (self.isSetupSuccessful) {
            [self.session startRunning];
        }
    });
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    dispatch_async( self.sessionQueue, ^{
        if (self.isSetupSuccessful) {
            [self.session stopRunning];
        }
    });
}

- (void)configureCameraAccess {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (!self.isCameraAllowed) {
        switch([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo]){
            case AVAuthorizationStatusAuthorized:
            {
                NSLog(@"Camera is allowed");
                break;
            }
            case AVAuthorizationStatusNotDetermined:
            {
                dispatch_suspend(self.sessionQueue);
                NSLog(@"Camera will be determined");
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL isAllowed) {
                    if (isAllowed) {
                        [defaults setBool:YES forKey:@"isCameraAllowed"];
                        [defaults synchronize];
                        self.isCameraAllowed = YES;
                    }
                    dispatch_resume(self.sessionQueue);
                }];
                break;
            }
            default:
            {
                NSLog(@"Cammera is NOT allowed");
                [defaults setBool:NO forKey:@"isCameraAllowed"];
                [defaults synchronize];
            }
        }
    }
}

- (void)configureCaptureSession {
    if (!self.isCameraAllowed) {
        NSLog(@"Camera is not allowed - session can't be configured");
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
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.cameraView setCameraOrientation:AVCaptureVideoOrientationPortrait];
        });
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
        self.inProgressPhotoCaptureDelegates = [NSMutableDictionary dictionary];
        
    } else {
        NSLog(@"Could not add back camera OUTPUT to the session");
        self.isSetupSuccessful = NO;
        [self.session commitConfiguration];
        return;
    }
    self.backgroundRecordingID = UIBackgroundTaskInvalid;
    
    [self.session commitConfiguration];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Setters & Getters
- (CameraView *)cameraView {
    return (CameraView *)self.view;
}

#pragma mark IBActions
- (IBAction)photoButtonTapped:(id)sender {
    NSLog(@"Photo button tapped");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"photoCreated" object:nil];
    dispatch_async(self.sessionQueue, ^{
        AVCapturePhotoSettings *photoSettings = [AVCapturePhotoSettings photoSettings];
        photoSettings.flashMode = AVCaptureFlashModeAuto;
        photoSettings.highResolutionPhotoEnabled = YES;
        if ( photoSettings.availablePreviewPhotoPixelFormatTypes.count > 0 ) {
            photoSettings.previewPhotoFormat = @{ (NSString *)kCVPixelBufferPixelFormatTypeKey : photoSettings.availablePreviewPhotoPixelFormatTypes.firstObject };
        }
        
        PhotoCaptureDelegate *photoCaptureDelegate = [[PhotoCaptureDelegate alloc] initWithRequestedPhotoSettings:photoSettings willCapturePhotoAnimation:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.cameraView setCameraLayerOpacity:0.3];
                [UIView animateWithDuration:0.5 animations:^{
                    [self.cameraView setCameraLayerOpacity:1.0];
                }];
            });
        } completed:^(PhotoCaptureDelegate *delegate){
            dispatch_async( self.sessionQueue, ^{
                self.inProgressPhotoCaptureDelegates[@(photoCaptureDelegate.requestedPhotoSettings.uniqueID)] = nil;
            } );
        }];
        
        self.inProgressPhotoCaptureDelegates[@(photoCaptureDelegate.requestedPhotoSettings.uniqueID)] = photoCaptureDelegate;
        [self.cameraOutput capturePhotoWithSettings:photoSettings delegate:photoCaptureDelegate];
    });
    
}



@end
