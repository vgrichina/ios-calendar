//
//  CalendarDemoViewController.h
//  CalendarDemo
//
//  Created by Vladimir Grichina on 20.07.11.
//  Copyright 2011 Componentix. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CXCalendarView.h"

@interface CalendarDemoViewController : UIViewController<CXCalendarViewDelegate>

@property(assign) CXCalendarView *calendarView;

@end
