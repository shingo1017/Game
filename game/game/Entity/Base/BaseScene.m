//
//  BaseScene.m
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "BaseScene.h"

//static NSMutableDictionary *_scenes;
static BaseScene *_sharedScene;

@implementation BaseScene

/*+ (NSMutableDictionary *)sceneDictionaries {
    
    return _scenes;
}*/

+ (BaseScene *)sharedScene {
    
    return _sharedScene;
}

+ (void)setSharedScene:(BaseScene *)sharedScene {
    
    _sharedScene = sharedScene;
}

/*+ (BaseScene *)sceneWithClassName:(NSString *)className {
    
    BaseScene *scene = [_scenes objectForKey:className];
    
    if (!scene) {
        
        Class class = NSClassFromString(className);
        if (class) {
            
            scene = [[class alloc] init];
            [SceneClass setScene:scene forClassName:className];
        }
    }
    
    return scene;
}

+ (void)setScene:(BaseScene *)scene forClassName:(NSString *)className {
    
    [[GameClass sharedGame] setProperty:NSStringFromClass(scene.class) forKey:@"game_current_scene"];
    
    if (!_scenes)
        _scenes = [[NSMutableDictionary alloc] init];
    
    [_scenes setObject:scene forKey:className];
}

- (void)remove {
    
    [_scenes removeObjectForKey:NSStringFromClass([self class])];
}*/

+ (void)transferSceneWithClassName:(NSString *)className {
    
    //[[GameClass sharedGame] setProperty:className forKey:@"game_current_scene"];
    
    [GameClass saveGame];
}

/*+ (NSArray *)arrayForSave {
    
    NSMutableArray *arrayForSave = [[NSMutableArray alloc] init];
    
    for (NSString *sceneClassName in _scenes.allKeys) {
        
        BaseScene *scene = [SceneClass sceneWithClassName:sceneClassName];
        NSMutableDictionary *sceneDictionary = [[NSMutableDictionary alloc] init];
        [sceneDictionary setObject:NSStringFromClass([scene class]) forKey:@"sceneClassName"];
        NSMutableDictionary *scenePropertyDictionary = [[NSMutableDictionary alloc] init];
        for (NSString *key in scene.propertyDictionary.allKeys) {
            
            if (![key hasSuffix:@"_isSave"]) {
                
                BOOL isSave = [[scene.propertyDictionary objectForKey:[NSString stringWithFormat:@"%@_isSave", key]] boolValue];
                
                if (isSave)
                    [scenePropertyDictionary setObject:[scene.propertyDictionary objectForKey:key] forKey:key];
            }
            else {
                
                [scenePropertyDictionary setObject:[scene.propertyDictionary objectForKey:key] forKey:key];
            }
        }
        [sceneDictionary setObject:scenePropertyDictionary forKey:@"sceneProperties"];
        [arrayForSave addObject:sceneDictionary];
    }
    
    return arrayForSave;
}

+ (void)loadWithSaveArray:(NSArray *)saveArray {
    
    for (NSDictionary *sceneDictionary in saveArray) {
        
        NSString *sceneClassName = [sceneDictionary objectForKey:@"sceneClassName"];
        if (sceneClassName.length > 0) {
            
            BaseScene *scene = [SceneClass sceneWithClassName:sceneClassName];
            NSDictionary *propertyDictionary = [sceneDictionary objectForKey:@"sceneProperties"];
            for (NSString *key in propertyDictionary.allKeys) {
                
                if ([propertyDictionary objectForKey:key])
                    [scene.propertyDictionary setObject:[propertyDictionary objectForKey:key] forKey:key];
            }
            
            [SceneClass setScene:scene forClassName:sceneClassName];
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_HOME_MUTABLEACTIONS_NOTIFICATION object:nil];
    
    [[MainViewClass sharedView] transferSceneWithClassName:[[GameClass sharedGame] property:@"game_current_scene"]];
}

- (void)setProperty:(id)value forKey:(id)key save:(BOOL)save {

    [super setProperty:value forKey:key save:save];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"%@.%@", @"Scene", key] object:value];
}*/

@end
