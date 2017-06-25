//
//  BuildingAction.m
//  destroy
//
//  Created by 尹楠 on 16/9/22.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "BuildingAction.h"

@implementation BuildingEntryAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"进 入" forKey:k_name save:NO];
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
    
    [[MainView sharedView] transferSceneWithClassName:[[Scene currentScene] property:@"insideSceneClassName"]];
}

@end

@implementation BuildingLeaveAction

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
    
    [[Game sharedGame] setProperty:[Scene sceneWithClassName:@"ChurchScene"] forKey:@"destinationScene" save:NO];
    [Story beginStoryWithClassName:@"HomePassWayStory"];
}

@end
