//
//  CXMultidateCalendarView.h
//  Calendar
//
//  Created by Roman Rader on 22.11.11.
//  Copyright 2011 Componentix. All rights reserved.
//

#import "CXCalendarView.h"


@protocol CXMultidateCalendarViewDelegate <CXCalendarViewDelegate>

@optional

- (void) calendarView: (CXCalendarView *) calendarView
   didSelectRangeFrom: (NSDate *) startDate
                   to: (NSDate *) endDate;

@end


@interface CXMultidateCalendarView : CXCalendarView {
    NSDate *_startDate;
    NSDate *_endDate;
}

@property(nonatomic, assign) id<CXMultidateCalendarViewDelegate> delegate;

@property(nonatomic, retain) NSDate *startDate;
@property(nonatomic, retain) NSDate *endDate;

- (void) reset;

@end