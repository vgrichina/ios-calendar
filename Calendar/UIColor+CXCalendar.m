//
//  UIColor+CXCalendar.m
//  Calendar
//
//  Created by Vladimir Grichina on 08.06.13.
//  Copyright (c) 2013 Componentix. All rights reserved.
//

#import "UIColor+CXCalendar.h"


@implementation UIColor (CXCalendar)

+ (UIColor *)cx_colorWithGradient:(CGGradientRef)gradient size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGContextDrawLinearGradient(UIGraphicsGetCurrentContext(), gradient, CGPointZero, CGPointMake(size.width - 1,  size.height - 1), 0);
    UIImage *pattern = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIColor colorWithPatternImage:pattern];
}

@end
