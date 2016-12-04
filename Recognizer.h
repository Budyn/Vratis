//
//  Recognizer.h
//  Vratis
//
//  Created by Daniel Budynski on 03/12/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Recognizer : NSObject
+ (instancetype)sharedInstance;
- (void)fetchDataSource:(void (^)(NSError *error))completion;

- (NSString *)recognizeImage:(UIImage *)cameraImage;
@end
