//
//  CXCalendarCellView.h
//  Calendar
//
//  Created by Vladimir Grichina on 13.07.11.
//  Copyright 2011 Componentix. All rights reserved.
//

#import <Three20UI/Three20UI+Additions.h>
#import <Three20Style/Three20Style+Additions.h>


@interface CXCalendarCellView : TTButton {
    NSUInteger _day;
}

@property(nonatomic, assign) NSUInteger day;

- (NSDate *) dateWithBaseDate: (NSDate *) baseDate withCalendar: (NSCalendar *)calendar;

@end
