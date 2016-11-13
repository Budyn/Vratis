//
//  CameraView.m
//  Vratis
//
//  Created by Daniel Budynski on 12/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//
#import <BFPaperButton/BFPaperButton.h>
#import "CameraView.h"

@interface CameraView()
@property (weak, nonatomic) IBOutlet UIButton *photoButton;
@property (weak, nonatomic) IBOutlet CaptureView *captureView;

@end

@implementation CameraView
- (void)awakeFromNib {
    [super awakeFromNib];
    [self.photoButton setTitle:@"Explore" forState:UIControlStateNormal];
    self.photoButton.layer.cornerRadius = 30.0;
    self.photoButton.clipsToBounds = YES;
    self.photoButton.alpha = 0.5;
    
}

#pragma mark Setters & Getters
- (void)setCaptureSession:(AVCaptureSession *)session {
    self.captureView.session = session;
}

- (AVCaptureSession *)captureSession {
    return self.captureView.session;
}

- (void)setCameraOrientation:(AVCaptureVideoOrientation)orientation {
    self.captureView.cameraViewLayer.connection.videoOrientation = orientation;
}

- (AVCaptureVideoOrientation)cameraOrientation {
    return self.captureView.cameraViewLayer.connection.videoOrientation;
}

- (void)setCameraLayerOpacity:(float)opacity {
    self.captureView.cameraViewLayer.opacity = opacity;
}

- (void)enablePhotoUI {
    self.photoButton.enabled = YES;
}
- (void)disablePhotoUI {
    self.photoButton.enabled = NO;
}

@end
