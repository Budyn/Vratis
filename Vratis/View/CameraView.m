//
//  CameraView.m
//  Vratis
//
//  Created by Daniel Budynski on 12/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import "CameraView.h"

@interface CameraView()
@property (weak, nonatomic) IBOutlet UIButton *photoButton;

@end

@implementation CameraView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.photoButton.enabled = NO;
}

#pragma mark Setters & Getters

- (void)enablePhotoUI {
    self.photoButton.enabled = YES;
}
- (void)disablePhotoUI {
    self.photoButton.enabled = NO;
}

@end
