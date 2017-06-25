//
//  UIImage+Additions.h
//  It'sMyCoupon
//
//  Created by Shingo Yabuki on 12-6-4.
//  Copyright (c) 2012年 c2y. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (Additions)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color;
- (UIImage *)scaleToSize:(CGFloat)size;
- (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;
- (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

@end
