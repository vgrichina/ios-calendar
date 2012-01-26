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
        cellView = [[[CXCalendarCellView alloc] initWithFrame: CGRectMake(0, 0, 100, 50)] autorelease];
    });

    context(@"when created", ^{
        it(@"should be subclass of TTButton", ^{
            [[cellView should] beKindOfClass: [UIButton class]];
        });
    });

    context(@"when given valid date", ^{
        static const NSUInteger DAY = 1;

        beforeEach(^{
            cellView.day = DAY;
        });

        it(@"should display appropriate day label", ^{
            [[cellView titleForState: UIControlStateNormal] shouldNotBeNil];
            [[[cellView titleForState: UIControlStateNormal] should] equal:
                [NSString stringWithFormat: @"%d", DAY]];
        });
    });
});

SPEC_END
