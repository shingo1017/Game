//
//  BaseGame.h
//  destroy
//
//  Created by 尹楠 on 16/9/23.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "Entity.h"

#define GameClass [Utility subClassForFatherClass:BaseGame.class]

@interface BaseGame : Entity

+ (void)setSharedGame:(BaseGame *)game;
+ (BaseGame *)sharedGame;

- (NSDictionary *)dictionaryForSave;
+ (void)loadWithSaveDictionary:(NSDictionary *)saveDictionary;

- (NSDate *)time;
- (NSInteger)daysPass;
- (NSInteger)hoursPass;
- (void)timeChanged;

+ (void)saveGame;
- (NSDictionary *)saveGameContent;

+ (void)loadGame;
- (void)loadGameContentWithSaveFile:(NSDictionary *)saveDictionary;

+ (void)deleteLoad;

+ (BOOL)canLoadGame;
- (BOOL)canLoadGameWithSaveFile:(NSDictionary *)saveDictionary;

@end


