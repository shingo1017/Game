//
//  LoungeCheckExitStory.m
//  destroy
//
//  Created by 尹楠 on 16/9/22.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "LoungeCheckExitStory.h"

@implementation LoungeCheckExitStory

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self addCutscenesWithCommandTexts:@[
                                             @"屋顶的天花板已经完全坍塌下来了|#w:0.5|，屋子里全是倒塌的墙壁和天花板|#w:0.5|，还能看到门口的牌子上写着职员休息室。",
                                             
                                             @"#c|这个屋子有三个明显的出口|#w:0.5|，一个通往走廊|#w:0.5|，一个通往医务室|#w:0.5|，另一个通往工具房。",
                                             
                                             @"#c|但是这三个出口都已经被坍塌的墙体石块挡住了|#w:0.3|，人的身材是过不去的。",
                                             ]];
    }
    return self;
}

- (void)storyEffect {
    
    
}

- (void)storyResult {
    
    [super storyResult];
    
    [[Game sharedGame] dateProperty:@"time" plus:Minutes(5)];
    [[Scene currentScene] setProperty:@YES forKey:@"CheckExitStory"];
    [Message hideMessage];
}

@end
