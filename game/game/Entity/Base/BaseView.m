//
//  BaseView.m
//  zombie
//
//  Created by 尹楠 on 17/5/20.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "BaseView.h"
#import "NSString+Additions.h"
#import "NSDate+Additions.h"

@implementation BaseView

- (id)init {
    
    self = [super init];
    if (self) {
        
        _propertyDictionary = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (id)property:(NSString *)key {
    
    return [_propertyDictionary objectForKey:key];
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

- (NSString *)name {
    
    return [self property:k_name];
}

- (void)setName:(NSString *)name {
    
    [self setProperty:name forKey:k_name];
}

@end
