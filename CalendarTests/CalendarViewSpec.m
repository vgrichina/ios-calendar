//
//  CalendarViewSpec.m
//  Calendar
//
//  Created by Vladimir Grichina on 13.07.11.
//  Copyright 2011 Componentix. All rights reserved.
//

#import "Kiwi.h"

#import "CXCalendarView.h"

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

        it(@"displays appropriate month label", ^{
            [calendarView.monthLabel shouldNotBeNil];
            [[calendarView.monthLabel.text should] equal:
             [[[[NSDateFormatter new] autorelease] monthSymbols] objectAtIndex: 06]];
        });

        it(@"places month label appropriately", ^{
            [[theValue(calendarView.monthLabel.width) should] equal: theValue(calendarView.width)];
            [[theValue(calendarView.monthLabel.height) should] equal: theValue(48)];
        });

        it(@"places month label appropriately when frame is changed", ^{
            calendarView.width = 50;
            calendarView.height = 100;
            [[theValue(calendarView.monthLabel.width) should] equal: theValue(calendarView.width)];
            [[theValue(calendarView.monthLabel.height) should] equal: theValue(48)];
        });

        it(@"have a grid view", ^{
            [calendarView.gridView shouldNotBeNil];
        });

        it(@"have enough cells in grid view", ^{
            [[[calendarView.gridView should] have: 35] subviews];
        });
    });
});

SPEC_END
