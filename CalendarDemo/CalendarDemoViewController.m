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

    self.view.backgroundColor = [UIColor whiteColor];

    self.calendarView = [[[CXCalendarView alloc] initWithFrame: self.view.bounds] autorelease];
    [self.view addSubview: self.calendarView];
    self.calendarView.frame = self.view.bounds;
    self.calendarView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    self.calendarView.selectedDate = [NSDate date];

    self.calendarView.delegate = self;
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return YES;
}

#pragma mark CXCalendarViewDelegate

- (void) calendarView: (CXCalendarView *) calendarView
        didSelectDate: (NSDate *) date {

    NSLog(@"Selected date: %@", date);
    /*TTAlert([NSString stringWithFormat: @"Selected date: %@", date]);*/
}

- (UIColor*) backgroundCellColorForDate: (NSDate*) date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components: NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit
                                                                   fromDate: date];
    if (components.month == 4 &&
        components.year == 2013 &&
        components.day == 1) {
        return [UIColor redColor];
    } else if (components.month == 4 &&
               components.year == 2013 &&
               components.day == 8) {
        return [UIColor orangeColor];
    }
    
    return [UIColor whiteColor];
}

@end
