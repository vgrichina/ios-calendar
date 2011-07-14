//
//  CXCalendarView.m
//  Calendar
//
//  Created by Vladimir Grichina on 13.07.11.
//  Copyright 2011 Componentix. All rights reserved.
//

#import "CXCalendarView.h"

@implementation CXCalendarView

static const CGFloat kDefaultMonthLabelHeight = 48;

- (NSDate *) selectedDate {
    return _selectedDate;
}

- (void) setSelectedDate: (NSDate *) selectedDate {
    if (![selectedDate isEqual: _selectedDate]) {
        [_selectedDate release];
        _selectedDate = [selectedDate retain];

        NSCalendar *calendar = [NSCalendar currentCalendar];
        int month = [calendar components: NSMonthCalendarUnit fromDate: self.selectedDate].month;
        self.monthLabel.text = [[[[NSDateFormatter new] autorelease] monthSymbols] objectAtIndex: month - 1];
    }
}

- (TTLabel *) monthLabel {
    if (!_monthLabel) {
        _monthLabel = [TTLabel new];
        [self addSubview: _monthLabel];
        _monthLabel.height = kDefaultMonthLabelHeight;
        _monthLabel.width = self.width;
        _monthLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    }

    return _monthLabel;
}

@end
