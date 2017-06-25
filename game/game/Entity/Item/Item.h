//
//  Item.h
//  destroy
//
//  Created by 尹楠 on 16/9/27.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "Entity.h"

@interface Item : Entity

+ (Item *)currentItem;
+ (void)setCurrentItem:(Item *)item;

- (NSDictionary *)dictionaryForSave;
+ (Item *)loadWithSaveDictionary:(NSDictionary *)saveDictionary;

@end

@interface ItemDrop : Entity

+ (ItemDrop *)itemDropWithClassName:(NSString *)className dropRating:(CGFloat)dropRating;
+ (ItemDrop *)itemDropWithClassName:(NSString *)className dropRating:(CGFloat)dropRating countFrom:(NSInteger)from to:(NSInteger)to;

+ (void)checkItemDrops:(NSArray *)itemDrops;

@end
