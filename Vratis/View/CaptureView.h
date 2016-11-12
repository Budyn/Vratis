//
//  CaptureView.h
//  Vratis
//
//  Created by Daniel Budynski on 26/10/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//
@import AVFoundation;
@import UIKit;

@interface CaptureView : UIView
@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic, readonly) AVCaptureVideoPreviewLayer *cameraViewLayer;

@end
