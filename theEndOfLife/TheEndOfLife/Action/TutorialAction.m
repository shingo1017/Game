//
//  TutorialAction.m
//  destroy
//
//  Created by 尹楠 on 16/9/22.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "TutorialAction.h"
#import "Story.h"

@implementation TutorialPackBagAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"检查背包" forKey:k_name save:NO];
    }
    return self;
}

- (BOOL)isAvailable {
    
    if (![[Game sharedGame] boolProperty:@"TutorialPackBagStory"])
        return YES;
    else
        return NO;
}

- (void)actionResult {
    
    [Story beginStoryWithClassName:@"TutorialPackBagStory"];
}

@end

@implementation TutorialPrayAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"祈 祷" forKey:k_name save:NO];
    }
    return self;
}

- (BOOL)isAvailable {
    
    if (![[Game sharedGame] boolProperty:@"TutorialPrayStory"])
        return YES;
    else
        return NO;
}

- (void)actionResult {
    
    [Story beginStoryWithClassName:@"TutorialPrayStory"];
}

@end

@implementation TutorialGoAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"出 发" forKey:k_name save:NO];
    }
    return self;
}

- (BOOL)isAvailable {
    
    if (![[Game sharedGame] boolProperty:@"TutorialGoStory"] &&
        [[Game sharedGame] boolProperty:@"isCamouflage"])
        return YES;
    else
        return NO;
}

- (void)actionResult {
    
    [Story beginStoryWithClassName:@"TutorialGoStory"];
}

@end
