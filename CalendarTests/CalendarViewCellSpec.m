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
        cellView = [[CXCalendarCellView new] autorelease];
    });
    
    context(@"when foo", ^{
        it(@"should bar", ^{
            
        });
    });
});

SPEC_END
