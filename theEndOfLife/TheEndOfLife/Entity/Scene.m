//
//  Scene.m
//  theEndOfLife
//
//  Created by 尹楠 on 17/5/14.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "Scene.h"

@implementation Scene

+ (Scene *)currentScene {
    
    NSString *sceneClassName = [[Person me] property:@"scene"];
    Scene *scene = (Scene *)[Scene sceneWithClassName:sceneClassName];
    return scene;
}

+ (void)transferSceneWithClassName:(NSString *)className {
    
    [super transferSceneWithClassName:className];
    
    [[Person me] setProperty:className forKey:@"scene"];
}

@end
