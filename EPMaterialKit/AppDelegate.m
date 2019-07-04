//
//  AppDelegate.m
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 23.03.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Create main window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.mainViewController = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.mainViewController];

    // Configure the status bar for all of the views in the application
    if ([self.window respondsToSelector:@selector(setTintColor:)])
        self.window.tintColor = [UIColor DeepPurple];
    
    // Start with window
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
