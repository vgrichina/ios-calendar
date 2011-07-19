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

    context(@"when created", ^{
        it(@"should be subclass of TTButton", ^{
            [[cellView should] beKindOfClass: [TTButton class]];
        });
    });

    context(@"when given valid date", ^{
        beforeEach(^{
            cellView.date = [NSDate date];
        });

        it(@"should display appropriate day label", ^{
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *components = [calendar components: NSDayCalendarUnit
                                                       fromDate: cellView.date];
            [[cellView titleForState: UIControlStateNormal] shouldNotBeNil];
            [[[cellView titleForState: UIControlStateNormal] should] equal:
                [NSString stringWithFormat: @"%d", components.day]];
        });
    });
});

SPEC_END
