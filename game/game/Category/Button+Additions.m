//
//  Button+Additions.m
//  Entlphone
//
//  Created by wangyanan on 14-8-14.
//  Copyright (c) 2014年 Shingo. All rights reserved.
//

#import "Button+Additions.h"
#import "UIImage+Additions.h"

@implementation Button (Additions)

+ (Button *)buttonWithTitle:(NSString *)title {
    
    Button *button = [Button buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:BLACK_COLOR forState:UIControlStateNormal];
    [button setTitleColor:WHITE_COLOR forState:UIControlStateDisabled];
    [button setBackgroundImage:[UIImage imageWithColor:WHITE_COLOR] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:BLACK_COLOR] forState:UIControlStateDisabled];
    [button borderStyle];
    return button;
}

+ (Button *)stateButtonWithTitle:(NSString *)title {
    
    Button *button = [Button buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:BLACK_COLOR] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:WHITE_COLOR] forState:UIControlStateSelected];
    [button setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [button setTitleColor:BLACK_COLOR forState:UIControlStateSelected];
    [button borderStyle];
    return button;
}

@end
