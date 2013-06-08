//
//  UILabel+CXCalendar.m
//  Calendar
//
//  Created by Vladimir Grichina on 09.06.13.
//  Copyright (c) 2013 Componentix. All rights reserved.
//

#import "UILabel+CXCalendar.h"

@implementation UILabel (CXCalendar)

- (void)cx_setTextAttributes:(NSDictionary *)attrs
{
    if (attrs[UITextAttributeFont]) {
        self.font = attrs[UITextAttributeFont];
    }
    if (attrs[UITextAttributeTextColor]) {
        self.textColor = attrs[UITextAttributeTextColor];
    }
    if (attrs[UITextAttributeTextShadowColor]) {
        self.shadowColor = attrs[UITextAttributeTextShadowColor];
    }
    if (attrs[UITextAttributeTextShadowOffset]) {
        self.shadowOffset = [attrs[UITextAttributeTextShadowOffset] CGSizeValue];
    }
}

@end
