//
//  CXCalendarView.h
//  Calendar
//
//  Created by Vladimir Grichina on 13.07.11.
//  Copyright 2011 Componentix. All rights reserved.
//

#import "CXCalendarCellView.h"


@class CXCalendarView;


@protocol CXCalendarViewDelegate <NSObject>

@optional

- (void) calendarView: (CXCalendarView *) calendarView
        didSelectDate: (NSDate *) selectedDate;

@end


@interface CXCalendarView : UIView {
@protected
    NSCalendar *_calendar;

    NSDate *_selectedDate;

    NSDate *_displayedDate;

    UIView *_monthBar;
    UILabel *_monthLabel;
    UIButton *_monthBackButton;
    UIButton *_monthForwardButton;
    UIView *_weekdayBar;
    NSArray *_weekdayNameLabels;
    UIView *_gridView;
    NSArray *_dayCells;

    CGFloat _monthBarHeight;
    CGFloat _weekBarHeight;

    NSDateFormatter *_dateFormatter;
}

@property(nonatomic, retain) NSCalendar *calendar;

@property(nonatomic, assign) IBOutlet id<CXCalendarViewDelegate> delegate;

@property(nonatomic, retain) NSDate *selectedDate;

@property(nonatomic, retain) NSDate *displayedDate;
@property(nonatomic, readonly) NSUInteger displayedYear;
@property(nonatomic, readonly) NSUInteger displayedMonth;

- (void) monthForward;
- (void) monthBack;

- (void) reset;

// UI
@property(readonly) UIView *monthBar;
@property(readonly) UILabel *monthLabel;
@property(readonly) UIButton *monthBackButton;
@property(readonly) UIButton *monthForwardButton;
@property(readonly) UIView *weekdayBar;
@property(readonly) NSArray *weekdayNameLabels;
@property(readonly) UIView *gridView;
@property(readonly) NSArray *dayCells;

@property(assign) CGFloat monthBarHeight;
@property(assign) CGFloat weekBarHeight;

- (CXCalendarCellView *) cellForDate: (NSDate *) date;


// Appearance
// TODO: UIAppearance support
@property(nonatomic, retain) UIColor *monthBarBackgroundColor;
@property(nonatomic, retain) NSDictionary *monthLabelTextAttributes;
@property(nonatomic, retain) NSDictionary *weekdayLabelTextAttributes;
@property(nonatomic, retain) NSDictionary *cellLabelNormalTextAttributes;
@property(nonatomic, retain) NSDictionary *cellLabelSelectedTextAttributes;
@property(nonatomic, retain) UIColor *cellNormalBackgroundColor;
@property(nonatomic, retain) UIColor *cellSelectedBackgroundColor;


@end