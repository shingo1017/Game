//
//  Button.m
//  zombie
//
//  Created by 尹楠 on 17/5/26.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "Button.h"

@implementation Button

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    CGRect bounds =self.bounds;
    bounds = CGRectInset(bounds, -10, -10);//注意这里是负数，扩大了之前的bounds的范围
    
    return CGRectContainsPoint(bounds, point);
}

@end
