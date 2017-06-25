//
//  GameSettingAction.m
//  zombie
//
//  Created by 尹楠 on 17/5/20.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "GameSettingAction.h"

@implementation GameSettingAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"设  置" forKey:k_name save:NO];
        self.belongToClassNames = @[@"PlaceScene", @"BuildingScene", @"FiefScene"];
        self.sort = 999;
    }
    return self;
}

- (BOOL)isAvailable {
    
    return YES;
}

@end

@implementation GameSaveAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"保存游戏" forKey:k_name save:NO];
        self.belongToClassNames = @[@"GameSettingAction"];
        self.sort = 10;
    }
    return self;
}

- (BOOL)isAvailable {
    
    return YES;
}

- (void)actionResult {
    
    [Game saveGame];
}

@end

@implementation GameLoadAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"读取游戏" forKey:k_name save:NO];
        self.belongToClassNames = @[@"GameSettingAction"];
        self.sort = 20;
    }
    return self;
}

- (BOOL)isAvailable {
    
    return YES;
}

- (void)actionResult {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_SCENE_NOTIFICATION object:nil];
}

@end

@implementation GameTitleScreenAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"回到标题画面" forKey:k_name save:NO];
        self.belongToClassNames = @[@"GameSettingAction"];
        self.sort = 30;
    }
    return self;
}

- (BOOL)isAvailable {
    
    return YES;
}

- (void)actionResult {
    
    
}

@end
