//
//  CalendarDemoAppDelegate.h
//  CalendarDemo
//
//  Created by Vladimir Grichina on 20.07.11.
//  Copyright 2011 Componentix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CalendarDemoViewController;

@interface CalendarDemoAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CalendarDemoViewController *viewController;

@end
