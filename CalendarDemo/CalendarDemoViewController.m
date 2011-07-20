//
//  CalendarDemoViewController.m
//  CalendarDemo
//
//  Created by Vladimir Grichina on 20.07.11.
//  Copyright 2011 Componentix. All rights reserved.
//

#import "CalendarDemoViewController.h"

@implementation CalendarDemoViewController

@synthesize calendarView;

- (void) loadView {
    [super loadView];

    self.calendarView = [[CXCalendarView new] autorelease];
    [self.view addSubview: self.calendarView];
    self.calendarView.frame = self.view.bounds;
    self.calendarView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    self.calendarView.selectedDate = [NSDate date];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return YES;
}

@end
