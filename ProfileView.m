//
//  ProfileView.m
//  Vratis
//
//  Created by Daniel Budynski on 27/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import "ProfileView.h"

@interface ProfileView()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameInputLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageInputLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressInputLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@end

@implementation ProfileView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLabel.clipsToBounds = YES;
    self.nameLabel.layer.cornerRadius = 10;
    self.ageLabel.clipsToBounds = YES;
    self.ageLabel.layer.cornerRadius = 10;
    self.addressLabel.clipsToBounds = YES;
    self.addressLabel.layer.cornerRadius = 10;
    
    
}

- (void)updateUserProfileWithInfo:(NSDictionary *)userInfo {
    if (userInfo && userInfo.count > 0) {
        NSString *userInfoObject = nil;
        if ((userInfoObject = [userInfo objectForKey:@"name"])) {
            self.nameInputLabel.text = userInfoObject;
        }
        if ((userInfoObject = [userInfo objectForKey:@"age"])) {
            self.ageInputLabel.text = userInfoObject;
        }
        if ((userInfoObject = [userInfo objectForKey:@"address"])) {
            self.addressInputLabel.text = userInfoObject;
        }
        if ((userInfoObject = [userInfo objectForKey:@"avatar"])) {
            self.avatarImageView.image = [UIImage imageNamed:userInfoObject];
        }
    } else {
        NSLog(@"User info dictionary is either empty or nil.");
    }
}

@end
