//
//  CalendarViewCellSpec.m
//  Calendar
//
//  Created by Vladimir Grichina on 13.07.11.
//  Copyright 2011 Componentix. All rights reserved.
//

#import "Kiwi.h"

#import "CXCalendarCellView.h"

SPEC_BEGIN(CalendarCellViewSpec)

describe(@"CalendarCellView", ^{
    __block CXCalendarCellView *cellView = nil;

    beforeEach(^{
        cellView = [[CXCalendarCellView alloc] initWithFrame: CGRectMake(0, 0, 100, 50)];
    });

    context(@"when given valid date", ^{
        beforeEach(^{
            cellView.date = [NSDate date];
        });

        it(@"displays appropriate day label", ^{
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *components = [calendar components: NSDayCalendarUnit
                                                       fromDate: cellView.date];
            [cellView.label shouldNotBeNil];
            [[cellView.label.text should] equal:
                [NSString stringWithFormat: @"%d", components.day]];
        });

        it(@"places day label appropriately", ^{
            [[theValue(cellView.label.width) should] equal: theValue(cellView.width)];
            [[theValue(cellView.label.height) should] equal: theValue(cellView.height)];
        });

        it(@"places day label appropriately when frame is changed", ^{
            cellView.width = 50;
            cellView.height = 100;
            [[theValue(cellView.label.width) should] equal: theValue(cellView.width)];
            [[theValue(cellView.label.height) should] equal: theValue(cellView.height)];
        });
    });
});

SPEC_END
