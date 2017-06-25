//
//  TutorialStoryAction.m
//  destroy
//
//  Created by 尹楠 on 16/9/20.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "TutorialStoryAction.h"

@implementation TutorialStoryCanMoveAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        self.name = @"我没问题。";
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
    
    [[Person me] setProperty:@"TutorialStoryCanMoveAction" forKey:@"TutorialStoryCanMoveAction"];
    
    [Action clearActions];
    
    [Story currentStory].currentCutsceneKey = @"TutorialStoryCanMoveAction-1";
    [[Story currentStory] excute];
}

@end

@implementation TutorialStoryCanNotMoveAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        self.name = @"我头疼死了，动不了。";
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
    
    [[Person me] setProperty:@"TutorialStoryCanNotMoveAction" forKey:@"TutorialStoryCanMoveAction"];
    
    [Action clearActions];
    
    [Story currentStory].currentCutsceneKey = @"TutorialStoryCanNotMoveAction-1";
    [[Story currentStory] excute];
}

@end
