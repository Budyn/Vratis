//
//  AppDelegate.m
//  Vratis
//
//  Created by Daniel Budynski on 26/10/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import "VratisAppDelegate.h"

@interface VratisAppDelegate ()

@end

@implementation VratisAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSURL *userDefaultsURL = [[NSBundle mainBundle] URLForResource:@"UserDefaults" withExtension:@"plist"];
    NSDictionary *userDefaults = [NSDictionary dictionaryWithContentsOfURL:userDefaultsURL];
    [[NSUserDefaults standardUserDefaults] registerDefaults:userDefaults];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL firstLaunch = [defaults boolForKey:@"isColdStart"];
    if (firstLaunch) {
        [defaults setBool:NO forKey:@"isColdStart"];
        [defaults synchronize];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {}
- (void)applicationDidEnterBackground:(UIApplication *)application {}
- (void)applicationWillEnterForeground:(UIApplication *)application {}
- (void)applicationDidBecomeActive:(UIApplication *)application {}
- (void)applicationWillTerminate:(UIApplication *)application {}

@end
