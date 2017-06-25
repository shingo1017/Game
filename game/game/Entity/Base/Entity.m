//
//  Entity.m
//  girl
//
//  Created by 尹楠 on 16/9/4.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "Entity.h"
#import "NSString+Additions.h"
#import "NSDate+Additions.h"

@interface Entity ()

@end

@implementation Entity

+ (void)initKeys {
    
    [Utility addKeys:@[k_id, k_name]
               texts:@[@"ID", @"姓名"]];
}

- (id)init {
    
    self = [super init];
    if (self) {
        
        _propertyDictionary = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (id)property:(NSString *)key {
    
    id property = [_propertyDictionary objectForKey:key];
    if ([property isKindOfClass:NSNumber.class])
        property = [NSString stringWithFormat:@"%@", property];
    
    return property;
}

- (NSInteger)intProperty:(NSString *)key {
    
    return [[self property:key] integerValue];
}

- (CGFloat)floatProperty:(NSString *)key {
    
    return [[self property:key] floatValue];
}

- (BOOL)boolProperty:(NSString *)key {
    
    return [[self property:key] boolValue];
}

- (void)setProperty:(id)value forKey:(id)key {
    
    [self setProperty:value forKey:key save:YES];
}

- (void)setProperty:(id)value forKey:(id)key save:(BOOL)save {
    
    if ([_propertyDictionary objectForKey:[NSString stringWithFormat:@"%@_max", key]]) {
        
        NSInteger max = [[_propertyDictionary objectForKey:[NSString stringWithFormat:@"%@_max", key]] integerValue];
        
        if ([value integerValue] > max)
            [_propertyDictionary setObject:@(max) forKey:key];
        else if ([value integerValue] < 0)
            [_propertyDictionary setObject:@0 forKey:key];
        else
            [_propertyDictionary setObject:value forKey:key];
    }
    else
        [_propertyDictionary setObject:value forKey:key];
    [_propertyDictionary setObject:@(save) forKey:[NSString stringWithFormat:@"%@_isSave", key]];
    
//    if ([[self class] isSubclassOfClass:[Player class]])
    [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"%@.%@", NSStringFromClass(self.class), key] object:value];
}

- (void)intProperty:(NSString *)key plus:(NSInteger)number {
    
    [self intProperty:key plus:number save:YES];
}

- (void)intProperty:(NSString *)key plus:(NSInteger)number save:(BOOL)save {
    
    NSInteger property = [[self property:key] integerValue];
    [self setProperty:@(property + number) forKey:key save:save];
}

- (void)dateProperty:(NSString *)key plus:(NSTimeInterval)timeInterval {
    
    [self dateProperty:key plus:timeInterval save:YES];
}

- (void)dateProperty:(NSString *)key plus:(NSTimeInterval)timeInterval save:(BOOL)save {
    
    NSDate *date = [self property:key];
    date = [date dateByAddingTimeInterval:timeInterval];
    [self setProperty:date forKey:key save:save];
}

- (NSString *)id {
    
    return [self property:k_id];
}

- (NSString *)name {
    
    return [self property:k_name];
}

- (void)setName:(NSString *)name {
    
    [self setProperty:name forKey:k_name];
}

+ (void)setEntity:(Entity *)entity {
    
    if ([entity.class allowSaveArray]) {
        
        NSMutableDictionary *dictionariesForSave = [[NSMutableDictionary alloc] initWithDictionary:[[GameClass sharedGame] property:@"entity_array"]];
        [dictionariesForSave setObject:entity forKey:[entity property:@"id"]];
        [[GameClass sharedGame] setProperty:dictionariesForSave forKey:@"entity_array" save:NO];
    }
}

+ (Entity *)entityWithId:(NSString *)id {
    
    if ([self allowSaveArray]) {
        
        NSMutableDictionary *dictionariesForSave = [[NSMutableDictionary alloc] initWithDictionary:[[GameClass sharedGame] property:@"entity_array"]];
        Entity *entity = dictionariesForSave[id];
        if (!entity) {
            
            entity = [[self alloc] init];
            [Entity setEntity:entity];
        }
        
        return entity;
    }
    else
        return nil;
}

- (NSDictionary *)dictionaryForSave {
    
    NSMutableDictionary *dictionaryForSave = [[NSMutableDictionary alloc] init];
    
    [dictionaryForSave setObject:NSStringFromClass(self.class) forKey:@"className"];
    
    NSMutableDictionary *propertyDictionary = [[NSMutableDictionary alloc] init];
    for (NSString *key in self.propertyDictionary.allKeys) {
        
        if (![key hasSuffix:@"_isSave"]) {
            
            BOOL isSave = [[self.propertyDictionary objectForKey:[NSString stringWithFormat:@"%@_isSave", key]] boolValue];
            
            if (isSave)
                [propertyDictionary setObject:[self.propertyDictionary objectForKey:key] forKey:key];
        }
        else {
            
            [propertyDictionary setObject:[self.propertyDictionary objectForKey:key] forKey:key];
        }
    }
    [dictionaryForSave setObject:propertyDictionary forKey:@"properties"];
    
    return dictionaryForSave;
}

+ (Entity *)loadWithSaveDictionary:(NSDictionary *)saveDictionary {
    
    NSString *className = [saveDictionary objectForKey:@"className"];
    if (className.length > 0) {
        
        Entity *entity = [[NSClassFromString(className) alloc] init];
        NSDictionary *propertyDictionary = [saveDictionary objectForKey:@"properties"];
        for (NSString *key in propertyDictionary.allKeys) {
            
            if ([propertyDictionary objectForKey:key])
                [entity.propertyDictionary setObject:[propertyDictionary objectForKey:key] forKey:key];
        }
        
        return entity;
    }
    else
        return nil;
}

+ (BOOL)allowSaveArray {
    
    return YES;
}

+ (NSArray *)arrayForSave {
    
    NSMutableArray *arrayForSave = [[NSMutableArray alloc] init];
    NSMutableDictionary *dictionariesForSave = [[NSMutableDictionary alloc] initWithDictionary:[[GameClass sharedGame] property:@"entity_array"]];
    
    for (NSString *id in dictionariesForSave.allKeys) {
        
        Entity *entity = [self entityWithId:id];
        if ([entity.class isSubclassOfClass:self]) {
            
            NSMutableDictionary *entityDictionary = [[NSMutableDictionary alloc] init];
            [entityDictionary setObject:entity.id forKey:k_id];
            NSMutableDictionary *entityPropertyDictionary = [[NSMutableDictionary alloc] init];
            for (NSString *key in entity.propertyDictionary.allKeys) {
                
                if (![key hasSuffix:@"_isSave"]) {
                    
                    BOOL isSave = [[entity.propertyDictionary objectForKey:[NSString stringWithFormat:@"%@_isSave", key]] boolValue];
                    
                    if (isSave)
                        [entityPropertyDictionary setObject:[entity.propertyDictionary objectForKey:key] forKey:key];
                }
                else {
                    
                    [entityPropertyDictionary setObject:[entity.propertyDictionary objectForKey:key] forKey:key];
                }
            }
            [entityDictionary setObject:entityPropertyDictionary forKey:@"properties"];
            [arrayForSave addObject:entityDictionary];
        }
    }
    
    return arrayForSave;
}

+ (void)loadWithSaveArray:(NSArray *)saveArray {
    
    for (NSDictionary *entityDictionary in saveArray) {
        
        NSString *id = [entityDictionary objectForKey:k_id];
        if (id.length > 0) {
            
            Entity *entity = [self entityWithId:id];
            NSDictionary *propertyDictionary = [entityDictionary objectForKey:@"properties"];
            for (NSString *key in propertyDictionary.allKeys) {
                
                if ([propertyDictionary objectForKey:key])
                    [entity.propertyDictionary setObject:[propertyDictionary objectForKey:key] forKey:key];
            }
            
            [Entity setEntity:entity];
        }
    }
}

@end
