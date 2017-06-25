//
//  Scene.m
//  zombie
//
//  Created by 尹楠 on 17/5/13.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "Scene.h"

@implementation Scene

+ (Scene *)sharedScene {
    
    return (Scene *)[super sharedScene];
}

- (void)show {
    
    [self showWithAnimation:NO];
}

- (void)showWithAnimation:(BOOL)animation {
    
    [[MainView sharedView] showScene:self];
}

- (void)hide {
    
    [[MainView sharedView] hideScene:self];
}

@end
