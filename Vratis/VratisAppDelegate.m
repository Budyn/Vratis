//
//  AppDelegate.m
//  Vratis
//
//  Created by Daniel Budynski on 26/10/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//
@import AVFoundation;
#import "VratisAppDelegate.h"

@interface VratisAppDelegate ()

@end

@implementation VratisAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSDictionary *userDefaults = [NSDictionary dictionaryWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"UserDefaults" withExtension:@"plist"]];
    [[NSUserDefaults standardUserDefaults] registerDefaults:userDefaults];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isColdStart"] == YES) {
        switch([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo]){
            case AVAuthorizationStatusAuthorized:
            {
                NSLog(@"Camera is allowed");
                break;
            }
            case AVAuthorizationStatusNotDetermined:
            {
                NSCondition *condition = [[NSCondition alloc] init];
                NSLog(@"Camera will be determined");
                [condition lock];
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL isAllowed) {
                    if (isAllowed) {
                        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isCameraAllowed"];
                    }
                    [condition unlock];
                }];
                break;
            }
            default:
            {
                NSLog(@"Cammera is NOT allowed");
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isCameraAllowed"];
            }
        }
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
