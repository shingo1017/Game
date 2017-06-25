//
//  FaintBecauseNoSoberStory.m
//  destroy
//
//  Created by 尹楠 on 16/9/25.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "FaintBecauseNoSoberStory.h"

@implementation FaintBecauseNoSoberStory

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self addCutscenesWithCommandTexts:@[
                                             @"#ic:黑色|#m|不……|#w:0.4|不行了……|#w:0.6|嗯……",
                                             
                                             [NSString stringWithFormat:@"#c|困乏已经到达了极限|#w:0.4|，%@栽倒在地上……|#w:0.4|失去了意识。", [[Person me] property:@"name"]],
                                             
                                             @"#c|健康指数下降了2点。",
                                             ]];
        
        NSInteger survivorEncounterRating = [[Scene currentScene] intProperty:@"survivorEncounterRating"];
        if ([Utility getRandomNumber:1 to:100] <= survivorEncounterRating) {
            
            //遭遇了幸存者
            [[Bag sharedBag] removeBag];
            [self addCutscenesWithCommandTexts:@[
                                                 [NSString stringWithFormat:@"#c|在昏迷期间，有人拿走了%@的背包。", [[Person me] property:@"name"]],
                                                 ]];
            [Game saveGame];
        }
    }
    return self;
}

- (void)storyResult {
    
    [super storyResult];
    
    [[MainView sharedView] transferSceneWithClassName:NSStringFromClass([[Scene currentScene] class]) completion:^{
        
        NSInteger minutes = [Utility getRandomNumber:240 to:420];
        [[Game sharedGame] dateProperty:@"time" plus:Minutes(minutes)];
        [[Person me] intProperty:@"energy" plus:-minutes * 0.65];
        [[Person me] intProperty:@"thirsty" plus:-minutes * 0.8];
        [[Person me] intProperty:@"sober" plus:minutes * 2];
        [[Person me] intProperty:@"health" plus:-2];
        [[Game sharedGame] setProperty:[[Game sharedGame] property:@"time"] forKey:@"lastSleepTime"];
    }];
}

@end
