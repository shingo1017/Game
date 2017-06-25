//
//  BaseStory.m
//  girl
//
//  Created by 尹楠 on 16/9/6.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "BaseStory.h"
#import "BaseCutscene.h"
#import "NSDate+Additions.h"

static BaseStory *_currentStory;

@implementation BaseStory

+ (void)setCurrentStory:(BaseStory *)story {
    
    _currentStory = story;
}

+ (BaseStory *)currentStory {
    
    return _currentStory;
}

+ (void)beginStoryWithClassName:(NSString *)className {
    
    Class class = NSClassFromString(className);
    if (class) {
        
        id story = [[class alloc] init];
        ((BaseStory *)story).currentCutsceneKey = @"1";
        [StoryClass setCurrentStory:story];
        
        [[StoryClass currentStory] excute];
    }
}

+ (void)checkStoryFireByTime {
    
    NSArray *stories = [Utility getSubClassesWithFatherClassName:@"Story" respondsToSelector:@selector(isAvailable)];
    
    for (Class class in stories) {
        
        if ([class performSelector:@selector(isAvailable)]) {
            
            [StoryClass beginStoryWithClassName:NSStringFromClass(class)];
            break;
        }
    }
}

+ (NSString *)mainStoryName {
    
    NSString *storyName;
    if ([[GameClass sharedGame] boolProperty:@"TutorialStory"])
        storyName = @"TutorialStory";
    if ([[GameClass sharedGame] boolProperty:@"CheckOverStory"])
        storyName = @"CheckOverStory";
    if ([[GameClass sharedGame] boolProperty:@"BorrowMobilePhoneForContactStory"])
        storyName = @"BorrowMobilePhoneForContactStory";
    if ([[GameClass sharedGame] boolProperty:@"CallForHelpStory"])
        storyName = @"CallForHelpStory";
    if ([[GameClass sharedGame] boolProperty:@"FirstNightStory"])
        storyName = @"FirstNightStory";
    
    return storyName;
}

- (id)init {
    
    self = [super init];
    if (self) {
        
        _cutscenes = [[NSMutableDictionary alloc] init];
        _number = 1;
    }
    
    return self;
}

- (BOOL)eof {
    
    if ([[StoryClass currentStory].cutscenes objectForKey:[StoryClass currentStory].currentCutsceneKey])
        return NO;
    else
        return YES;
}

- (void)addCutscenesWithCommandTexts:(NSArray *)commandTexts {
    
    for (NSString *commandText in commandTexts) {
        
        [_cutscenes setObject:[CutsceneClass cutsceneWithCommandText:commandText] forKey:Int2String(_number)];
        _number ++;
    }
}

- (void)addCutsceneWithCommandText:(NSString *)commandText actionClassNames:(NSArray *)actionClassNames {
    
    BaseCutscene *canMoveCutscene = [CutsceneClass cutsceneWithCommandText:commandText actionsNames:actionClassNames];
    [_cutscenes setObject:canMoveCutscene forKey:Int2String(_number)];
    _number += 1;
}

- (void)addSubCutscenesWithCommandTexts:(NSArray *)commandTexts actionClassName:(NSString *)actionClassName {
    
    NSInteger i = 1;
    for (NSString *commandText in commandTexts) {
        
        NSString *cutsceneKey = [NSString stringWithFormat:@"%@-%li", actionClassName, i];
        
        i ++;
        
        BaseCutscene *cutscene = [CutsceneClass cutsceneWithCommandText:commandText];
        if (i > commandTexts.count)
            cutscene.nextCutsceneKey = Int2String(_number);
        [_cutscenes setObject:cutscene forKey:cutsceneKey];
    }
}

- (void)excute {
    
    if (![StoryClass currentStory].eof) {
        
        [Action applyStoryActions];
        
        [[CutsceneClass currentCutscene] excute];
    }
    else {
        
        //剧情结束
        if ([[StoryClass currentStory] respondsToSelector:@selector(storyResult)])
            [[StoryClass currentStory] storyResult];
        
        if ([StoryClass currentStory].sceneClassNameWhenEndOfStory.length > 0) {
            
            //剧情结束需要自动切换场景
            if ([StoryClass currentStory].sceneClassNameWhenEndOfStory.length > 0)
                [[MainViewClass sharedView] transferSceneWithClassName:[BaseStory currentStory].sceneClassNameWhenEndOfStory animation:NO];
        }
        else
            [Action applySceneActions];
        
        [GameClass saveGame];
    }
}

- (void)excuteNextCutscene {
    
    if (![CutsceneClass currentCutscene].nextCutsceneKey) {
        
        NSString *nextCutsceneKey;
        if ([[StoryClass currentStory].currentCutsceneKey containsString:@"-"]) {
            
            //当前片段为分支剧情
            NSArray *numbers = [[StoryClass currentStory].currentCutsceneKey componentsSeparatedByString:@"-"];
            nextCutsceneKey = [NSString stringWithFormat:@"%@-%@", [numbers firstObject], Int2String([[numbers lastObject] integerValue] + 1)];
        }
        else {
            
            //当前片段为主剧情
            nextCutsceneKey = Int2String([[StoryClass currentStory].currentCutsceneKey integerValue] + 1);
        }
        
        [StoryClass currentStory].currentCutsceneKey = nextCutsceneKey;
    }
    else {
        
        [StoryClass currentStory].currentCutsceneKey = [CutsceneClass currentCutscene].nextCutsceneKey;
    }
    
    [[StoryClass currentStory] excute];
}

- (void)skip {
    
    [StoryClass currentStory].isSkip = YES;
    [[StoryClass currentStory] excuteNextCutscene];
}

- (void)storyResult {
    
    [[System system] setProperty:@YES forKey:[NSString stringWithFormat:@"skip%@", NSStringFromClass([self class])]];
    [[GameClass sharedGame] setProperty:@YES forKey:NSStringFromClass([self class])];
}

@end
