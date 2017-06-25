//
//  Button+Additions.h
//  Entlphone
//
//  Created by wangyanan on 14-8-14.
//  Copyright (c) 2014年 Shingo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Button.h"

@interface Button (Additions)

+ (Button *)buttonWithTitle:(NSString *)title;
+ (Button *)stateButtonWithTitle:(NSString *)title;

@end
