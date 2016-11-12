//
//  RootModel.h
//  Vratis
//
//  Created by Daniel Budynski on 02/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RootModel : NSObject <UIPageViewControllerDataSource, UIScrollViewDelegate>
@property (strong, nonatomic) NSArray *pageTitles;

- (NSArray<UIViewController *>*)initialViewControllerStack;
@end
