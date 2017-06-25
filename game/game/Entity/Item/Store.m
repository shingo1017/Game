//
//  Store.m
//  destroy
//
//  Created by 尹楠 on 16/9/26.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "Store.h"

static Store *_sharedStore;

@implementation Store

+ (void)setSharedStore:(Store *)sharedStore {
    
    _sharedStore = sharedStore;
}

+ (Store *)sharedStore {
    
    if (!_sharedStore)
        _sharedStore = [[Store alloc] init];
    
    return _sharedStore;
}

- (id)init {
    
    self = [super init];
    if (self) {
        
        [self setProperty:@"储物区" forKey:@"name"];
        _items = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)addItemWithClassName:(NSString *)className {
    
    [self addItemWithClassName:className count:1];
}

- (void)addItemWithClassName:(NSString *)className count:(NSInteger)count {
    
    for (int i = 0;i < count;i++) {
        
        Item *item = [Utility objectForClassName:className];
        [_items setObject:item forKey:[item property:@"key"]];
    }
}

- (void)addItem:(Item *)item {
    
    [_items setObject:item forKey:[item property:@"key"]];
}

- (void)removeItem:(Item *)item {
    
    [_items removeObjectForKey:[item property:@"key"]];
}

- (void)takeItem:(Item *)item {
    
    
}

- (void)takeAllItem:(Item *)item {
    
    
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

- (NSDictionary *)dictionaryForSave {
    
    NSMutableDictionary *dictionaryForSave = [[NSMutableDictionary alloc] init];
    NSMutableArray *itemArray = [[NSMutableArray alloc] init];
    for (Item *item in [self.items allValues]) {
        
        NSDictionary *itemDictionary = [item dictionaryForSave];
        [itemArray addObject:itemDictionary];
    }
    [dictionaryForSave setObject:itemArray forKey:@"items"];
    
    NSMutableDictionary *storeDictionary = [[NSMutableDictionary alloc] init];
    for (NSString *key in self.propertyDictionary.allKeys) {
        
        if (![key hasSuffix:@"_isSave"]) {
            
            BOOL isSave = [[self.propertyDictionary objectForKey:[NSString stringWithFormat:@"%@_isSave", key]] boolValue];
            
            if (isSave)
                [storeDictionary setObject:[self.propertyDictionary objectForKey:key] forKey:key];
        }
        else {
            
            [storeDictionary setObject:[self.propertyDictionary objectForKey:key] forKey:key];
        }
    }
    [dictionaryForSave setObject:storeDictionary forKey:@"properties"];
    
    return dictionaryForSave;
}

+ (void)loadWithSaveDictionary:(NSDictionary *)saveDictionary {
    
    Store *store = [[Store alloc] init];
    
    for (NSDictionary *itemDictionary in [saveDictionary objectForKey:@"items"]) {
        
        [store addItem:[Item loadWithSaveDictionary:itemDictionary]];
    }
    
    NSDictionary *propertyDictionary = [saveDictionary objectForKey:@"properties"];
    for (NSString *key in propertyDictionary.allKeys) {
        
        if ([propertyDictionary objectForKey:key])
            [store.propertyDictionary setObject:[propertyDictionary objectForKey:key] forKey:key];
    }
    
    [Store setSharedStore:store];
}

@end
