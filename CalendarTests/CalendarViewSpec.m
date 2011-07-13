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
        calendarView = [[CXCalendarView new] autorelease];
    });
    
    context(@"when foo", ^{
        it(@"should bar", ^{

        });
    });
});

SPEC_END
