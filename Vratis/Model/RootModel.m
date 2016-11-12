//
//  RootModel.m
//  Vratis
//
//  Created by Daniel Budynski on 02/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "RootModel.h"
#import "RootModelString.h"

#import "Page.h"
#import "CameraViewController.h"
#import "SettingsViewController.h"

#define kSettingsVCIndex 0
#define kCameraVCIndex 1

@interface RootModel()
@property (strong, nonatomic) UIStoryboard *cameraStoryboard;

@end

@implementation RootModel
- (instancetype)init {
    if (self = [super init]) {
        _cameraStoryboard = [UIStoryboard storyboardWithName:@"Camera" bundle:[NSBundle mainBundle]];
        _pageTitles = @[settingsViewPageTitle, cameraViewPageTitle];
    }
    return self;
}

- (NSArray<UIViewController *>*)initialViewControllerStack {
    return @[[self viewControllerForIndex:kCameraVCIndex]];
}

#pragma mark UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [((Page *)viewController) pageIndex];
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    index--;
    return [self viewControllerForIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [((Page *)viewController) pageIndex];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.pageTitles count]){
        return nil;
    }
    return [self viewControllerForIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return [self.pageTitles count];
}

#pragma mark Page Factory
- (UIViewController *)viewControllerForIndex:(NSUInteger)pageIndex {
    if ([self.pageTitles count] == 0 || pageIndex >= [self.pageTitles count]) {
        return nil;
    }
    
    switch (pageIndex) {
        case kSettingsVCIndex:
        {
            SettingsViewController *settingsPage = (SettingsViewController *)[self.cameraStoryboard instantiateViewControllerWithIdentifier:@"SettingsVC"];
            settingsPage.pageIndex = pageIndex;
            settingsPage.title = [self.pageTitles objectAtIndex:pageIndex];
            return settingsPage;
        }
        case kCameraVCIndex:
        {
            CameraViewController *cameraPage = (CameraViewController *)[self.cameraStoryboard instantiateViewControllerWithIdentifier:@"CameraVC"];
            cameraPage.pageIndex = pageIndex;
            cameraPage.title = [self.pageTitles objectAtIndex:pageIndex];
            
            return cameraPage;
        }
        default: {
            return nil;
        }
    }
    return nil;
}

@end
