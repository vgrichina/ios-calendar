//
//  CXCalendarView.m
//  Calendar
//
//  Created by Vladimir Grichina on 13.07.11.
//  Copyright 2011 Componentix. All rights reserved.
//

#import "CXCalendarView.h"

#import "CXCalendarCellView.h"

@interface CXCalendarView(private)

- (void) monthUpdated;

@end

@implementation CXCalendarView

@synthesize delegate;

static const CGFloat kDefaultMonthBarHeight = 48;

- (void) dealloc {
    [_selectedDate release];
    [_monthLabel release];
    [_gridView release];

    [super dealloc];
}

- (NSDate *) selectedDate {
    return _selectedDate;
}

- (void) setSelectedDate: (NSDate *) selectedDate {
    if (![selectedDate isEqual: _selectedDate]) {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        int oldMonth = [calendar components: NSMonthCalendarUnit fromDate: self.selectedDate].month;
        int newMonth = [calendar components: NSMonthCalendarUnit fromDate: selectedDate].month;

        int year = [calendar components: NSYearCalendarUnit fromDate: selectedDate].year;

        [_selectedDate release];
        _selectedDate = [selectedDate retain];

        if (oldMonth != newMonth) {
            [self monthUpdated];
        }

        for (CXCalendarCellView *cellView in self.gridView.subviews) {
            cellView.selected = NO;
        }
        [self cellForDate: selectedDate].selected = YES;

        self.monthLabel.text = [NSString stringWithFormat: @"%@ %d",
                                [[[[NSDateFormatter new] autorelease] standaloneMonthSymbols] objectAtIndex: newMonth - 1], year];
    }
}

- (TTView *) monthBar {
    if (!_monthBar) {
        _monthBar = [TTView new];
        [self addSubview: _monthBar];
        _monthBar.height = kDefaultMonthBarHeight;
        _monthBar.width = self.width;
        _monthBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        _monthBar.style = TTSTYLE(calendarMonthBarStyle);
    }

    return _monthBar;
}

- (TTLabel *) monthLabel {
    if (!_monthLabel) {
        _monthLabel = [TTLabel new];
        [self.monthBar addSubview: _monthLabel];
        _monthLabel.height = self.monthBar.height;
        _monthLabel.width = self.width;
        _monthLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        _monthLabel.style = TTSTYLE(calendarMonthLabelStyle);
    }

    return _monthLabel;
}

- (TTView *) gridView {
    if (!_gridView) {
        _gridView = [TTView new];
        [self addSubview: _gridView];
        _gridView.frame = self.bounds;
        _gridView.height -= self.monthLabel.height;
        _gridView.top = self.monthLabel.bottom;
        _gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
        _gridView.style = TTSTYLE(calendarGridViewStyle);
    }

    return _gridView;
}

- (NSDate *) monthCalendarStartDate: (NSDate *) date {
    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSDate *monthStartDate;
    if (![calendar rangeOfUnit: NSMonthCalendarUnit startDate: &monthStartDate interval: NULL forDate: date]) {
        return nil;
    }

    NSDate *weekStartDate;
    if (![calendar rangeOfUnit: NSWeekCalendarUnit startDate: &weekStartDate interval: NULL forDate: monthStartDate]) {
        return nil;
    }

    return weekStartDate;
}

- (CXCalendarCellView *) cellForDate: (NSDate *) date {
    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSDate *startDate = [self monthCalendarStartDate: self.selectedDate];
    int dayInCalendar = [calendar components: NSDayCalendarUnit fromDate: startDate toDate: date options: 0].day;

    if (dayInCalendar > 0 && dayInCalendar < [self.gridView.subviews count]) {
        return [self.gridView.subviews objectAtIndex: dayInCalendar];
    }

    return nil;
}

- (void) touchedCellView: (CXCalendarCellView *) cellView {
    self.selectedDate = cellView.date;
    [self.delegate calendarView: self didSelectDate: self.selectedDate];
}

- (void) monthUpdated {
    [self.gridView removeAllSubviews];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    int selectedMonth = [calendar components: NSMonthCalendarUnit fromDate: self.selectedDate].month;

    NSDate *date = [self monthCalendarStartDate: self.selectedDate];
    NSDateComponents *dayStep = [[NSDateComponents new] autorelease];
    dayStep.day = 1;
    int month = [calendar components: NSMonthCalendarUnit fromDate: date].month;
    while (month <= selectedMonth) {
        for (int i = 0; i < 7; i++) {
            CXCalendarCellView *cellView = [[CXCalendarCellView new] autorelease];
            cellView.date = date;
            [cellView setStylesWithSelector: @"calendarCellStyle:"];
            if (month != selectedMonth) {
                cellView.enabled = NO;
            }
            [cellView addTarget: self
                         action: @selector(touchedCellView:)
               forControlEvents: UIControlEventTouchUpInside];
            [self.gridView addSubview: cellView];

            date = [calendar dateByAddingComponents: dayStep toDate: date options: 0];
            month = [calendar components: NSMonthCalendarUnit fromDate: date].month;
        }
    }

    [self setNeedsLayout];
}

- (void) layoutSubviews {
    [super layoutSubviews];

    CGSize cellSize = CGSizeMake(self.gridView.width / 7.0, self.gridView.height / 6.0);

    int i = 0;
    for (CXCalendarCellView *cellView in self.gridView.subviews) {
        cellView.size = cellSize;
        cellView.left = cellSize.width * (i % 7);
        cellView.top = cellSize.height * (i / 7);

        i++;
    }
}

@end
