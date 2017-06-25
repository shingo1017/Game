//
//  TimeResultScene.h
//  zombie
//
//  Created by 尹楠 on 17/5/31.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "LayerScene.h"

@interface TimeResultScene : LayerScene

+ (TimeResultScene *)sharedScene;
+ (void)setSharedScene:(TimeResultScene *)sharedScene;

- (void)show;

@end
