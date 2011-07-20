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
    if (state & UIControlStateDisabled) {
        return [TTTextStyle styleWithColor: [UIColor clearColor] next: nil];
    }

    if (state & UIControlStateSelected) {
        return [TTSolidFillStyle styleWithColor: [UIColor grayColor] next:
                [TTTextStyle styleWithColor: [UIColor whiteColor] next: nil]];
    }

    return [TTTextStyle styleWithColor: [UIColor grayColor] next: nil];
}

- (TTStyle *) calendarMonthLabelStyle {
    return
    [TTLinearGradientFillStyle styleWithColor1: RGBCOLOR(188, 200, 215)
                                        color2: RGBCOLOR(125, 150, 179) next:
     [TTFourBorderStyle styleWithTop: RGBCOLOR(213, 221, 230)
                               right: nil
                              bottom: RGBCOLOR(57, 70, 84)
                                left: nil
                               width: 1 next:
       [TTTextStyle styleWithFont: [UIFont systemFontOfSize: [UIFont buttonFontSize]]
                            color: [UIColor whiteColor]
                      shadowColor: [UIColor grayColor]
                     shadowOffset: CGSizeMake(0, 1) next: nil]]];
}

- (TTStyle *) calendarGridViewStyle {
    return [TTSolidFillStyle styleWithColor: [UIColor whiteColor] next: nil];
}

@end
