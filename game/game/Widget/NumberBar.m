//
//  NumberBar.m
//  worldOfZombie
//
//  Created by 尹楠 on 15/7/21.
//  Copyright (c) 2015年 c2y. All rights reserved.
//

#import "NumberBar.h"
#import "UIColor+Additions.h"

@implementation NumberBar

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initialization];
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self initialization];
}

- (void)setFrame:(CGRect)frame {

    [super setFrame:frame];
    
    maxNumberBar.width = self.width - 2;
    numberBar.width = maxNumberBar.width;
}

- (void)initialization {
    
    self.backgroundColor = BLACK_COLOR;
    [self borderStyleWithColor:DARK_GRAY_COLOR];
    
    maxNumberBar = [[UIView alloc] initWithFrame:CGRectMake(1, 1, self.width - 2, self.height - 2)];
    maxNumberBar.backgroundColor = BLACK_COLOR;
    [self addSubview:maxNumberBar];
    
    numberBar = [[UIView alloc] initWithFrame:maxNumberBar.frame];
    [self addSubview:numberBar];
}

- (void)setNumber:(CGFloat)number {
    
    [self setNumber:number animation:NO];
}

- (void)setNumber:(CGFloat)number animation:(BOOL)animation {
    
    if (number < 0)
        _number = 0;
    else if (_number > _maxNumber)
        _number = _maxNumber;
    else {
        
        if (_number < number) {
            
            //增加
            if (animation) {
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1.0f];
                [UIView setAnimationCurve:UIViewAnimationCurveLinear];
                numberBar.width = maxNumberBar.width * ((float)number / (float)_maxNumber);
                [UIView commitAnimations];
            }
            else
                numberBar.width = maxNumberBar.width * ((float)number / (float)_maxNumber);
        }
        else {
            
            //减少
            if (animation) {
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1.0f];
                [UIView setAnimationCurve:UIViewAnimationCurveLinear];
                numberBar.width = maxNumberBar.width * ((float)number / (float)_maxNumber);
                [UIView commitAnimations];
            }
        }
        
        _number = number;
    }
    
    numberBar.backgroundColor = DARK_GRAY_COLOR;
}

@end
