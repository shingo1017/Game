//
//  TalkStory.m
//  destroy
//
//  Created by 尹楠 on 16/9/23.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "TalkStory.h"

@implementation TalkStory

- (void)storyResult {
    
    [super storyResult];
    
    if ([self minutesPass] > 0)
        [[Game sharedGame] dateProperty:@"time" plus:Minutes([self minutesPass])];
    
    [[MainView sharedView] hideMyImageWithAnimation:YES];
    [[MainView sharedView] showPartnerImage:@"真吾_平常" animation:YES];
    [Message hideMessage];
}

@end

@implementation CommonTalkStory

- (void)storyResult {
    
    [super storyResult];
    
    [[Person me] intProperty:@"talk" plus:1];
}

@end

@implementation NoTalkStory

- (id)init {
    
    self = [super init];
    if (self) {
        
        NSInteger talkCount = [[Person me] intProperty:@"talk"];
        if (talkCount == 1)
            [self addCutscenesWithCommandTexts:@[
                                                 @"#mis:若叶_微笑|我们会平安无事的对吗？",
                                             
                                                 @"#pis:真吾_大笑|#p|一定会的！",
                                                 ]];
        else if (talkCount == 2)
            [self addCutscenesWithCommandTexts:@[
                                                 @"#mis:若叶_微笑|有机会要让我欣赏一下平良君的摄影作品啊。",
                                                 
                                                 @"#pis:真吾_大笑|#p|没问题！",
                                                 ]];
    }
    return self;
}

- (NSInteger)minutesPass {
    
    return 0;
}

@end

@implementation Talk0Story

- (id)init {
    
    self = [super init];
    if (self) {
        
        [self addCutscenesWithCommandTexts:@[
                                             @"#mis:若叶_平常|#m|稍等……",
                                             
                                             @"#pis:真吾_紧张|#p|嗯？",
                                             
                                             @"#m|那个……|#w:0.4|我还不知道你的名字？",
                                             
                                             @"#pis:真吾_平常|#p|平良真吾。",
                                             ]];
        if ([[[Person me] property:@"TutorialStoryCanMoveAction"] isEqualToString:@"TutorialStoryCanMoveAction"] &&
            [[[Person me] property:@"CheckOverStoryShareAction"] isEqualToString:@"CheckOverStoryShareAction"]) {
            
            [self addCutscenesWithCommandTexts:@[
                                                 @"#mis:若叶_微笑|#m|平良君……|#w:0.3|有你在真好。",
                                                 
                                                 @"#pis:真吾_紧张|#p|啊？",
                                                 ]];
        }
        [self addCutscenesWithCommandTexts:@[
                                             @"#mis:若叶_微笑|#m|我们会平安无事的对吗？",
                                             
                                             @"#pis:真吾_大笑|#p|一定会的！",
                                             ]];
    }
    return self;
}

- (void)storyEffect {
    
    if ([[Story currentStory].currentCutsceneKey isEqualToString:@"4"]) {
        
        [[Person me] setProperty:@YES forKey:@"isKnownPartnerName"];
    }
}

- (NSInteger)minutesPass {
    
    return 1;
}

@end

@implementation Talk1Story

- (id)init {
    
    self = [super init];
    if (self) {
        
        [self addCutscenesWithCommandTexts:@[
                                             @"#pis:真吾_平常|#p|若叶为什么听到广播没有离开景区？",
                                             
                                             @"#mis:若叶_悲伤|#m|我|#w:0.5|，睡着了。",
                                             
                                             @"#pis:真吾_紧张|#p|啊？",
                                             
                                             @"#m|我和樱本来在一起……|#w:0.4|樱要去拍照|#w:0.3|，而我感觉有点累了|#w:0.4|，所以我们分开了，|#w:0.4|我在这里的长椅上睡着了。",
                                             
                                             @"#pis:真吾_紧张|#p|好奇怪|#w:0.3|，广播撤离时这里的工作人员没有发现你吗？",
                                             
                                             @"#m|我也不知道。|#w:0.5|平良君是为什么留下的呢？",
                                             
                                             @"#pis:真吾_平常|#p|景区平时游客很多|#w:0.4|，会干扰拍摄景色的效果|#w:0.4|，我为了拍到比较完美的照片|#w:0.4|，想到这个机会刚刚好。",
                                             
                                             @"#mis:若叶_微笑|#m|平良君是摄影师？",
                                             
                                             @"#p|不算是吧|#w:0.3|，只是靠投稿摄影作品的小人物而已。",
                                             
                                             @"#mis:若叶_微笑|#m|听起来好厉害。",
                                             
                                             @"#pis:真吾_大笑|#p|见笑了。",
                                             ]];
    }
    return self;
}

- (NSInteger)minutesPass {
    
    return 2;
}

@end

@implementation Talk2Story

- (id)init {
    
    self = [super init];
    if (self) {
        
        [self addCutscenesWithCommandTexts:@[
                                             @"#pis:真吾_平常|#p|Talk2Story",
                                             ]];
    }
    return self;
}

- (NSInteger)minutesPass {
    
    return 1;
}

@end


