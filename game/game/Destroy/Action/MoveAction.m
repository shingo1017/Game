//
//  MoveAction.m
//  destroy
//
//  Created by 尹楠 on 16/9/21.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "MoveAction.h"

@implementation LoungeAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        self.name = @"去职员休息室";
    }
    return self;
}

- (NSString *)parentActionName {
    
    return nil;
}

- (BOOL)isAvailable {
    
    return YES;
}

- (void)actionResult {
    
    [Scene transferSceneWithClassName:@"LoungeScene" completion:^{
        
        [[Game sharedGame] dateProperty:@"time" plus:Minutes(2)];
        [[Person me] intProperty:@"energy" plus:-2];
        [[Person me] intProperty:@"thirsty" plus:-2];
        
        if (![[Game sharedGame] boolProperty:@"CheckOverStory"] &&
            [[Scene sceneWithClassName:@"LoungeScene"] boolProperty:@"CheckExitStory"] &&
            ([[Scene sceneWithClassName:@"ToolhouseScene"] boolProperty:@"CheckExitStory"] ||
             [[Scene sceneWithClassName:@"InfirmaryScene"] boolProperty:@"CheckExitStory"])) {
                
                //检查过两个房间，出发剧情
                [Story beginStoryWithClassName:@"CheckOverStory"];
            }
    }];
}

@end

@implementation ToolhouseAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        self.name = @"去工具房";
    }
    return self;
}

- (NSString *)parentActionName {
    
    return nil;
}

- (BOOL)isAvailable {
    
    //if ([[Scene currentScene] boolProperty:@"canMoveToToolhouse"])
        return YES;
    //else
        //return NO;
}

- (void)actionResult {
    
    [Scene transferSceneWithClassName:@"ToolhouseScene" completion:^{
        
        [[Game sharedGame] dateProperty:@"time" plus:Minutes(2)];
        [[Person me] intProperty:@"energy" plus:-2];
        [[Person me] intProperty:@"thirsty" plus:-2];
    }];
}

@end

@implementation InfirmaryAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        self.name = @"去医务室";
    }
    return self;
}

- (NSString *)parentActionName {
    
    return nil;
}

- (BOOL)isAvailable {
    
    //if ([[Scene currentScene] boolProperty:@"canMoveToInfirmary"])
        return YES;
    //else
        //return NO;
}

- (void)actionResult {
    
    [Scene transferSceneWithClassName:@"InfirmaryScene" completion:^{
        
        [[Game sharedGame] dateProperty:@"time" plus:Minutes(2)];
        [[Person me] intProperty:@"energy" plus:-2];
        [[Person me] intProperty:@"thirsty" plus:-2];
    }];
}

@end

