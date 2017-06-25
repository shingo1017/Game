//
//  BaseCutscene.h
//  girl
//
//  Created by 尹楠 on 16/9/6.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CutsceneClass [Utility subClassForFatherClass:BaseCutscene.class]

@interface BaseCutscene : NSObject

@property (nonatomic, copy) NSString *commandText;
@property (nonatomic, strong) NSArray *actions;
@property (nonatomic, copy) NSString *nextCutsceneKey;
@property (nonatomic, assign) NSInteger excuteIndex;
@property (nonatomic, assign) CGFloat afterDelay;

+ (BaseCutscene *)currentCutscene;
+ (BaseCutscene *)sharedCutscene;
+ (BaseCutscene *)cutsceneWithCommandText:(NSString *)commandText;
+ (BaseCutscene *)cutsceneWithCommandText:(NSString *)commandText actionsNames:(NSArray *)actionsNames;

+ (void)excuteCommandText:(NSString *)commandText;
- (BOOL)excuteExtensionCommandText:(NSString *)commandText;

- (void)excute;
- (void)stepOver;
- (void)allStepOver;

@end
