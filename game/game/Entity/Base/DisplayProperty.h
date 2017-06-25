//
//  DisplayProperty.h
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DisplayProperty : NSObject

@property (nonatomic, copy) NSString *captionKey;            //显示名称
@property (nonatomic, strong) NSArray *belongToClassNames;  //归属的类名
@property (nonatomic, strong) UIColor *color;               //字色
@property (nonatomic, assign) DisplayPropertyType type;     //显示方式
@property (nonatomic, strong) NSArray *notificationKeyPaths;    //变动时自动发送群体通知的键
@property (nonatomic, copy) NSString *keyPath;            //属性路径
@property (nonatomic, assign) NSInteger sort;               //显示顺序
@property (nonatomic, retain) NSString *lastText;           //最后显示的文字
@property (nonatomic, assign) NSInteger lastNumber;         //最后显示的数值
@property (nonatomic, assign) id displayObject;             //数据对象

- (BOOL)isAvailable;

- (NSString *)displayText;

- (NSInteger)maxNumber;
- (NSInteger)displayNumber;

@end
