//
//  TestStyleSheet.m
//  Calendar
//
//  Created by Vladimir Grichina on 19.07.11.
//  Copyright 2011 Componentix. All rights reserved.
//

#import "TestStyleSheet.h"

@implementation TestStyleSheet

- (TTStyle *) calendarCellStyle: (UIControlState) state {
    return [TTTextStyle styleWithColor: [UIColor grayColor] next: nil];
}

@end
