//
//  ChurchAction.m
//  destroy
//
//  Created by 尹楠 on 16/9/22.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "ChurchAction.h"

@implementation ChurchPrayAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"祈 祷" forKey:k_name save:NO];
    }
    return self;
}

- (BOOL)isAvailable {
    
    if (![[Game sharedGame] boolProperty:@"isPraySafe"] &&
        ![[Game sharedGame] boolProperty:@"isPrayLuck"] &&
        [[Game sharedGame] boolProperty:@"TutorialGoStory"])
        return YES;
    else
        return NO;
}

- (void)actionResult {
    
    
}

@end

@implementation ChurchPraySafeAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"祈祷平安" forKey:k_name save:NO];
    }
    return self;
}

- (BOOL)isAvailable {
    
    return YES;
}

- (void)actionResult {
    
    [Cutscene excuteCommandText:@"#c|虔诚的祈祷过后，圣母玛利亚仿佛在慈祥的望着你。"];
    [[Game sharedGame] setProperty:@YES forKey:@"isPraySafe"];
    [Game saveGame];
}

@end

@implementation ChurchPrayLuckAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"祈祷好运" forKey:k_name save:NO];
    }
    return self;
}

- (BOOL)isAvailable {
    
    return YES;
}

- (void)actionResult {
    
    [Cutscene excuteCommandText:@"#c|虔诚的祈祷过后，圣母玛利亚仿佛在向你微笑。"];
    [[Game sharedGame] setProperty:@YES forKey:@"isPrayLuck"];
    [Game saveGame];
}

@end

#import "ChurchAction.h"

@implementation ChurchCamouflageAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"伪装入口" forKey:k_name save:NO];
    }
    return self;
}

- (BOOL)isAvailable {
    
    if (![[Game sharedGame] boolProperty:@"isCamouflage"])
        return YES;
    else
        return NO;
}

- (void)actionResult {
    
    [Story beginStoryWithClassName:@"ChurchCamouflageStory"];
}

@end

@implementation ChurchWayToSceneAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        //self.name = @"出 发";
    }
    return self;
}

- (NSString *)name {
    
    Scene *scene = [self property:@"scene"];
    return [scene property:@"name"];
}

- (BOOL)isAvailable {
    
    if ([[Game sharedGame] boolProperty:@"TutorialGoStory"])
        return YES;
    else
        return NO;
}

- (void)actionResult {
    
    Scene *scene = [self property:@"scene"];
    [[Game sharedGame] setProperty:scene forKey:@"destinationScene" save:NO];
    [Story beginStoryWithClassName:@"PassWayStory"];
}

@end
