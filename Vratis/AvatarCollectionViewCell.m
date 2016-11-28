//
//  AvatarCollectionViewCell.m
//  Vratis
//
//  Created by Daniel Budynski on 28/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import "AvatarCollectionViewCell.h"

@implementation AvatarCollectionViewCell
- (void)setSelected:(BOOL)selected {
    [UIView animateWithDuration:0.2 animations:^{
        if (selected) {
            self.avatarImageView.alpha = 1.0;
        } else {
            self.avatarImageView.alpha = 0.3;
        }
    }];
}
@end
