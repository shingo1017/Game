//
//  UIColor+Additions.h
//  worldOfZombie
//
//  Created by 尹楠 on 15/7/8.
//  Copyright (c) 2015年 c2y. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Additions)

+ (UIColor *)colorWithValue:(CGFloat)value mid:(NSInteger)mid low:(NSInteger)low;
+ (UIColor *)colorWithValue:(CGFloat)value mid:(NSInteger)mid low:(NSInteger)low desc:(BOOL)desc;
+ (UIColor *)colorWithValue:(CGFloat)value max:(NSInteger)max midp:(CGFloat)midp lowp:(CGFloat)lowp;

@end
