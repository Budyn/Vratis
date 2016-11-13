//
//  CameraView.h
//  Vratis
//
//  Created by Daniel Budynski on 12/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaptureView.h"

@interface CameraView : UIView
- (void)setCaptureSession:(AVCaptureSession *)session;
- (AVCaptureSession *)captureSession;
- (void)setCameraOrientation:(AVCaptureVideoOrientation)orientation;
- (AVCaptureVideoOrientation)cameraOrientation;

- (void)setCameraLayerOpacity:(float)opacity;

- (void)enablePhotoUI;
- (void)disablePhotoUI;

@end
