//
//  EditProfileDelegate.h
//  Vratis
//
//  Created by Daniel Budynski on 28/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

@import UIKit;

@protocol EditProfileDelegate <NSObject>
- (void)profileUpdatedWithUserInfo:(NSDictionary*)userInfo;

@end
