//
//  CXCalendarView.h
//  Calendar
//
//  Created by Vladimir Grichina on 13.07.11.
//  Copyright 2011 Componentix. All rights reserved.
//

#import <Three20UI/Three20UI+Additions.h>
#import <Three20Style/Three20Style+Additions.h>

@interface CXCalendarView : TTView {
    TTLabel *_monthLabel;
    NSDate *_selectedDate;
}

@property(readonly) TTLabel *monthLabel;
@property(retain) NSDate *selectedDate;

@end
