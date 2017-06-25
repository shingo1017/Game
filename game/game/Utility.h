//
//  Utility.h
//  girl
//
//  Created by 尹楠 on 16/9/2.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import <Foundation/Foundation.h>

#define random(from, to)                (from + (arc4random() % (to - from + 1)))

@interface Utility : NSObject

//Key
+ (void)addKeys:(NSArray *)keys texts:(NSArray *)texts;
+ (NSString *)textForKey:(NSString *)key;

//构建
+ (id)objectForClassName:(NSString *)className;
+ (Class)subClassForFatherClass:(Class)fatherClass;
+ (NSArray *)getSubclassesWithFatherClassName:(NSString *)fatherClassName;
+ (NSArray *)getSubClassesWithFatherClassName:(NSString *)fatherClassName respondsToSelector:(SEL)selector;
+ (NSArray *)getSubClassInstancesWithFatherClassName:(NSString *)fatherClassName belongToClassName:(NSString *)belongToClassName;

//随机数
+ (NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to;

+ (void)reloadActions;

+ (NSArray *)sortArray:(NSArray *)array;

@end
