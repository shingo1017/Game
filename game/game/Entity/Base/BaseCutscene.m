//
//  BaseCutscene.m
//  girl
//
//  Created by 尹楠 on 16/9/6.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "BaseCutscene.h"

@interface BaseCutscene ()

@end

@implementation BaseCutscene

static BaseCutscene *_sharedCutscene;

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        _excuteIndex = 0;
    }
    
    return self;
}

+ (BaseCutscene *)currentCutscene {
    
    return [[StoryClass currentStory].cutscenes objectForKey:[Story currentStory].currentCutsceneKey];
}

+ (BaseCutscene *)sharedCutscene {
    
    if (!_sharedCutscene)
        _sharedCutscene = [[CutsceneClass alloc] init];
    
    return _sharedCutscene;
}

+ (BaseCutscene *)cutsceneWithCommandText:(NSString *)commandText {
    
    return [CutsceneClass cutsceneWithCommandText:commandText actionsNames:nil];
}

+ (BaseCutscene *)cutsceneWithCommandText:(NSString *)commandText actionsNames:(NSArray *)actionsNames {
    
    BaseCutscene *cutscene = [[CutsceneClass alloc] init];
    cutscene.commandText = commandText;
    
    if (actionsNames.count > 0) {
        
        NSMutableArray *actions = [[NSMutableArray alloc] init];
        for (NSString *actionName in actionsNames) {
            
            id action = [Utility objectForClassName:actionName];
            [actions addObject:action];
        }
        cutscene.actions = actions;
    }
    
    return cutscene;
}

+ (void)excuteCommandText:(NSString *)commandText {
    
    [CutsceneClass sharedCutscene].excuteIndex = 0;
    [CutsceneClass sharedCutscene].commandText = commandText;
    [[CutsceneClass sharedCutscene] excuteCommandText:commandText];
}

- (void)excuteCommandText:(NSString *)commandText {
    
    self.afterDelay = 0;
    
    if ([commandText hasPrefix:@"#w"]) {
        
        //延时
        NSString *value = [[commandText componentsSeparatedByString:@":"] lastObject];
        self.afterDelay = [System system].messageSpeed == 0 ? 0 : [value floatValue];
        [self performSelector:@selector(stepOver) withObject:nil afterDelay:self.afterDelay];
    }
    else if ([commandText hasPrefix:@"#ic"]) {
        
        //更换图片并清除显示文字
        NSString *value = [[commandText componentsSeparatedByString:@":"] lastObject];
        [UIView animateWithDuration:0.8f animations:^{
            
            [MainViewClass sharedView].sceneTransferMaskView.alpha = 1.0f;
        } completion:^(BOOL finished) {
            
            [MainViewClass sharedView].sceneImageView.image = [UIImage imageNamed:value];
            [MainViewClass sharedView].messageContainerView.hidden = YES;
            [Message clearMessages];
            [Action applyStoryActions];
            
            [UIView animateWithDuration:0.8f animations:^{
                
                [MainViewClass sharedView].sceneTransferMaskView.alpha = 0.0f;
            }];
        }];
        
        self.afterDelay = 0.8 * 2;
        [self performSelector:@selector(stepOver) withObject:nil afterDelay:self.afterDelay];
    }
    else if ([commandText hasPrefix:@"#i"]) {
        
        //更换图片
        NSString *value = [[commandText componentsSeparatedByString:@":"] lastObject];
        [UIView animateWithDuration:0.8f animations:^{
            
            [MainViewClass sharedView].sceneTransferMaskView.alpha = 1.0f;
        } completion:^(BOOL finished) {
            
            [MainViewClass sharedView].sceneImageView.image = [UIImage imageNamed:value];
            [Action applyStoryActions];
            
            [UIView animateWithDuration:0.8f animations:^{
                
                [MainViewClass sharedView].sceneTransferMaskView.alpha = 0.0f;
            }];
        }];
        
        self.afterDelay = 0.8 * 2;
        [self performSelector:@selector(stepOver) withObject:nil afterDelay:self.afterDelay];
    }
    else if ([commandText hasPrefix:@"#c"]) {
        
        //清除显示文字
        [MainViewClass sharedView].messageContainerView.hidden = YES;
        [MainViewClass sharedView].messageLabel.text = @"";
        
        [self performSelector:@selector(stepOver) withObject:nil];
    }
    else if ([commandText hasPrefix:@"#event"]) {
        
        //执行StoryEvent
        NSString *value = [[commandText componentsSeparatedByString:@":"] lastObject];
        
        if ([[StoryClass currentStory] respondsToSelector:@selector(storyEvent:)])
            [[StoryClass currentStory] storyEvent:value];
        
        [self performSelector:@selector(stepOver) withObject:nil];
    }
    else if ([self excuteExtensionCommandText:commandText]) {
    
    }
    else {
        
        [Message appendText:commandText];
    }
}

- (BOOL)excuteExtensionCommandText:(NSString *)commandText {
    
    return NO;
}

- (void)excute {
    
    NSArray *steps = [self.commandText componentsSeparatedByString:@"|"];
    NSString *step = [steps objectAtIndex:_excuteIndex];
    [self excuteCommandText:step];
}

- (void)stepOver {
    
    NSArray *steps = [self.commandText componentsSeparatedByString:@"|"];
    
    _excuteIndex += 1;
    if (_excuteIndex < steps.count) {
        
        //还有未执行的步骤
        [self performSelector:@selector(excute) withObject:nil];
    }
    else {
        
        //所有步骤都执行完了
        
        if (self == [CutsceneClass sharedCutscene]) {
            
            //通用片段
        }
        else {
            
            //剧情片段
            if (self.actions.count > 0) {
                
                [Action clearActions];
                [Action appendActions:self.actions];
            }
            else {
                
                [Action clearActions];
                
                if ([StoryClass currentStory].isSkip) {
                    
                    //直接跳过
                    [[StoryClass currentStory] excuteNextCutscene];
                }
                else {
                    
                    [self allStepOver];
                }
            }
        }
    }
}

- (void)allStepOver {
    
    
}

@end
