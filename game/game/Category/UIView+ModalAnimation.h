//
//  UIView+ModalAnimation.h
//  It'sMyCoupon
//
//  Created by Shingo Yabuki on 12-3-3.
//  Copyright (c) 2012年 c2y. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ModalAnimationHelper)

+ (void) commitModalAnimations;

@end

@interface UIViewDelegate : NSObject

{
    
    CFRunLoopRef currentLoop;
    
}

@end