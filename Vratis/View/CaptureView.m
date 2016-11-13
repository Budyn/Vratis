//
//  CaptureView.m
//  Vratis
//
//  Created by Daniel Budynski on 26/10/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//
@import AVFoundation;
#import "CaptureView.h"

@implementation CaptureView
+ (Class)layerClass {
    return [AVCaptureVideoPreviewLayer class];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cameraViewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
}
#pragma mark Setters & Getters

- (AVCaptureVideoPreviewLayer *)cameraViewLayer {
    return (AVCaptureVideoPreviewLayer *)self.layer;
}

- (AVCaptureSession *)session {
    return self.cameraViewLayer.session;
}

- (void)setSession:(AVCaptureSession *)session {
    self.cameraViewLayer.session = session;
}
@end
