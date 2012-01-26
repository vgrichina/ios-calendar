//
//  CalendarDemoAppDelegate.m
//  CalendarDemo
//
//  Created by Vladimir Grichina on 20.07.11.
//  Copyright 2011 Componentix. All rights reserved.
//

#import "CalendarDemoAppDelegate.h"

#import "CalendarDemoViewController.h"


@implementation CalendarDemoAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL) application: (UIApplication *) application didFinishLaunchingWithOptions: (NSDictionary *) launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController = [[CalendarDemoViewController alloc] init];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
