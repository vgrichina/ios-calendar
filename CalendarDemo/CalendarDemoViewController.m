//
//  CalendarDemoViewController.m
//  CalendarDemo
//
//  Created by Vladimir Grichina on 20.07.11.
//  Copyright 2011 Componentix. All rights reserved.
//

#import "CalendarDemoViewController.h"

@implementation CalendarDemoViewController

- (void) loadView {
    [super loadView];

    self.view.backgroundColor = [UIColor whiteColor];

    CXCalendarView *calendarView = [[[CXCalendarView alloc] initWithFrame: self.view.bounds] autorelease];
    calendarView.frame = self.view.bounds;
    calendarView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    calendarView.selectedDate = [NSDate date];
    calendarView.delegate = self;

    [self.view addSubview: calendarView];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return YES;
}

#pragma mark CXCalendarViewDelegate

- (void) calendarView: (CXCalendarView *) calendarView
        didSelectDate: (NSDate *) date {
    NSLog(@"Selected date: %@", date);
}

- (void)  calendarView: (CXCalendarView *) calendarView
didChangeDisplayedDate: (NSDate *) displayedDate {
    NSDateComponents *components = [calendarView.calendar components: NSYearCalendarUnit | NSMonthCalendarUnit
                                                            fromDate: displayedDate];
    NSLog(@"Displayed date: %d.%d", components.month, components.year);
}

@end
