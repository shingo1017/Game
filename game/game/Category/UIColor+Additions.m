//
//  UIColor+Additions.m
//  worldOfZombie
//
//  Created by 尹楠 on 15/7/8.
//  Copyright (c) 2015年 c2y. All rights reserved.
//

#import "UIColor+Additions.h"

@implementation UIColor (Additions)

+ (UIColor *)colorWithValue:(CGFloat)value mid:(NSInteger)mid low:(NSInteger)low {
    
    UIColor *color;
    if (value >= mid)
        color = GREEN_VALUE_COLOR;
    else if (value < mid && value >= low)
        color = YELLOW_VALUE_COLOR;
    else
        color = RED_VALUE_COLOR;
    
    return color;
}

+ (UIColor *)colorWithValue:(CGFloat)value mid:(NSInteger)mid low:(NSInteger)low desc:(BOOL)desc {
    
    UIColor *color;
    if (value >= mid)
        color = desc ? RED_VALUE_COLOR : GREEN_VALUE_COLOR;
    else if (value < mid && value >= low)
        color = YELLOW_VALUE_COLOR;
    else
        color = desc ? GREEN_VALUE_COLOR : RED_VALUE_COLOR;
    
    return color;
}

+ (UIColor *)colorWithValue:(CGFloat)value max:(NSInteger)max midp:(CGFloat)midp lowp:(CGFloat)lowp {
    
    UIColor *color;
    if (value/max >= midp)
        color = GREEN_VALUE_COLOR;
    else if (value/max < midp && value/max >= lowp)
        color = YELLOW_VALUE_COLOR;
    else
        color = RED_VALUE_COLOR;
    
    return color;
}

@end
