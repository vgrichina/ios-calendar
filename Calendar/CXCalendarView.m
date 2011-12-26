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


static const CGFloat kGridMargin = 4;


@implementation CXCalendarView

@synthesize delegate;
@synthesize monthBarHeight, weekBarHeight;

static const CGFloat kDefaultMonthBarButtonWidth = 60;

- (id) init {
    self = [super init];
    if (self) {
        self.selectedDate = [NSDate date];
        self.monthBarHeight = 48;
        self.weekBarHeight = 32;
    }

    return self;
}

- (void) dealloc {
    [_calendar release];
    [_selectedDate release];

    [super dealloc];
}

- (NSCalendar *)calendar {
    if (!_calendar) {
        _calendar = [[NSCalendar currentCalendar] retain];
    }
    return _calendar;
}

- (void)setCalendar:(NSCalendar *)calendar {
    if (_calendar != calendar) {
        [_calendar release];
        _calendar = [calendar retain];
        [self monthUpdated];
    }
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

        NSString *monthName = [[[[NSDateFormatter new] autorelease] standaloneMonthSymbols] objectAtIndex: newMonth - 1];
        self.monthLabel.text = [NSString stringWithFormat: @"%@ %d", NSLocalizedString(monthName, @""), year];
    }
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
    NSDate *startDate = [self monthCalendarStartDate: self.selectedDate];
    int dayInCalendar = [self.calendar components: NSDayCalendarUnit
                                         fromDate: startDate toDate: date options: 0].day;
    if (dayInCalendar > 0 && dayInCalendar < [self.gridView.subviews count]) {
        return [self.gridView.subviews objectAtIndex: dayInCalendar];
    }
    return nil;
}

- (void) touchedCellView: (CXCalendarCellView *) cellView {
    self.selectedDate = cellView.date;
    [self.delegate calendarView: self didSelectDate: self.selectedDate];
}

- (void) monthForward {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *monthStep = [[NSDateComponents new] autorelease];
    monthStep.month = 1;
    self.selectedDate = [calendar dateByAddingComponents: monthStep toDate: self.selectedDate options: 0];
}

- (void) monthBack {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *monthStep = [[NSDateComponents new] autorelease];
    monthStep.month = -1;
    self.selectedDate = [calendar dateByAddingComponents: monthStep toDate: self.selectedDate options: 0];
}

- (void) reset {
    self.selectedDate = [NSDate date];
}

- (void) monthUpdated {
    [self.gridView removeAllSubviews];

    int selectedMonth = [self.calendar components: NSMonthCalendarUnit fromDate: self.selectedDate].month;

    NSDate *date = [self monthCalendarStartDate: self.selectedDate];
    NSDateComponents *dayStep = [[NSDateComponents new] autorelease];
    dayStep.day = 1;
    int month = [self.calendar components: NSMonthCalendarUnit fromDate: date].month;
    //Break cycle of monthes
    if ((month == 1) && (selectedMonth == 12))
        month = 13;
    if ((month == 12) && (selectedMonth == 1))
        month = 0;
    while (month <= selectedMonth) {
        for (int i = 0; i < 7; i++) {
            CXCalendarCellView *cellView = [[CXCalendarCellView new] autorelease];
            cellView.date = date;
            if (month != selectedMonth) {
                cellView.enabled = NO;
            }
            [cellView addTarget: self
                         action: @selector(touchedCellView:)
               forControlEvents: UIControlEventTouchUpInside];
            [self.gridView addSubview: cellView];

            date = [self.calendar dateByAddingComponents: dayStep toDate: date options: 0];
            month = [self.calendar components: NSMonthCalendarUnit fromDate: date].month;
            //Break cycle of monthes
            if ((month == 1) && (selectedMonth == 12))
                month = 13;
            if ((month == 12) && (selectedMonth == 1))
                month = 0;
        }
    }

    [self setNeedsLayout];
}

- (void) layoutSubviews {
    [super layoutSubviews];

    self.backgroundColor = [UIColor clearColor];

    CGFloat top = 0;

    if (self.monthBarHeight) {
        self.monthBar.frame = CGRectMake(0, top, self.width, self.monthBarHeight);
        self.monthLabel.frame = CGRectMake(0, top, self.width, self.monthBar.height);
        self.monthForwardButton.frame = CGRectMake(self.monthBar.width - kDefaultMonthBarButtonWidth, top,
                                                   kDefaultMonthBarButtonWidth, self.monthBar.height);
        self.monthBackButton.frame = CGRectMake(0, top, kDefaultMonthBarButtonWidth, self.monthBar.height);
        top = self.monthBar.top + self.monthBar.height;
    } else {
        self.monthBar.frame = CGRectZero;
    }

    if (self.weekBarHeight) {
        self.weekdayBar.left = 0;
        self.weekdayBar.top = top;
        self.weekdayBar.width = self.width;
        self.weekdayBar.height = self.weekBarHeight;
        for (NSUInteger i = 0; i < [self.weekdayBar.subviews count]; ++i) {
            TTLabel *label = [self.weekdayBar.subviews objectAtIndex:i];
            label.left = (self.weekdayBar.width / 7) * (i % 7);
            label.top = 0;
            label.width = (self.weekdayBar.width / 7);
            label.height = self.weekdayBar.height;
        }
        top = self.weekdayBar.top + self.weekdayBar.height;
    } else {
        self.weekdayBar.frame = CGRectZero;
    }

    self.gridView.frame = CGRectMake(kGridMargin, top, self.width - kGridMargin * 2, self.height - top);
    CGFloat cellHeight = self.gridView.height / 6.0;
    for (NSUInteger i = 0; i < [self.gridView.subviews count]; ++i) {
        CXCalendarCellView *cellView = [self.gridView.subviews objectAtIndex:i];
        cellView.width = [self cellWidth];
        cellView.height = cellHeight;
        cellView.left = [self cellWidth] * (i % 7);
        cellView.top = cellHeight * (i / 7);
    }
}

- (TTView *) monthBar {
    if (!_monthBar) {
        _monthBar = [[[TTView alloc] init] autorelease];
        _monthBar.style = TTSTYLE(calendarMonthBarStyle);
        _monthBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview: _monthBar];
    }
    return _monthBar;
}

- (TTLabel *) monthLabel {
    if (!_monthLabel) {
        _monthLabel = [[[TTLabel alloc] init] autorelease];
        _monthLabel.style = TTSTYLE(calendarMonthLabelStyle);
        _monthLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        _monthLabel.backgroundColor = [UIColor clearColor];
        [self.monthBar addSubview: _monthLabel];
    }
    return _monthLabel;
}

- (TTButton *) monthBackButton {
    if (!_monthBackButton) {
        _monthBackButton = [TTButton buttonWithStyle: @"calendarMonthBackButton:" title: @"<"];
        [_monthBackButton addTarget: self
                             action: @selector(monthBack)
                   forControlEvents: UIControlEventTouchUpInside];
        [self.monthBar addSubview: _monthBackButton];
    }
    return _monthBackButton;
}

- (TTButton *) monthForwardButton {
    if (!_monthForwardButton) {
        _monthForwardButton = [TTButton buttonWithStyle: @"calendarMonthForwardButton:" title: @">"];
        [_monthForwardButton addTarget: self
                                action: @selector(monthForward)
                      forControlEvents: UIControlEventTouchUpInside];
        [self.monthBar addSubview: _monthForwardButton];
    }
    return _monthForwardButton;
}

- (TTView *) weekdayBar {
    if (!_weekdayBar) {
        _weekdayBar = [[[TTView alloc] init] autorelease];
        _weekdayBar.style = TTSTYLE(calendarWeekdayBarStyle);
        _weekdayBar.backgroundColor = [UIColor clearColor];
        NSDateFormatter *dateFromatter = [[[NSDateFormatter alloc] init] autorelease];
        dateFromatter.calendar = self.calendar;
        for (NSUInteger i = self.calendar.firstWeekday; i < self.calendar.firstWeekday + 7; ++i) {
            NSUInteger index = (i - 1) < 7 ? (i - 1) : ((i - 1) - 7);
            TTLabel *label = [[TTLabel alloc] initWithFrame: CGRectZero];
            label.style = TTSTYLE(calendarWeekdayLabelStyle);
            label.backgroundColor = [UIColor whiteColor];
            NSString *weekdayName = [[dateFromatter shortWeekdaySymbols] objectAtIndex: index];
            label.text = NSLocalizedString(weekdayName, @"");
            [_weekdayBar addSubview: label];
        }
        [self addSubview:_weekdayBar];
    }
    return _weekdayBar;
}

- (TTView *) gridView {
    if (!_gridView) {
        _gridView = [[[TTView alloc] init] autorelease];
        _gridView.style = TTSTYLE(calendarGridViewStyle);
        _gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview: _gridView];
    }
    return _gridView;
}

- (CGFloat)cellWidth {
    return (self.width - kGridMargin * 2) / 7.0;
}

@end
