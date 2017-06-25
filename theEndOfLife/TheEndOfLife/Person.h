//
//  Person.h
//  destroy
//
//  Created by 尹楠 on 16/9/2.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : Player

+ (void)setMe:(Person *)me;
+ (Person *)me;

+ (void)setPartner:(Person *)partner;
+ (Person *)partner;

- (void)initialization;
- (void)initializationNonSave;
- (void)commonInitialization;
- (BOOL)isSameSceneWithPerson:(Person *)person;

- (NSInteger)consumeLevel;

- (NSDictionary *)dictionaryForSave;
+ (void)loadMeWithSaveDictionary:(NSDictionary *)saveDictionary;
+ (void)loadPartnerWithSaveDictionary:(NSDictionary *)saveDictionary;

@end
