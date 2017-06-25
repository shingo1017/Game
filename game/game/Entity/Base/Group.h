//
//  Group.h
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Group : NSObject

@property (nonatomic, copy) NSString *name;                 //名称
@property (nonatomic, strong) NSArray *belongToClassNames;  //归属的类名
@property (nonatomic, strong) NSArray *displayProperties;   //显示属性
@property (nonatomic, assign) NSInteger sort;               //显示顺序
@property (nonatomic, assign) CGRect frame;               //显示位置

+ (void)setGroup:(Group *)group forClassName:(NSString *)className;
+ (Group *)groupForClassName:(NSString *)className;

- (void)initialization;

@end
