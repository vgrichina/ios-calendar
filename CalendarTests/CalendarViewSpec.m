//
//  CalendarViewSpec.m
//  Calendar
//
//  Created by Vladimir Grichina on 13.07.11.
//  Copyright 2011 Componentix. All rights reserved.
//

#import "Kiwi.h"

#import "CXCalendarView.h"
#import "CXCalendarCellView.h"

SPEC_BEGIN(CalendarViewSpec)

describe(@"CalendarView", ^{
    __block CXCalendarView *calendarView = nil;

    beforeEach(^{
        calendarView = [[[CXCalendarView alloc] initWithFrame: CGRectMake(0, 0, 320, 480)] autorelease];        
    });

    it(@"selectedDate should be nil", ^{
        [calendarView.selectedDate shouldBeNil];
    });

    context(@"when month slides from 1 to 12", ^{
        beforeEach(^{
            calendarView.displayedDate = [NSDate dateWithTimeIntervalSince1970: 1262322305.0]; // 1th Jan, 2010
            [calendarView layoutSubviews];
            [calendarView monthBack];
        });

        it(@"should decrease year", ^{
            NSCalendar *calendar = [NSCalendar currentCalendar];
            [[theValue([calendar components: NSYearCalendarUnit fromDate:
                        calendarView.displayedDate ].year) should] equal: theValue(2009)];
        });
    });

    context(@"when month slides from 12 to 1", ^{
        beforeEach(^{
            calendarView.displayedDate = [NSDate dateWithTimeIntervalSince1970: 1293753600.0]; // 31th Dec, 2010
            [calendarView layoutSubviews];
            [calendarView monthForward];
        });

        it(@"should increase year", ^{
            NSCalendar *calendar = [NSCalendar currentCalendar];
            [[theValue([calendar components: NSYearCalendarUnit fromDate:
                        calendarView.displayedDate ].year) should] equal: theValue(2011)];
        });
    });

    context(@"when given valid date", ^{
        beforeEach(^{
            calendarView.displayedDate = [NSDate dateWithTimeIntervalSince1970: 1310601218.602]; // 14th July, 2011

            [calendarView layoutSubviews];
        });

        it(@"should have month bar", ^{
            [calendarView.monthBar shouldNotBeNil];
            [[calendarView.monthBar.superview should] equal: calendarView];
        });

        it(@"should layout month bar appropriately", ^{
            [[theValue(calendarView.monthLabel.bounds.size.width) should] equal: theValue(calendarView.bounds.size.width)];
            [[theValue(calendarView.monthLabel.bounds.size.height) should] equal: theValue(48)];
        });

        it(@"should layout month bar appropriately when frame is changed", ^{
            CGRect frame = calendarView.frame;
            frame.size.width = 50;
            frame.size.height = 100;
            calendarView.frame = frame;
            [[theValue(calendarView.monthLabel.bounds.size.width) should] equal: theValue(calendarView.bounds.size.width)];
            [[theValue(calendarView.monthLabel.bounds.size.height) should] equal: theValue(48)];
        });

        it(@"should display appropriate month label", ^{
            [calendarView.monthLabel shouldNotBeNil];
            [[calendarView.monthLabel.superview should] equal: calendarView.monthBar];
            NSString *expectedLabel = [NSString stringWithFormat: @"%@ 2011",
                                       [[[[NSDateFormatter new] autorelease] standaloneMonthSymbols] objectAtIndex: 06]];
            [[calendarView.monthLabel.text should] equal: expectedLabel];
        });

        it(@"should layout month label appropriately", ^{
            [[theValue(calendarView.monthLabel.bounds.size.width) should] equal: theValue(calendarView.bounds.size.width)];
            [[theValue(calendarView.monthLabel.bounds.size.height) should] equal: theValue(48)];
        });

        it(@"should layout month label appropriately when frame is changed", ^{
            CGRect frame = calendarView.frame;
            frame.size.width = 50;
            frame.size.height = 100;
            calendarView.frame = frame;
            [[theValue(calendarView.monthLabel.bounds.size.width) should] equal: theValue(calendarView.bounds.size.width)];
            [[theValue(calendarView.monthLabel.bounds.size.height) should] equal: theValue(48)];
        });

        it(@"should display month navigation buttons", ^{
            [calendarView.monthBackButton shouldNotBeNil];
            [[calendarView.monthBackButton.superview should] equal: calendarView.monthBar];
            [calendarView.monthForwardButton shouldNotBeNil];
            [[calendarView.monthForwardButton.superview should] equal: calendarView.monthBar];
        });

        it(@"should layout navigation buttons appropriately", ^{
            [[theValue(calendarView.monthBackButton.frame.origin.x) should] beZero];
            [[theValue(calendarView.monthBackButton.frame.origin.y) should] beZero];
            [[theValue(calendarView.monthBackButton.bounds.size.height) should] equal: theValue(calendarView.monthBar.bounds.size.height)];
            [[theValue(calendarView.monthBackButton.bounds.size.width) should] equal: theValue(60)];

            [[theValue(calendarView.monthForwardButton.frame.origin.x) should] equal: theValue(calendarView.monthBar.bounds.size.width - 60)];
            [[theValue(calendarView.monthForwardButton.frame.origin.y) should] beZero];
            [[theValue(calendarView.monthForwardButton.bounds.size.height) should] equal: theValue(calendarView.monthBar.bounds.size.height)];
            [[theValue(calendarView.monthForwardButton.bounds.size.width) should] equal: theValue(60)];
        });

        it(@"should have a grid view", ^{
            [calendarView.gridView shouldNotBeNil];
            [[calendarView.gridView.superview should] equal: calendarView];
        });

        it(@"should have enough cells in grid view", ^{
            [[[calendarView.gridView should] have: 31] subviews];
        });

        it(@"should have correct day numbers", ^{
            [[[[calendarView.gridView.subviews objectAtIndex: 0] titleForState: UIControlStateNormal] should] equal: @"1"];
            [[[[calendarView.gridView.subviews objectAtIndex: 30] titleForState: UIControlStateNormal] should] equal: @"31"];
        });

        it(@"should have cells sized appropriately", ^{
            for (CXCalendarCellView *cell in calendarView.gridView.subviews) {
                [[theValue(cell.bounds.size.width) should] equal: calendarView.gridView.bounds.size.width / 7.0 withDelta: 1.0];
                [[theValue(cell.bounds.size.height) should] equal: calendarView.gridView.bounds.size.height / 6.0 withDelta: 1.0];
            }
        });

        /*it(@"should advance to next month when forward button is pressed", ^{
            int oldMonth = [calendarView.calendar components: NSMonthCalendarUnit
                                                    fromDate: calendarView.displayedDate].month;
            [calendarView.monthForwardButton sendActionsForControlEvents: UIControlEventTouchUpInside];
            int newMonth = [calendarView.calendar components: NSMonthCalendarUnit
                                                    fromDate: calendarView.displayedDate].month;
            [[theValue(newMonth) should] equal: theValue(oldMonth + 1)];
        });

        it(@"should advance to previous month when back button is pressed", ^{
            int oldMonth = [calendarView.calendar components: NSMonthCalendarUnit
                                                    fromDate: calendarView.displayedDate].month;
            [calendarView.monthBackButton sendActionsForControlEvents: UIControlEventTouchUpInside];
            int newMonth = [calendarView.calendar components: NSMonthCalendarUnit
                                                    fromDate: calendarView.displayedDate].month;
            [[theValue(newMonth) should] equal: theValue(oldMonth - 1)];
        });*/
    });
});

SPEC_END
