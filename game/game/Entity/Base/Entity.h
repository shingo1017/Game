//
//  Entity.h
//  girl
//
//  Created by 尹楠 on 16/9/4.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import <Foundation/Foundation.h>

#define k_id        @"id"
#define k_name      @"name"

@interface Entity : NSObject

@property (nonatomic, readonly, copy) NSString *id;
@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, copy) NSMutableDictionary *propertyDictionary;

//初始化Key
+ (void)initKeys;

- (void)setProperty:(id)value forKey:(id)key;
- (void)setProperty:(id)value forKey:(id)key save:(BOOL)save;
//- (void)setProperty:(id)value forKey:(id)key save:(BOOL)save private:(BOOL)private;
- (void)intProperty:(NSString *)key plus:(NSInteger)number;
- (void)intProperty:(NSString *)key plus:(NSInteger)number save:(BOOL)save;

- (void)dateProperty:(NSString *)key plus:(NSTimeInterval)timeInterval;
- (void)dateProperty:(NSString *)key plus:(NSTimeInterval)timeInterval save:(BOOL)save;
//- (void)dateProperty:(NSString *)key plus:(NSTimeInterval)timeInterval save:(BOOL)save private:(BOOL)private;

- (id)property:(NSString *)key;
- (NSInteger)intProperty:(NSString *)key;
- (CGFloat)floatProperty:(NSString *)key;
- (BOOL)boolProperty:(NSString *)key;

//保存单一对象
- (NSDictionary *)dictionaryForSave;
+ (Entity *)loadWithSaveDictionary:(NSDictionary *)saveDictionary;

//保存对象数组
+ (void)setEntity:(Entity *)entity;
+ (Entity *)entityWithId:(NSString *)id;
//TODO:可以自动获取子类有没有实现ArrayForSave方法
+ (BOOL)allowSaveArray;
+ (NSArray *)arrayForSave;
+ (void)loadWithSaveArray:(NSArray *)saveArray;

@end
