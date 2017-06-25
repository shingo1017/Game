//
//  ToolhouseCheckExitStory.m
//  destroy
//
//  Created by 尹楠 on 16/9/22.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "ToolhouseCheckExitStory.h"

@implementation ToolhouseCheckExitStory

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self addCutscenesWithCommandTexts:@[
                                             @"工具房里有一台大型设备|#w:0.3|，不知道做什么用的|#w:0.5|，还有一些零落的工具和一排储物柜。",
                                             
                                             @"#c|这里只有一个出口|#w:0.5|，就是通往职员休息室。",
                                             
                                             @"#mis:若叶_悲伤|#m|没有出口……|#w:0.5|只能往回走了。",
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
    
    [[MainView sharedView] hideMyImageWithAnimation:YES];
    [Message hideMessage];
}

@end
