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


@class CXCalendarView;


@protocol CXCalendarViewDelegate <NSObject>

@optional

- (void) calendarView: (CXCalendarView *) calendarView
        didSelectDate: (NSDate *) selectedDate;

@end


@interface CXCalendarView : TTView {
@protected
    NSCalendar *_calendar;

    NSDate *_selectedDate;

    NSDate *_displayedDate;

    TTView *_monthBar;
    TTLabel *_monthLabel;
    TTButton *_monthBackButton;
    TTButton *_monthForwardButton;
    TTView *_weekdayBar;
    NSArray *_weekdayNameLabels;
    TTView *_gridView;
    NSArray *_dayCells;

    CGFloat _monthBarHeight;
    CGFloat _weekBarHeight;
}

@property(nonatomic, retain) NSCalendar *calendar;

@property(nonatomic, assign) id<CXCalendarViewDelegate> delegate;

@property(nonatomic, retain) NSDate *selectedDate;

@property(nonatomic, retain) NSDate *displayedDate;
@property(nonatomic, readonly) NSUInteger displayedYear;
@property(nonatomic, readonly) NSUInteger displayedMonth;

- (void) monthForward;
- (void) monthBack;

- (void) reset;

// UI
@property(readonly) TTView *monthBar;
@property(readonly) TTLabel *monthLabel;
@property(readonly) TTButton *monthBackButton;
@property(readonly) TTButton *monthForwardButton;
@property(readonly) TTView *weekdayBar;
@property(readonly) NSArray *weekdayNameLabels;
@property(readonly) TTView *gridView;
@property(readonly) NSArray *dayCells;

@property(assign) CGFloat monthBarHeight;
@property(assign) CGFloat weekBarHeight;

- (CXCalendarCellView *) cellForDate: (NSDate *) date;

@end