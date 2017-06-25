//
//  Scene.h
//  theEndOfLife
//
//  Created by 尹楠 on 17/5/14.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "BaseScene.h"

@interface Scene : BaseScene

+ (Scene *)currentScene;
+ (void)transferSceneWithClassName:(NSString *)className;

@end
