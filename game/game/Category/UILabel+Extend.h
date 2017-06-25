//
//  UILabel+Extend.h
//  library
//
//  Created by Shingo on 13-8-2.
//  Copyright (c) 2013年 Shingo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel(Extend)

+ (UILabel *)captionWithText:(NSString *)text fontSize:(CGFloat)fontSize;
+ (UILabel *)labelWithFontSize:(CGFloat)fontSize;

- (void)sizeToFitWithWidth:(CGFloat)width;
- (void)setTextAndSizeToFit:(NSString *)text;

@end
