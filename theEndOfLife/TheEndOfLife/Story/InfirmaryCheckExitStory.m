//
//  InfirmaryCheckExitStory.m
//  destroy
//
//  Created by 尹楠 on 16/9/22.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "InfirmaryCheckExitStory.h"

@implementation InfirmaryCheckExitStory

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self addCutscenesWithCommandTexts:@[
                                             @"医务室里有一张医疗用的床|#w:0.5|，一些放置了一些药品的储物柜|#w:0.5|，还有一张办公桌。",
                                             
                                             @"#c|这里只有一个出口|#w:0.5|，就是通往职员休息室。",
                                             
                                             @"#mis:若叶_悲伤|#m|没有出口……|#w:0.5|只能往回走了。",
                                             ]];
    }
    return self;
}

- (void)storyResult {
    
    [super storyResult];
    
    [[Game sharedGame] dateProperty:@"time" plus:Minutes(5)];
    [[Scene currentScene] setProperty:@YES forKey:@"CheckExitStory"];
    
    [[MainView sharedView] hideMyImageWithAnimation:YES];
    [Message hideMessage];
}

@end
