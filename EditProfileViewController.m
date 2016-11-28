//
//  EditProfileViewController.m
//  Vratis
//
//  Created by Daniel Budynski on 27/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import "EditProfileViewController.h"
#import "EditProfileView.h"

#import "AvatarCollectionDataSource.h"

@interface EditProfileViewController () <UITextFieldDelegate, UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet EditProfileView *editProfileView;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *age;
@property (copy, nonatomic) NSString *address;
@property (copy, nonatomic) NSString *avatarName;
@property (strong, nonatomic) AvatarCollectionDataSource *avatarDataSource;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.editProfileView initializeTextFieldDelegate:self];
    self.avatarDataSource = [[AvatarCollectionDataSource alloc] init];
    [self.editProfileView initializeAvatarCollectionViewDelegate:self dataSource:self.avatarDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark IBActions
- (IBAction)saveButtonTapped:(id)sender {
    if (self.delegate) {
        NSMutableDictionary * userInfo = [NSMutableDictionary dictionary];
        if (self.name) {
            [userInfo setObject:self.name forKey:@"name"];
        }
        
        if (self.age) {
            [userInfo setObject:self.age forKey:@"age"];
        }
        
        if (self.address) {
            [userInfo setObject:self.address forKey:@"address"];
        }
        
        if (self.avatarName) {
            [userInfo setObject:self.avatarName forKey:@"avatar"];
        }
        
        [self.delegate performSelector:@selector(profileUpdatedWithUserInfo:) withObject:userInfo];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //TODO: This is really ugly. Change it ASAP
    switch (textField.tag) {
        case nameTextFieldTag:
        {
            self.name = [NSString stringWithFormat:@"%@%@", textField.text, string];
            break;
        }
        case ageTextFieldTag:
        {
            self.age = [NSString stringWithFormat:@"%@%@", textField.text, string];
            break;
        }
        case addressTextFieldTag:
        {
            self.address = [NSString stringWithFormat:@"%@%@", textField.text, string];
            break;
        }
        default:
            NSAssert(YES,@"Text field is not recognized.");
    }
    return YES;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.avatarName = [self.avatarDataSource.avatarName objectAtIndex:indexPath.row];
}

@end
