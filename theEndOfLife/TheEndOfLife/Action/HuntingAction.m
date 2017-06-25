//
//  HuntingAction.m
//  destroy
//
//  Created by 尹楠 on 16/9/24.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "HuntingAction.h"

@implementation HuntingStartAction

NSString *_timerKey = @"huntingTimer";

- (NSString *)name {
    
    return @"寻找补给";
}

- (BOOL)isAvailable {
    
    NSString *outsideSceneClassName = [[Scene currentScene] property:@"outsideSceneClassName"];
    Scene *scene = [Scene sceneWithClassName:outsideSceneClassName];
    if ([scene intProperty:@"progress"] < 100)
        return YES;
    else
        return NO;
}

- (void)actionResult {
    
    [Action clearActions];
    id huntingStopAction = [Utility objectForClassName:@"HuntingStopAction"];
    [Action appendAction:huntingStopAction];
    
    [Cutscene excuteCommandText:@"#c|寻找补给品……"];
    NSTimer *huntingTimer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(huntingTimerTicked) userInfo:@"shouldStopHuntingTimer" repeats:YES];
    [[TimerManager sharedManager] setProperty:huntingTimer forKey:_timerKey];
}

- (void)huntingTimerTicked {
    
    NSString *outsideSceneClassName = [[Scene currentScene] property:@"outsideSceneClassName"];
    Scene *scene = [Scene sceneWithClassName:outsideSceneClassName];
    if ([scene intProperty:@"progress"] >= 100) {
        
        
        [Action applySceneActions];
        [MainView sharedView].messageContainerView.hidden = YES;
        [[TimerManager sharedManager] stopTimerWithKey:_timerKey];
    }
    else {
        
        [ItemDrop checkItemDrops:[[Scene currentScene] property:@"itemDrops"]];
        NSInteger time = [Utility getRandomNumber:25 to:35];
        [[Game sharedGame] dateProperty:@"time" plus:Minutes(time)];
        [[Person me] intProperty:@"energy" plus:time * -1.3f];
        [[Person me] intProperty:@"thirsty" plus:time * -1.3f];
        [[Person me] intProperty:@"sober" plus:time * -1.1f];
        [scene intProperty:@"progress" plus:1];
        [Game saveGame];
    }
}

@end

@implementation HuntingStopAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldStopHuntingTimer) name:_timerKey object:nil];
    }
    return self;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_timerKey object:nil];
}

- (NSString *)name {
    
    return @"停止寻找";
}

- (BOOL)isAvailable {
    
    NSString *outsideSceneClassName = [[Scene currentScene] property:@"outsideSceneClassName"];
    Scene *scene = [Scene sceneWithClassName:outsideSceneClassName];
    if ([scene intProperty:@"progress"] < 100)
        return YES;
    else
        return NO;
}

- (void)actionResult {
    
    [Action applySceneActions];
    [MainView sharedView].messageContainerView.hidden = YES;
    [[TimerManager sharedManager] stopTimerWithKey:_timerKey];
}

- (void)shouldStopHuntingTimer {
    
    [Action applySceneActions];
    [MainView sharedView].messageContainerView.hidden = YES;
}

@end

@implementation HuntingLeaveAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"离 开" forKey:k_name save:NO];
    }
    return self;
}

- (BOOL)isAvailable {
    
    return YES;
}

- (void)actionResult {
    
    [[MainView sharedView] transferSceneWithClassName:[[Scene currentScene] property:@"outsideSceneClassName"]];
}

@end
