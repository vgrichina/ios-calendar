//
//  CXCalendarCellView.h
//  Calendar
//
//  Created by Vladimir Grichina on 13.07.11.
//  Copyright 2011 Componentix. All rights reserved.
//

#import <Three20UI/Three20UI+Additions.h>
#import <Three20Style/Three20Style+Additions.h>

@interface CXCalendarCellView : TTView {
    NSDate *_date;
    TTLabel *_label;
}

@property(retain) NSDate *date;
@property(readonly) TTLabel *label;

@end
