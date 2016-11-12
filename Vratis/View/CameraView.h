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
@property (weak, nonatomic) IBOutlet CaptureView *captureView;

- (void)enablePhotoUI;
- (void)disablePhotoUI;

@end
