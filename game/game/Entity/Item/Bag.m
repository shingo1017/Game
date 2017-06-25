//
//  Bag.m
//  destroy
//
//  Created by 尹楠 on 16/9/26.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "Bag.h"

static Bag *_sharedBag;

@implementation Bag

+ (void)setSharedBag:(Bag *)sharedBag {
    
    _sharedBag = sharedBag;
}

+ (Bag *)sharedBag {
    
    if (!_sharedBag)
        _sharedBag = [[Bag alloc] init];
    
    return _sharedBag;
}

- (id)init {
    
    self = [super init];
    if (self) {
        
        [self setProperty:@"无" forKey:@"name"];
        [self setProperty:@"容器" forKey:@"use" save:NO];
        [self setProperty:@4 forKey:@"maxBurden"];
        
        _items = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (Item *)addItemWithClassName:(NSString *)className {
    
    return [self addItemWithClassName:className count:1];
}

- (id)addItemWithClassName:(NSString *)className count:(NSInteger)count {
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (int i = 0;i < count;i++) {
        
        Item *item = [Utility objectForClassName:className];
        [items addObject:item];
        [_items setObject:item forKey:[item property:@"key"]];
    }
    
    if (count > 1)
        return items;
    else {
        
        Item *item = [items firstObject];
        if ([[item class] isSubclassOfClass:[Bag class]])
            [self autoReplaceBag:(Bag *)item];
        return item;
    }
}

- (void)addItem:(Item *)item {
    
    [_items setObject:item forKey:[item property:@"key"]];
    
    if ([[item class] isSubclassOfClass:[Bag class]])
        [self autoReplaceBag:(Bag *)item];
}

- (void)autoReplaceBag:(Bag *)bag {
    
    if ([bag intProperty:@"maxBurden"] > [[Bag sharedBag] intProperty:@"maxBurden"]) {
        
        [self replaceBag:bag];
    }
}

- (void)removeItem:(Item *)item {
    
    [_items removeObjectForKey:[item property:@"key"]];
}

- (void)replaceBag:(Bag *)bag {
    
    if ([[Bag sharedBag] class] != [Bag class])
        [[Bag sharedBag] addItem:[Bag sharedBag]];
    
    bag.items = [[NSMutableDictionary alloc] initWithDictionary:[Bag sharedBag].items];
    [[Bag sharedBag].items removeAllObjects];
    [bag removeItem:bag];
    [Bag setSharedBag:bag];        
}

- (void)removeBag {
    
    [_items removeAllObjects];
    
    _sharedBag = nil;
}

- (NSInteger)countOfItemWithClassName:(NSString *)className {
    
    return [self intProperty:[NSString stringWithFormat:@"%@Count", className]];
}

- (BOOL)hasItemWithItemKey:(NSString *)itemKey {
    
    BOOL exist = NO;
    for (NSString *key in _items.allKeys) {
        
        if ([key isEqualToString:itemKey]) {
            
            exist = YES;
            break;
        }
    }
    
    return exist;
}

- (BOOL)isEmpty {
    
    return _items.count == 0;
}

- (NSArray *)itemGroups {
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    for (Item *item in [self.items allValues]) {
        
        NSString *className = NSStringFromClass([item class]);
        
        if ([item boolProperty:@"canSet"]) {
            
            if ([dictionary objectForKey:className])
                 [((NSMutableArray *)[dictionary objectForKey:className]) addObject:item];
            else {
                
                NSMutableArray *itemArray = [[NSMutableArray alloc] initWithObjects:item, nil];
                [dictionary setObject:itemArray forKey:className];
            }
        }
        else {
            
            NSMutableArray *itemArray = [[NSMutableArray alloc] initWithObjects:item, nil];
            [dictionary setObject:itemArray forKey:[item property:@"key"]];
        }
    }
    
    NSMutableArray *groups = [[NSMutableArray alloc] initWithArray:dictionary.allValues];
    return groups;
}

- (CGFloat)burden {
    
    CGFloat burden = 0;
    for (Item *item in [self.items allValues]) {
        
        burden += [item floatProperty:@"burden"];
    }
    return burden;
}

- (NSDictionary *)dictionaryForSave {
    
    NSMutableDictionary *dictionaryForSave = [[NSMutableDictionary alloc] init];
    
    [dictionaryForSave setObject:NSStringFromClass([self class]) forKey:@"className"];
    
    NSMutableArray *itemArray = [[NSMutableArray alloc] init];
    for (Item *item in [self.items allValues]) {
        
        NSDictionary *itemDictionary = [item dictionaryForSave];
        [itemArray addObject:itemDictionary];
    }
    [dictionaryForSave setObject:itemArray forKey:@"items"];
    
    NSMutableDictionary *bagDictionary = [[NSMutableDictionary alloc] init];
    for (NSString *key in self.propertyDictionary.allKeys) {
        
        if (![key hasSuffix:@"_isSave"]) {
            
            BOOL isSave = [[self.propertyDictionary objectForKey:[NSString stringWithFormat:@"%@_isSave", key]] boolValue];
            
            if (isSave)
                [bagDictionary setObject:[self.propertyDictionary objectForKey:key] forKey:key];
        }
        else {
            
            [bagDictionary setObject:[self.propertyDictionary objectForKey:key] forKey:key];
        }
    }
    [dictionaryForSave setObject:bagDictionary forKey:@"properties"];
    
    return dictionaryForSave;
}

+ (void)loadWithSaveDictionary:(NSDictionary *)saveDictionary {
    
    NSString *bagClassName = [saveDictionary objectForKey:@"className"];
    Bag *bag = [Utility objectForClassName:bagClassName];
    
    for (NSDictionary *itemDictionary in [saveDictionary objectForKey:@"items"]) {
        
        [bag addItem:[Item loadWithSaveDictionary:itemDictionary]];
    }
    
    NSDictionary *propertyDictionary = [saveDictionary objectForKey:@"properties"];
    for (NSString *key in propertyDictionary.allKeys) {
        
        if ([propertyDictionary objectForKey:key])
            [bag.propertyDictionary setObject:[propertyDictionary objectForKey:key] forKey:key];
    }
    
    [Bag setSharedBag:bag];
}

@end
