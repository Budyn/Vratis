//
//  EditProfileView.h
//  Vratis
//
//  Created by Daniel Budynski on 27/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

@import UIKit;

typedef NS_ENUM(NSUInteger, textFieldTag) {
    nameTextFieldTag = 0,
    ageTextFieldTag,
    addressTextFieldTag,
};

@interface EditProfileView : UIView
- (void)initializeTextFieldDelegate:(id<UITextFieldDelegate>)delegate;
- (void)initializeAvatarCollectionViewDelegate:(id<UICollectionViewDelegate>)delegate dataSource:(id<UICollectionViewDataSource>)dataSource;

@end
