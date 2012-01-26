//
//  CXMultidateCalendarView.m
//  Calendar
//
//  Created by Roman Rader on 22.11.11.
//  Copyright 2011 Componentix. All rights reserved.
//

#import "CXMultidateCalendarView.h"

#import "CXCalendarCellView.h"


@implementation CXMultidateCalendarView

@synthesize startDate = _startDate;
@synthesize endDate = _endDate;

@synthesize delegate;

- (id) initWithFrame: (CGRect) frame {
    if ((self = [super initWithFrame: frame])) {
        self.startDate = nil;
        self.endDate = nil;
    }
    return self;
}

- (void) dealloc {
    [_startDate release];
    [_endDate release];

    [super dealloc];
}

- (NSDate *) startDate {
    return _startDate;
}

- (void) setStartDate: (NSDate *) startDate {
    if (_startDate != startDate) {
        [_startDate release];
        _startDate = [startDate retain];
        [self setNeedsLayout];
    }
}

- (NSDate *) endDate {
    return _endDate;
}

- (void) setEndDate: (NSDate *) endDate {
    if (_endDate != endDate) {
        [_endDate release];
        _endDate = [endDate retain];
        [self setNeedsLayout];
    }
}

- (void) layoutSubviews {
    [super layoutSubviews];

    for (CXCalendarCellView *cellView in _gridView.subviews) {
        NSDate *date = [cellView dateWithBaseDate:self.displayedDate withCalendar:self.calendar];
        if (self.startDate && self.endDate &&
            (([date compare: self.startDate]) != NSOrderedAscending) &&
            (([date compare: self.endDate]) != NSOrderedDescending)) {
            cellView.selected = YES;
        } else {
            cellView.selected = NO;
        }
    }
}

- (void) reset {
    self.startDate = nil;
    self.endDate = nil;

    [super reset];
}

- (void) touchedCellView: (CXCalendarCellView *) cellView {
    NSDate *date = [cellView dateWithBaseDate: self.displayedDate withCalendar: self.calendar];
    if ([self.startDate isEqualToDate:self.endDate]) {
        if ([self.startDate compare: date] == NSOrderedAscending) {
            self.endDate = date;
        } else {
            id tmp = self.startDate;
            self.startDate = date;
            self.endDate = tmp;
        }
        if ([self.delegate respondsToSelector:@selector(calendarView:didSelectRangeFrom:to:)]) {
            [self.delegate calendarView:self
                     didSelectRangeFrom:self.startDate
                                     to:self.endDate];
        }
    } else {
        self.startDate = date;
        self.endDate = date;
        if ([self.delegate respondsToSelector:@selector(calendarView:didSelectDate:)]) {
            [self.delegate calendarView: self didSelectDate: date];
        }
    }
}

@end