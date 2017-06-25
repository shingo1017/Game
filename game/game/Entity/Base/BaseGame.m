//
//  BaseGame.m
//  destroy
//
//  Created by 尹楠 on 16/9/23.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "BaseGame.h"
#import "NSString+Additions.h"

static BaseGame *_sharedGame;

@implementation BaseGame

+ (void)setSharedGame:(BaseGame *)game {
    
    _sharedGame = game;
}

+ (BaseGame *)sharedGame {
    
    if (!_sharedGame) {
        
        _sharedGame = [[GameClass alloc] init];
    }
    
    return _sharedGame;
}

- (id)init {
    
    self = [super init];
    if (self) {
        
        [self setProperty:@[] forKey:@"visitedScenes"];
    }
    
    return self;
}

- (NSDate *)time {
    
    return [self property:@"time"];
}

- (NSInteger)daysPass {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comp = [calendar components:NSCalendarUnitDay
                                         fromDate:[@"2016-10-07 13:45:00" datetimeValue]
                                           toDate:[self property:@"time"]
                                          options:NSCalendarWrapComponents];
    
    return comp.day;
}

- (NSInteger)hoursPass {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comp = [calendar components:NSCalendarUnitHour
                                         fromDate:[@"2016-10-07 13:45:00" datetimeValue]
                                           toDate:[self property:@"time"]
                                          options:NSCalendarWrapComponents];
    
    return comp.hour;
}

- (void)setProperty:(id)value forKey:(id)key {
    
    [self setProperty:value forKey:key save:YES];
}

- (void)setProperty:(id)value forKey:(id)key save:(BOOL)save {
    
    [super setProperty:value forKey:key save:save];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"%@.%@", @"Game", key] object:nil];
}

- (void)dateProperty:(NSString *)key plus:(NSTimeInterval)timeInterval {
    
    [super dateProperty:key plus:timeInterval save:YES];
    
    [[GameClass sharedGame] timeChanged];
}

- (void)timeChanged {
    
    
}

- (NSDictionary *)dictionaryForSave {
    
    NSMutableDictionary *dictionaryForSave = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary *gameDictionary = [[NSMutableDictionary alloc] init];
    for (NSString *key in self.propertyDictionary.allKeys) {
        
        if (![key hasSuffix:@"_isSave"]) {
            
            BOOL isSave = [[self.propertyDictionary objectForKey:[NSString stringWithFormat:@"%@_isSave", key]] boolValue];
            
            if (isSave)
                [gameDictionary setObject:[self.propertyDictionary objectForKey:key] forKey:key];
        }
        else {
            
            [gameDictionary setObject:[self.propertyDictionary objectForKey:key] forKey:key];
        }
    }
    [dictionaryForSave setObject:gameDictionary forKey:@"gameProperties"];
    
    return dictionaryForSave;
}

+ (void)loadWithSaveDictionary:(NSDictionary *)saveDictionary {
    
    NSDictionary *propertyDictionary = [saveDictionary objectForKey:@"gameProperties"];
    for (NSString *key in propertyDictionary.allKeys) {
        
        if ([propertyDictionary objectForKey:key])
            [[GameClass sharedGame].propertyDictionary setObject:[propertyDictionary objectForKey:key] forKey:key];
    }
}

+ (void)saveGame {
    
    NSString *path =[DOCUMENT_PATH stringByAppendingPathComponent:@"save.plist"];
    
    NSDictionary *saveDictionary = nil;
    
    saveDictionary = [[GameClass sharedGame] saveGameContent];
    
    [saveDictionary writeToFile:path atomically:YES];
}

- (NSDictionary *)saveGameContent {
    
    return nil;
}

+ (void)loadGame {
    
    NSString *path = [DOCUMENT_PATH stringByAppendingPathComponent:@"save.plist"];
    NSDictionary *saveDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    
    [[GameClass sharedGame] loadGameContentWithSaveFile:saveDictionary];
}

- (void)loadGameContentWithSaveFile:(NSDictionary *)saveDictionary {
    
    
}

+ (void)deleteLoad {
    
    NSString *path = [DOCUMENT_PATH stringByAppendingPathComponent:@"save.plist"];
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
}

+ (BOOL)canLoadGame {
    
    NSString *path =[DOCUMENT_PATH stringByAppendingPathComponent:@"save.plist"];
    NSDictionary *saveDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    
    BOOL result = NO;
    
    result = [[GameClass sharedGame] canLoadGameWithSaveFile:saveDictionary];
    
    return result;
}

- (BOOL)canLoadGameWithSaveFile:(NSDictionary *)saveDictionary {
    
    return NO;
}

@end
