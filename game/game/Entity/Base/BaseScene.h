//
//  BaseScene.h
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SceneClass [Utility subClassForFatherClass:BaseScene.class]

@interface BaseScene : BaseView

//+ (NSMutableDictionary *)sceneDictionaries;
//+ (BaseScene *)sceneWithClassName:(NSString *)className;
//+ (void)setScene:(BaseScene *)scene forClassName:(NSString *)className;
//- (void)remove;

+ (BaseScene *)sharedScene;
+ (void)setSharedScene:(BaseScene *)sharedScene;

+ (void)transferSceneWithClassName:(NSString *)className;

//+ (NSArray *)arrayForSave;
//+ (void)loadWithSaveArray:(NSArray *)saveArray;

@end
