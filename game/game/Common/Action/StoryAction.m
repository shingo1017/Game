//
//  StoryAction.m
//  girl
//
//  Created by 尹楠 on 16/9/2.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "StoryAction.h"
#import "Story.h"
#import "Cutscene.h"

@implementation StoryContinueAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"继 续" forKey:k_name save:NO];
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
    
    [Action clearActions];
    
    [[Story currentStory] excuteNextCutscene];
}

@end

@implementation StorySkipAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"跳 过" forKey:k_name save:NO];
    }
    return self;
}

- (NSString *)parentActionName {
    
    return nil;
}

- (BOOL)isAvailable {
 
    return [[System system] boolProperty:[NSString stringWithFormat:@"skip%@", NSStringFromClass([[Story currentStory] class])]];
}

- (void)actionResult {
    
    [Action clearActions];
    
    [[Story currentStory] skip];
}

@end
