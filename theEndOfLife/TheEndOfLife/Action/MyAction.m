//
//  MyAction.m
//  destroy
//
//  Created by 尹楠 on 16/9/24.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "MyAction.h"
#import "NSDate+Additions.h"

@implementation MyAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"自 己" forKey:k_name save:NO];
    }
    return self;
}

- (NSString *)parentActionName {
    
    return nil;
}

- (BOOL)isAvailable {
    
    return [[Game sharedGame] boolProperty:@"TutorialPackBagStory"];
}

@end

@implementation MyInfoAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"检 视" forKey:k_name save:NO];
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
    
    [[PersonView sharedView] showWithPersion:[Person me]];
}

@end

@implementation MyBagAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"背 包" forKey:k_name save:NO];
        
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadBagItemActions) name:K_SHOULD_RELOAD_BAGITEMACTIONS_NOTIFICATION object:nil];
    }
    return self;
}

- (NSString *)parentActionName {
    
    return nil;
}

- (BOOL)isAvailable {
    
    return [[Game sharedGame] boolProperty:@"TutorialPackBagStory"];
}

- (void)actionResult {
    
    [[BagView sharedView] show];
}

@end

@implementation MyRestAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"休 息" forKey:k_name save:NO];
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
    
    [UIView animateWithDuration:1.0f animations:^{
        
        [MainView sharedView].sceneTransferMaskView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
        NSInteger minutes = [Utility getRandomNumber:40 to:80];
        [[Game sharedGame] dateProperty:@"time" plus:Minutes(minutes)];
        [[Person me] intProperty:@"energy" plus:-1 * minutes * 0.8];
        [[Person me] intProperty:@"thirsty" plus:-1 * minutes * 0.9];
        [[Person me] intProperty:@"sober" plus:minutes * 1];
        [Game saveGame];
        
        [UIView animateWithDuration:1.0f animations:^{
            
            [MainView sharedView].sceneTransferMaskView.alpha = 0.0f;
        }];
    }];
}

@end

@implementation MySleepAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"睡 觉" forKey:k_name save:NO];
        
        self.belongToClassNames = @[@"LoungeScene", @"ToolhouseScene", @"InfirmaryScene"];
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
    
    NSDate *time = [[Game sharedGame] property:@"time"];
    NSDate *lastSleepTime = [[Game sharedGame] property:@"lastSleepTime"];
    if ([lastSleepTime hoursToDate:time] < 5) {
        
        [Cutscene excuteCommandText:@"#c|距离上次睡眠时间过短，不需要睡觉。"];
    }
    else {
        
        [UIView animateWithDuration:2.0f animations:^{
            
            [MainView sharedView].sceneTransferMaskView.alpha = 1.0f;
        } completion:^(BOOL finished) {
            
            NSInteger minutes = [Utility getRandomNumber:240 to:420];
            [[Game sharedGame] dateProperty:@"time" plus:Minutes(minutes)];
            [[Person me] intProperty:@"energy" plus:-1 * minutes * 0.65];
            [[Person me] intProperty:@"thirsty" plus:-1 * minutes * 0.8];
            [[Person me] intProperty:@"sober" plus:minutes * 2];
            [[Game sharedGame] setProperty:[[Game sharedGame] property:@"time"] forKey:@"lastSleepTime"];
            [Game saveGame];
            
            [UIView animateWithDuration:2.0f animations:^{
                
                [MainView sharedView].sceneTransferMaskView.alpha = 0.0f;
            }];
        }];
    }
}

@end
