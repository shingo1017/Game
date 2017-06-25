//
//  CheckOverStoryAction.m
//  destroy
//
//  Created by 尹楠 on 16/9/20.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "CheckOverStoryAction.h"

@implementation CheckOverStoryShareAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        self.name = @"我吃得少，我可以分给你一些。";
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
    
    [[Person me] setProperty:@"CheckOverStoryShareAction" forKey:@"CheckOverStoryShareAction"];
    
    [Action clearActions];
    
    [Story currentStory].currentCutsceneKey = @"CheckOverStoryShareAction-1";
    [[Story currentStory] excute];
}

@end

@implementation CheckOverStoryNotShareAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        self.name = @"哦……";
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
    
    [[Game sharedGame] dateProperty:@"time" plus:Minutes(12)];
    [[Person me] setProperty:@"CheckOverStoryNotShareAction" forKey:@"CheckOverStoryShareAction"];
    
    [Action clearActions];
    
    [Story currentStory].currentCutsceneKey = @"CheckOverStoryNotShareAction-1";
    [[Story currentStory] excute];
}

@end
