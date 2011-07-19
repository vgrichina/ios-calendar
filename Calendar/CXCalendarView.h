//
//  CXCalendarView.h
//  Calendar
//
//  Created by Vladimir Grichina on 13.07.11.
//  Copyright 2011 Componentix. All rights reserved.
//

#import <Three20UI/Three20UI+Additions.h>
#import <Three20Style/Three20Style+Additions.h>

#import "CXCalendarCellView.h"

@interface CXCalendarView : TTView {
    NSDate *_selectedDate;

    TTLabel *_monthLabel;
    TTView *_gridView;
}

@property(retain) NSDate *selectedDate;
@property(readonly) TTLabel *monthLabel;
@property(readonly) TTView *gridView;

- (CXCalendarCellView *) cellForDate: (NSDate *) date;

@end
