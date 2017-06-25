//
//  Item.m
//  destroy
//
//  Created by 尹楠 on 16/9/27.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "Item.h"
#import "Bag.h"

@implementation Item

static Item *_currentItem;

+ (Item *)currentItem {
    
    return _currentItem;
}

+ (void)setCurrentItem:(Item *)item {
    
    _currentItem = item;
}

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self setProperty:[[NSUUID UUID] UUIDString] forKey:@"key" save:NO];
    }
    return self;
}

- (void)setProperty:(id)value forKey:(id)key save:(BOOL)save {
    
    [super setProperty:value forKey:key save:save];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"%@.%@", @"Item", key] object:value];
}

- (NSDictionary *)dictionaryForSave {
    
    NSMutableDictionary *dictionaryForSave = [[NSMutableDictionary alloc] init];
    [dictionaryForSave setObject:NSStringFromClass([self class]) forKey:@"className"];
    
    NSMutableDictionary *itemDictionary = [[NSMutableDictionary alloc] init];
    for (NSString *key in self.propertyDictionary.allKeys) {
        
        if (![key hasSuffix:@"_isSave"]) {
            
            BOOL isSave = [[self.propertyDictionary objectForKey:[NSString stringWithFormat:@"%@_isSave", key]] boolValue];
            
            if (isSave)
                [itemDictionary setObject:[self.propertyDictionary objectForKey:key] forKey:key];
        }
        else {
            
            [itemDictionary setObject:[self.propertyDictionary objectForKey:key] forKey:key];
        }
    }
    [dictionaryForSave setObject:itemDictionary forKey:@"properties"];
    
    return dictionaryForSave;
}

+ (Item *)loadWithSaveDictionary:(NSDictionary *)saveDictionary {
    
    NSString *itemClassName = [saveDictionary objectForKey:@"className"];
    
    Item *item = [Utility objectForClassName:itemClassName];
    NSDictionary *propertyDictionary = [saveDictionary objectForKey:@"properties"];
    for (NSString *key in propertyDictionary.allKeys) {
        
        if ([propertyDictionary objectForKey:key])
            [item.propertyDictionary setObject:[propertyDictionary objectForKey:key] forKey:key];
    }
    
    return item;
}

@end

@implementation ItemDrop

+ (ItemDrop *)itemDropWithClassName:(NSString *)className dropRating:(CGFloat)dropRating {
    
    return [ItemDrop itemDropWithClassName:className dropRating:dropRating countFrom:1 to:1];
}

+ (ItemDrop *)itemDropWithClassName:(NSString *)className dropRating:(CGFloat)dropRating countFrom:(NSInteger)from to:(NSInteger)to {
    
    ItemDrop *itemDrop = [[ItemDrop alloc] init];
    [itemDrop setProperty:className forKey:@"className"];
    [itemDrop setProperty:@(dropRating) forKey:@"dropRating"];
    [itemDrop setProperty:@(from) forKey:@"countFrom"];
    [itemDrop setProperty:@(to) forKey:@"countTo"];
    return itemDrop;
}

+ (void)checkItemDrops:(NSArray *)itemDrops {
    
    NSInteger prayEffect = [[Game sharedGame] boolProperty:@"isPrayLuck"] ? 100 : 0;
    NSInteger random = [Utility getRandomNumber:0 to:10000];
    NSInteger lastRandom = 0;
    
    NSString *className;
    NSInteger count = 0;
    for (ItemDrop *itemDrop in itemDrops) {
        
        CGFloat dropRating = [itemDrop floatProperty:@"dropRating"];
        if ((lastRandom >= random && random < dropRating) || [Utility getRandomNumber:0 to:10000] < prayEffect) {
            
            className  = [itemDrop property:@"className"];
            NSInteger countFrom  = [itemDrop intProperty:@"countFrom"];
            NSInteger countTo  = [itemDrop intProperty:@"countTo"];
            count = [Utility getRandomNumber:countFrom to:countTo];
            break;
        }

        lastRandom += dropRating;
    }
    
    if (className) {
        
        Item *item = [Utility objectForClassName:className];
        [[Bag sharedBag] addItemWithClassName:className count:count];
        if (count == 1)
            [Cutscene excuteCommandText:[NSString stringWithFormat:@"#c|找到%@。", [item property:@"name"]]];
        else
            [Cutscene excuteCommandText:[NSString stringWithFormat:@"#c|找到%@ x %li。", [item property:@"name"], count]];
    }
    else
        [Cutscene excuteCommandText:@"#c|寻找补给品……"];
}

@end
