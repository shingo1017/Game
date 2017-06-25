//
//  Scene.h
//  zombie
//
//  Created by 尹楠 on 17/5/13.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "BaseScene.h"

@interface Scene : BaseScene

+ (Scene *)sharedScene;

- (void)show;
- (void)showWithAnimation:(BOOL)animation;
- (void)hide;

@end
