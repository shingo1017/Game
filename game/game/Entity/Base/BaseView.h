//
//  BaseView.h
//  zombie
//
//  Created by 尹楠 on 17/5/20.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseView : UIView

@property (nonatomic, copy) NSMutableDictionary *propertyDictionary;

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

@end
