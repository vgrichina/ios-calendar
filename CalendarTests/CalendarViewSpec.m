//
//  CalendarViewSpec.m
//  Calendar
//
//  Created by Vladimir Grichina on 13.07.11.
//  Copyright 2011 Componentix. All rights reserved.
//

#import "Kiwi.h"

#import "TestStyleSheet.h"

#import "CXCalendarView.h"
#import "CXCalendarCellView.h"

SPEC_BEGIN(CalendarViewSpec)

describe(@"CalendarView", ^{
    __block CXCalendarView *calendarView = nil;

    beforeEach(^{
        calendarView = [[[CXCalendarView alloc] initWithFrame: CGRectMake(0, 0, 320, 480)] autorelease];
    });

    context(@"when given valid date", ^{
        beforeEach(^{
            calendarView.selectedDate = [NSDate dateWithTimeIntervalSince1970: 1310601218.602]; // 14th July, 2011
        });

        it(@"should display appropriate month label", ^{
            [calendarView.monthLabel shouldNotBeNil];
            [[calendarView.monthLabel.text should] equal:
             [[[[NSDateFormatter new] autorelease] monthSymbols] objectAtIndex: 06]];
        });

        it(@"should layout month label appropriately", ^{
            [[theValue(calendarView.monthLabel.width) should] equal: theValue(calendarView.width)];
            [[theValue(calendarView.monthLabel.height) should] equal: theValue(48)];
        });

        it(@"should layout month label appropriately when frame is changed", ^{
            calendarView.width = 50;
            calendarView.height = 100;
            [[theValue(calendarView.monthLabel.width) should] equal: theValue(calendarView.width)];
            [[theValue(calendarView.monthLabel.height) should] equal: theValue(48)];
        });

        it(@"should have a grid view", ^{
            [calendarView.gridView shouldNotBeNil];
            [[calendarView.gridView.superview should] equal: calendarView];
        });

        it(@"should have enough cells in grid view", ^{
            [[[calendarView.gridView should] have: 35] subviews];
        });

        it(@"should have correct day numbers", ^{
            [[[[calendarView.gridView.subviews objectAtIndex: 0] titleForState: UIControlStateNormal] should] equal: @"27"];
            [[[[calendarView.gridView.subviews objectAtIndex: 4] titleForState: UIControlStateNormal] should] equal: @"1"];
            [[[[calendarView.gridView.subviews objectAtIndex: 34] titleForState: UIControlStateNormal] should] equal: @"31"];
        });

        it(@"should have cells sized appropriately", ^{
            for (CXCalendarCellView *cell in calendarView.gridView.subviews) {
                [[theValue(cell.width) should] equal: calendarView.width / 7.0 withDelta: 1.0];
                [[theValue(cell.height) should] equal: calendarView.height / 6.0 withDelta: 1.0];
            }
        });


        it(@"should have cells placed appropriately", ^{
            int i = 0;
            for (CXCalendarCellView *cell in calendarView.gridView.subviews) {
                [[theValue(cell.left) should] equal: (calendarView.width / 7.0) * (i % 7) withDelta: 1.0];
                [[theValue(cell.top) should] equal: calendarView.height / 6.0 * (i / 7) withDelta: 1.0];

                i++;
            }
        });

        it(@"should have selected appropriate cell view", ^{
            [[theValue([[calendarView.gridView.subviews objectAtIndex: 17] state]) should] equal: theValue(UIControlStateSelected)];
        });
    });

    context(@"when stylesheet is set", ^{
        beforeEach(^{
            [TTStyleSheet setGlobalStyleSheet: [[TestStyleSheet new] autorelease]];
            calendarView.selectedDate = [NSDate dateWithTimeIntervalSince1970: 1310601218.602]; // 14th July, 2011
        });

        it(@"should have cells styled appropriately", ^{
            for (CXCalendarCellView *cell in calendarView.gridView.subviews) {
                [[cell styleForState: UIControlStateNormal] shouldNotBeNil];
                [[[cell styleForState: UIControlStateNormal] should] equal:
                 [TTSTYLESHEET styleWithSelector: @"calendarCellStyle:" forState: UIControlStateNormal]];
            }
        });
    });
});

SPEC_END
