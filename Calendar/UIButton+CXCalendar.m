//
//  UIButton+CXCalendar.m
//  Calendar
//
//  Created by Vladimir Grichina on 09.06.13.
//  Copyright (c) 2013 Componentix. All rights reserved.
//

#import "UIButton+CXCalendar.h"

@implementation UIButton (CXCalendar)

- (void)cx_setTitleTextAttributes:(NSDictionary *)attrs forState:(UIControlState)state
{
    if (attrs[UITextAttributeFont]) {
        self.titleLabel.font = attrs[UITextAttributeFont];
    }
    if (attrs[UITextAttributeTextShadowOffset]) {
        self.titleLabel.shadowOffset = [attrs[UITextAttributeTextShadowOffset] CGSizeValue];
    }
    if (attrs[UITextAttributeTextColor]) {
        [self setTitleColor:attrs[UITextAttributeTextColor] forState:state];
    }
    if (attrs[UITextAttributeTextShadowColor]) {
        [self setTitleShadowColor:attrs[UITextAttributeTextShadowColor] forState:state];
    }
}

@end
