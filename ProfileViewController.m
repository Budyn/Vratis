//
//  ProfileViewController.m
//  Vratis
//
//  Created by Daniel Budynski on 27/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileView.h"

#import "EditProfileViewController.h"
#import "EditProfileDelegate.h"

@interface ProfileViewController () <EditProfileDelegate>
@property (strong, nonatomic) IBOutlet ProfileView *profileView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    EditProfileViewController *editProfileVC = (EditProfileViewController *)[segue destinationViewController];
    ProfileViewController * profileVC = (ProfileViewController *)[segue sourceViewController];
    if (editProfileVC && profileVC) {
        editProfileVC.delegate = profileVC;
    }
}

#pragma mark EditProfileDelegate
- (void)profileUpdatedWithUserInfo:(NSDictionary *)userInfo {
    [self.profileView updateUserProfileWithInfo:userInfo];
}

@end
