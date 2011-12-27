//
//  CXCalendarCellView.m
//  Calendar
//
//  Created by Vladimir Grichina on 13.07.11.
//  Copyright 2011 Componentix. All rights reserved.
//

#import "CXCalendarCellView.h"

@implementation CXCalendarCellView

- (id) initWithFrame: (CGRect) frame {
    if ((self = [super initWithFrame: frame])) {
        [self setStylesWithSelector:@"calendarCellStyle:"];
    }

    return self;
}

- (void) dealloc {
    [_date release];

    [super dealloc];
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
        [self setTitle: [NSString stringWithFormat: @"%d", day] forState: UIControlStateNormal];
    }
}

@end
