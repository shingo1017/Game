//
//  BaseStory.h
//  girl
//
//  Created by 尹楠 on 16/9/6.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "Entity.h"

#define StoryClass [Utility subClassForFatherClass:BaseStory.class]

@interface BaseStory : NSObject

@property (nonatomic, assign) NSInteger number; //仅初始化使用
@property (nonatomic, strong) NSMutableDictionary *cutscenes;
@property (nonatomic, copy) NSString *currentCutsceneKey;
@property (nonatomic, assign) BOOL eof;
@property (nonatomic, copy) NSString *sceneClassNameWhenEndOfStory;
@property (nonatomic, assign) BOOL isSkip;

+ (void)setCurrentStory:(BaseStory *)story;
+ (BaseStory *)currentStory;

+ (void)beginStoryWithClassName:(NSString *)className;
+ (void)checkStoryFireByTime;
+ (BOOL)isAvailable;
+ (NSString *)mainStoryName;

//批量添加一般剧情
- (void)addCutscenesWithCommandTexts:(NSArray *)commandTexts;

//单独添加带有选项的剧情
- (void)addCutsceneWithCommandText:(NSString *)commandText actionClassNames:(NSArray *)actionClassNames;

//批量添加支线剧情
- (void)addSubCutscenesWithCommandTexts:(NSArray *)commandTexts actionClassName:(NSString *)actionClassName;
- (void)excute;
- (void)excuteNextCutscene;
- (void)skip;
- (void)storyEvent:(NSString *)value;
- (void)storyResult;

@end
