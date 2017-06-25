//
//  MoveAction.m
//  destroy
//
//  Created by 尹楠 on 16/9/21.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "MoveAction.h"

@implementation GoChurchRoomAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"去里间" forKey:k_name save:NO];
    }
    return self;
}

- (NSString *)parentActionName {
    
    return nil;
}

- (BOOL)isAvailable {
    
    if ([[Game sharedGame] boolProperty:@"TutorialGoStory"])
        return YES;
    else
        return NO;
}

- (void)actionResult {
    
    [[MainView sharedView] transferSceneWithClassName:@"ChurchRoomScene" completion:^{
        
        [[Game sharedGame] dateProperty:@"time" plus:Minutes(2)];
        [[Person me] intProperty:@"energy" plus:-2];
        [[Person me] intProperty:@"thirsty" plus:-2];
        [[Person me] intProperty:@"sober" plus:-2];
    }];
}

@end

@implementation GoChurchWorshipAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"去礼拜间" forKey:k_name save:NO];
    }
    return self;
}

- (NSString *)parentActionName {
    
    return nil;
}

- (BOOL)isAvailable {
    
    if ([[Game sharedGame] boolProperty:@"TutorialGoStory"])
        return YES;
    else
        return NO;
}

- (void)actionResult {
    
    [[MainView sharedView] transferSceneWithClassName:@"ChurchWorshipScene" completion:^{
        
        [[Game sharedGame] dateProperty:@"time" plus:Minutes(2)];
        [[Person me] intProperty:@"energy" plus:-2];
        [[Person me] intProperty:@"thirsty" plus:-2];
        [[Person me] intProperty:@"sober" plus:-2];
        
        //伪装入口失效
        [[Game sharedGame] setProperty:@NO forKey:@"isCamouflage"];
    }];
}

@end

@implementation GoChurchAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"去教堂外" forKey:k_name save:NO];
    }
    return self;
}

- (NSString *)parentActionName {
    
    return nil;
}

- (BOOL)isAvailable {
    
    if ([[Game sharedGame] boolProperty:@"TutorialGoStory"])
        return YES;
    else
        return NO;
}

- (void)actionResult {
    
    [[MainView sharedView] transferSceneWithClassName:@"ChurchScene" completion:^{
        
        [[Game sharedGame] dateProperty:@"time" plus:Minutes(2)];
        [[Person me] intProperty:@"energy" plus:-2];
        [[Person me] intProperty:@"thirsty" plus:-2];
        [[Person me] intProperty:@"sober" plus:-2];
    }];
}

@end

@implementation BackToChurchAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"回 家" forKey:k_name save:NO];
    }
    return self;
}

- (BOOL)isAvailable {
    
    return YES;
}

- (void)actionResult {
    
    if ([[Scene currentScene] intProperty:@"progress"] >= 100) {
        
        //地点搜索完毕
        [[Scene currentScene] remove];
        NSMutableArray *visitedScenes = [[NSMutableArray alloc] initWithArray:[[Game sharedGame] property:@"visitedScenes"]];
        [visitedScenes addObject:NSStringFromClass([[Scene currentScene] class])];
        [[Game sharedGame] setProperty:visitedScenes forKey:@"visitedScenes"];
    }
        
    [[MainView sharedView] transferSceneWithClassName:@"ChurchScene" completion:^{
        
        [[Game sharedGame] dateProperty:@"time" plus:Minutes(5)];
        [[Person me] intProperty:@"energy" plus:-5];
        [[Person me] intProperty:@"thirsty" plus:-5];
        [[Person me] intProperty:@"sober" plus:-5];
        
    }];
}

@end

