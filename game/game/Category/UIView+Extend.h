//
//  UIView+Extend.h
//  library
//
//  Created by Shingo on 13-8-2.
//  Copyright (c) 2013年 Shingo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(Extend)

+ (UIView *)viewWithName:(NSString *)name;
+ (UIView *)lineWithFrame:(CGRect)frame;

- (UIViewController *)viewController;

- (void)clearBorderStyle;
- (void)searchContainerStyle;
- (void)heavyborderStyle;
- (void)lightBorderStyle;
- (void)borderStyle;
- (void)borderStyleWithColor:(UIColor *)color;
- (void)cornerRadiusStyle;
- (void)cornerRadiusStyleWithValue:(CGFloat)value;
- (void)roundStyle;
- (void)roundWidthStyle;
- (void)roundHeightStyle;
- (UIColor *)colorAtPosition:(UIImage *)image position:(CGPoint)position;
- (UIColor *)colorAtPosition:(CGPoint)position;
- (CGSize)fitSize;
- (void)sizeToFitAndSetPoint:(CGPoint)point;

@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;

@end
