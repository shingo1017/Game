//
//  System.m
//  destroy
//
//  Created by 尹楠 on 16/9/23.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "System.h"
#import "NSString+Additions.h"

@implementation System

static System *_system;

+ (void)setSystem:(System *)system {
    
    _system = system;
}

+ (System *)system {
    
    if (!_system)
        _system = [[System alloc] init];
    
    return _system;
}

- (CGFloat)messageSpeed {
    
    if ([StoryClass currentStory].isSkip)
        return 0.0f;
    else
        return MESSAGE_SPEED;
}

- (void)intProperty:(NSString *)key plus:(NSInteger)number {
    
    [super intProperty:key plus:number save:YES];
    
    [self save];
}

- (void)setProperty:(id)value forKey:(id)key {
    
    [super setProperty:value forKey:key save:YES];
    
    [self save];
}

- (void)save {
    
    NSMutableDictionary *systemDictionary = [[NSMutableDictionary alloc] init];
    NSString *path = [DOCUMENT_PATH stringByAppendingPathComponent:@"system.plist"];
    
    for (NSString *key in self.propertyDictionary.allKeys) {
        
        if (![key hasSuffix:@"_isSave"]) {
            
            BOOL isSave = [[self.propertyDictionary objectForKey:[NSString stringWithFormat:@"%@_isSave", key]] boolValue];
            
            if (isSave)
                [systemDictionary setObject:[self.propertyDictionary objectForKey:key] forKey:key];
        }
        else {
            
            [systemDictionary setObject:[self.propertyDictionary objectForKey:key] forKey:key];
        }
    }
    [systemDictionary writeToFile:path atomically:YES];
}

+ (void)loadSystem {
    
    NSString *path = [DOCUMENT_PATH stringByAppendingPathComponent:@"system.plist"];
    NSDictionary *systemDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    
    System *system = [[System alloc] init];
    for (NSString *key in systemDictionary.allKeys) {
        
        [system.propertyDictionary setObject:[systemDictionary objectForKey:key] forKey:key];
    }
    
    [System setSystem:system];
}

@end
