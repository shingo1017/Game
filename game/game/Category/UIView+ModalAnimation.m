//
//  UIView+ModalAnimation.m
//  It'sMyCoupon
//
//  Created by Shingo Yabuki on 12-3-3.
//  Copyright (c) 2012年 c2y. All rights reserved.
//

#import "UIView+ModalAnimation.h"

@implementation UIViewDelegate

-(id) initWithRunLoop: (CFRunLoopRef)runLoop 

{
    
    if (self = [super init]) currentLoop = runLoop;
    
    return self;
    
}

-(void) animationFinished: (id) sender

{
    
    CFRunLoopStop(currentLoop);
    
}


@end


@implementation UIView (ModalAnimationHelper)

+ (void) commitModalAnimations

{
    
    CFRunLoopRef currentLoop = CFRunLoopGetCurrent();
    
    
    
    UIViewDelegate *uivdelegate = [[UIViewDelegate alloc] initWithRunLoop:currentLoop];
    
    [UIView setAnimationDelegate:uivdelegate];
    
    [UIView setAnimationDidStopSelector:@selector(animationFinished:)];
    
    [UIView commitAnimations];
    
    CFRunLoopRun();
    
    //[uivdelegate release];
    
}

@end



