//
//  SettingsTableViewCell.m
//  Vratis
//
//  Created by Daniel Budynski on 07/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import "SettingsTableViewCell.h"
@interface SettingsTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@end

@implementation SettingsTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark Setters & Getters
- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setSubtitle:(NSString *)subtitle {
    self.subtitleLabel.text = subtitle;
}

- (void)setIcon:(NSString *)imageName {
    self.iconImage.image = [UIImage imageNamed:imageName];
}

@end
