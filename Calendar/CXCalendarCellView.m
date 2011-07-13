//
//  CXCalendarCellView.m
//  Calendar
//
//  Created by Vladimir Grichina on 13.07.11.
//  Copyright 2011 Componentix. All rights reserved.
//

#import "CXCalendarCellView.h"

@implementation CXCalendarCellView

- (TTLabel *) label {
    if (!_label) {
        _label = [[TTLabel new] autorelease];
        _label.frame = self.bounds;
        _label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview: _label];
    }

    return _label;
}

- (NSDate *) date {
    return _date;
}

- (void) setDate: (NSDate *) date {
    if (![date isEqual: _date]) {
        [_date release];
        _date = [date retain];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        int day = [calendar components: NSDayCalendarUnit fromDate: self.date].day;
        self.label.text = [NSString stringWithFormat: @"%d", day];
    }
}

@end
