//
//  EditProfileView.m
//  Vratis
//
//  Created by Daniel Budynski on 27/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import "EditProfileView.h"
@interface EditProfileView()
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UICollectionView *avatarCollectionView;

@end

@implementation EditProfileView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameTextField.tag = nameTextFieldTag;
    self.ageTextField.tag = ageTextFieldTag;
    self.addressTextField.tag = addressTextFieldTag;
}

- (void)initializeTextFieldDelegate:(id<UITextFieldDelegate>)delegate {
    NSAssert(delegate,@"Text field delegate will be empty.");
    
    self.nameTextField.delegate = delegate;
    self.ageTextField.delegate = delegate;
    self.addressTextField.delegate = delegate;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
