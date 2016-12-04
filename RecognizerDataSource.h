//
//  RecognizerDataSource.h
//  Vratis
//
//  Created by Daniel Budynski on 03/12/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface RecognizerDataSource : NSObject
@property (assign, nonatomic) NSUInteger count;

- (void)performFetch:(void (^)(NSError* error))completion;
- (PHAsset *)assetForIndex:(NSUInteger)index;
- (UIImage *)imageForIndex:(NSUInteger)index;
@end
