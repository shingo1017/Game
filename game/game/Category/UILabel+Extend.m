//
//  UILabel+Extend.m
//  library
//
//  Created by Shingo on 13-8-2.
//  Copyright (c) 2013年 Shingo. All rights reserved.
//

#import "UILabel+Extend.h"

@implementation UILabel(Extend)

+ (UILabel *)labelWithFontSize:(CGFloat)fontSize {
    
    UILabel *label = [UILabel new];
    label.textColor = WHITE_COLOR;
    label.font = [UIFont systemFontOfSize:fontSize];
    return label;
}

+ (UILabel *)captionWithText:(NSString *)text fontSize:(CGFloat)fontSize {
    
    UILabel *label = [UILabel new];
    label.textColor = WHITE_COLOR;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.text = text;
    [label sizeToFit];
    return label;
}

- (void)sizeToFitWithWidth:(CGFloat)width {
    
    if (self.frame.origin.x + self.frame.size.width > width) {
        
        CGRect rect = self.frame;
        rect.size.width = width-rect.origin.x;
        self.frame = rect;
    }
}

- (void)setTextAndSizeToFit:(NSString *)text {
    
    self.text = text;
    [self sizeToFit];
}

@end
