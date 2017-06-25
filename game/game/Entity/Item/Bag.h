//
//  Bag.h
//  destroy
//
//  Created by 尹楠 on 16/9/26.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "Entity.h"
#import "Item.h"

@interface Bag : Item

@property (nonatomic, strong) NSMutableDictionary *items;

+ (void)setSharedBag:(Bag *)sharedBag;
+ (Bag *)sharedBag;

- (void)replaceBag:(Bag *)bag;
- (void)removeBag;

- (Item *)addItemWithClassName:(NSString *)className;
- (id)addItemWithClassName:(NSString *)className count:(NSInteger)count;
- (void)addItem:(Item *)item;
- (void)removeItem:(Item *)item;
- (NSInteger)countOfItemWithClassName:(NSString *)className;
- (BOOL)hasItemWithItemKey:(NSString *)itemKey;
- (BOOL)isEmpty;
- (NSArray *)itemGroups;
- (CGFloat)burden;

- (NSDictionary *)dictionaryForSave;
+ (void)loadWithSaveDictionary:(NSDictionary *)saveDictionary;

@end
