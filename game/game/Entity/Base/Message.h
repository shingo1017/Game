//
//  Message.h
//  girl
//
//  Created by 尹楠 on 16/9/6.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "Entity.h"

@interface Message : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) BOOL displayDirectly;

+ (NSArray *)messages;
+ (Message *)lastMessage;
+ (void)clearMessages;
+ (void)hideMessage;
+ (void)appendText:(NSString *)text;
+ (void)appendText:(NSString *)text displayDirectly:(BOOL)displayDirectly;

@end
