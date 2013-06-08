//
//  CXCalendarCellView.m
//  Calendar
//
//  Created by Vladimir Grichina on 13.07.11.
//  Copyright 2011 Componentix. All rights reserved.
//

#import "CXCalendarCellView.h"

@implementation CXCalendarCellView

- (void) setDay: (NSUInteger) day {
    if (_day != day) {
        _day = day;
        [self setTitle: [NSString stringWithFormat: @"%d", _day] forState: UIControlStateNormal];
    }
}

- (NSDate *) dateWithBaseDate: (NSDate *) baseDate withCalendar: (NSCalendar *)calendar {
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit
                                               fromDate:baseDate];
    components.day = self.day;
    return [calendar dateFromComponents:components];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];

    if (selected) {
        self.backgroundColor = self.selectedBackgroundColor;
    } else {
        self.backgroundColor = self.normalBackgroundColor;
    }
}

@end
