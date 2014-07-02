//
//  CXCalendarView.m
//  Calendar
//
//  Created by Vladimir Grichina on 13.07.11.
//  Copyright 2011 Componentix. All rights reserved.
//

#import "CXCalendarView.h"

#import "CXCalendarCellView.h"


static const CGFloat kGridMargin = 4;


@implementation CXCalendarView

@synthesize delegate;

static const CGFloat kDefaultMonthBarButtonWidth = 60;

- (id) initWithFrame: (CGRect) frame {
    if ((self = [super initWithFrame: frame])) {
        self.backgroundColor = [UIColor clearColor];

        self.selectedDate = nil;
        self.displayedDate = [NSDate date];

        _monthBarHeight = 48;
        _weekBarHeight = 32;
    }
    return self;
}

- (void) dealloc {
    [_calendar release];
    [_selectedDate release];
    [_displayedDate release];

    [super dealloc];
}

- (NSCalendar *) calendar {
    if (!_calendar) {
        _calendar = [[NSCalendar currentCalendar] retain];
    }
    return _calendar;
}

- (void) setCalendar: (NSCalendar *) calendar {
    if (_calendar != calendar) {
        [_calendar release];
        _calendar = [calendar retain];
        [self setNeedsLayout];
    }
}

- (NSDate *) selectedDate {
    return _selectedDate;
}

- (void) setSelectedDate: (NSDate *) selectedDate {
    if (![selectedDate isEqual: _selectedDate]) {
        [_selectedDate release];
        _selectedDate = [selectedDate retain];

        for (CXCalendarCellView *cellView in self.dayCells) {
            cellView.selected = NO;
        }

        [[self cellForDate: selectedDate] setSelected: YES];

        if ([self.delegate respondsToSelector:@selector(calendarView:didSelectDate:)]) {
            [self.delegate calendarView: self didSelectDate: _selectedDate];
        }
    }
}

- (NSDate *) displayedDate {
    return _displayedDate;
}

- (void) setDisplayedDate: (NSDate *) displayedDate {
    if (_displayedDate != displayedDate) {
        [_displayedDate release];
        _displayedDate = [displayedDate retain];

        NSString *monthName = [[[[NSDateFormatter new] autorelease] standaloneMonthSymbols] objectAtIndex: self.displayedMonth - 1];
        self.monthLabel.text = [NSString stringWithFormat: @"%@ %d", NSLocalizedString(monthName, @""), self.displayedYear];

        [self setNeedsLayout];
    }
}

- (NSUInteger)displayedYear {
    NSDateComponents *components = [self.calendar components: NSYearCalendarUnit
                                                    fromDate: self.displayedDate];
    return components.year;
}

- (NSUInteger)displayedMonth {
    NSDateComponents *components = [self.calendar components: NSMonthCalendarUnit
                                                    fromDate: self.displayedDate];
    return components.month;
}

- (CGFloat) monthBarHeight {
    return _monthBarHeight;
}

- (void) setMonthBarHeight: (CGFloat) monthBarHeight {
    if (_monthBarHeight != monthBarHeight) {
        _monthBarHeight = monthBarHeight;
        [self setNeedsLayout];
    }
}

- (CGFloat) weekBarHeight {
    return _weekBarHeight;
}

- (void) setWeekBarHeight: (CGFloat) weekBarHeight {
    if (_weekBarHeight != weekBarHeight) {
        _weekBarHeight = weekBarHeight;
        [self setNeedsLayout];
    }
}

- (void) touchedCellView: (CXCalendarCellView *) cellView {
    self.selectedDate = [cellView dateWithBaseDate: self.displayedDate withCalendar: self.calendar];
}

- (void) monthForward {
    NSDateComponents *monthStep = [[NSDateComponents new] autorelease];
    monthStep.month = 1;
    self.displayedDate = [self.calendar dateByAddingComponents: monthStep toDate: self.displayedDate options: 0];
}

- (void) monthBack {
    NSDateComponents *monthStep = [[NSDateComponents new] autorelease];
    monthStep.month = -1;
    self.displayedDate = [self.calendar dateByAddingComponents: monthStep toDate: self.displayedDate options: 0];
}

- (void) reset {
    self.selectedDate = nil;
}

- (NSDate *) displayedMonthStartDate {
    NSDateComponents *components = [self.calendar components: NSMonthCalendarUnit|NSYearCalendarUnit
                                                    fromDate: self.displayedDate];
    components.day = 1;
    return [self.calendar dateFromComponents: components];
}

- (CXCalendarCellView *) cellForDate: (NSDate *) date {
    if (!date) {
        return nil;
    }

    NSDateComponents *components = [self.calendar components: NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit
                                                    fromDate: date];
    if (components.month == self.displayedMonth &&
        components.year == self.displayedYear &&
        [self.dayCells count] >= components.day) {
        return [self.dayCells objectAtIndex: components.day - 1];
    }
    return nil;
}

- (void) layoutSubviews {
    [super layoutSubviews];

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
        for (NSUInteger i = 0; i < [self.weekdayNameLabels count]; ++i) {
            TTLabel *label = [self.weekdayNameLabels objectAtIndex:i];
            label.left = (self.weekdayBar.width / 7) * (i % 7);
            label.top = 0;
            label.width = (self.weekdayBar.width / 7);
            label.height = self.weekdayBar.height;
        }
        top = self.weekdayBar.top + self.weekdayBar.height;
    } else {
        self.weekdayBar.frame = CGRectZero;
    }

    // Calculate shift
    NSDateComponents *components = [self.calendar components: NSWeekdayCalendarUnit
                                                    fromDate: [self displayedMonthStartDate]];
    NSInteger shift = components.weekday - self.calendar.firstWeekday;
    if (shift < 0) {
        shift = 7 + shift;
    }

    // Calculate range
    NSRange range = [self.calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit
                                       forDate:self.displayedDate];

    self.gridView.frame = CGRectMake(kGridMargin, top, self.width - kGridMargin * 2, self.height - top);
    CGFloat cellHeight = self.gridView.height / 6.0;
    for (NSUInteger i = 0; i < [self.dayCells count]; ++i) {
        CXCalendarCellView *cellView = [self.dayCells objectAtIndex:i];
        cellView.width = (self.width - kGridMargin * 2) / 7.0;
        cellView.height = cellHeight;
        cellView.left = cellView.width * ((shift + i) % 7);
        cellView.top = cellHeight * ((shift + i) / 7);
        cellView.hidden = i >= range.length;
        cellView.selected = [[cellView dateWithBaseDate:self.displayedDate withCalendar:self.calendar] isEqualToDate:self.selectedDate];
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
    }
    return _weekdayBar;
}

- (NSArray *) weekdayNameLabels {
    if (!_weekdayNameLabels) {
        NSMutableArray *labels = [NSMutableArray array];
        NSDateFormatter *dateFromatter = [[[NSDateFormatter alloc] init] autorelease];
        dateFromatter.calendar = self.calendar;
        for (NSUInteger i = self.calendar.firstWeekday; i < self.calendar.firstWeekday + 7; ++i) {
            NSUInteger index = (i - 1) < 7 ? (i - 1) : ((i - 1) - 7);
            TTLabel *label = [[[TTLabel alloc] initWithFrame: CGRectZero] autorelease];
            label.tag = i;
            label.style = TTSTYLE(calendarWeekdayLabelStyle);
            label.backgroundColor = [UIColor whiteColor];
            NSString *weekdayName = [[dateFromatter shortWeekdaySymbols] objectAtIndex: index];
            label.text = NSLocalizedString(weekdayName, @"");
            [labels addObject:label];
            [_weekdayBar addSubview: label];
        }
        [self addSubview:_weekdayBar];
        _weekdayNameLabels = [[NSArray alloc] initWithArray:labels];
    }
    return _weekdayNameLabels;
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

- (NSArray *) dayCells {
    if (!_dayCells) {
        NSMutableArray *cells = [NSMutableArray array];
        for (NSUInteger i = 1; i <= 31; ++i) {
            CXCalendarCellView *cell = [[CXCalendarCellView new] autorelease];
            cell.tag = i;
            cell.day = i;
            [cell addTarget: self
                     action: @selector(touchedCellView:)
           forControlEvents: UIControlEventTouchUpInside];
            [cells addObject:cell];
            [self.gridView addSubview: cell];
        }
        _dayCells = [[NSArray alloc] initWithArray:cells];
    }
    return _dayCells;
}

@end
