//
//  Store.h
//  destroy
//
//  Created by 尹楠 on 16/9/26.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "Entity.h"
#import "Item.h"

@interface Store : Entity

@property (nonatomic, strong) NSMutableDictionary *items;

+ (void)setSharedStore:(Store *)sharedStore;
+ (Store *)sharedStore;

- (void)addItemWithClassName:(NSString *)className;
- (void)addItemWithClassName:(NSString *)className count:(NSInteger)count;
- (void)addItem:(Item *)item;
- (void)removeItem:(Item *)item;
- (void)takeItem:(Item *)item;
- (void)takeAllItem:(Item *)item;
- (NSInteger)countOfItemWithClassName:(NSString *)className;
- (BOOL)hasItemWithItemKey:(NSString *)itemKey;
- (BOOL)isEmpty;
- (NSArray *)itemGroups;

- (NSDictionary *)dictionaryForSave;
+ (void)loadWithSaveDictionary:(NSDictionary *)saveDictionary;

@end
