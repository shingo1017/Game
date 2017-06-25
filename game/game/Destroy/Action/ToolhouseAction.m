//
//  ToolhouseAction.m
//  destroy
//
//  Created by 尹楠 on 16/9/22.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "ToolhouseAction.h"

@implementation ToolhouseCheckExitAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        self.name = @"检查出口";
    }
    return self;
}

- (NSString *)parentActionName {
    
    return nil;
}

- (BOOL)isAvailable {
    
    if ([[Scene currentScene] boolProperty:@"CheckExitStory"] ||
        [[Game sharedGame] boolProperty:@"CheckOverStory"])
        return NO;
    else
        return YES;
}

- (void)actionResult {
    
    [Story beginStoryWithClassName:@"ToolhouseCheckExitStory"];
}

@end
