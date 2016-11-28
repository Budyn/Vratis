//
//  EditProfileViewController.h
//  Vratis
//
//  Created by Daniel Budynski on 27/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

@import UIKit;
#import "EditProfileDelegate.h"

@interface EditProfileViewController : UIViewController
@property (weak, nonatomic) id <EditProfileDelegate> delegate;

@end
