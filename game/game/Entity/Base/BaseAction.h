//
//  BaseAction.h
//  girl
//
//  Created by 尹楠 on 16/9/2.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseAction : Entity

@property (nonatomic, strong) NSArray *belongToClassNames;  //归属的类名
@property (nonatomic, copy) NSString *parentActionName;
@property (nonatomic, strong) NSArray *actions;
@property (nonatomic, strong) NSArray *availableActions;
@property (nonatomic, assign) NSInteger sort;
//@property (nonatomic, assign) BOOL canWatch;
//@property (nonatomic, assign) BOOL canTouch;

+ (NSArray *)sharedActions;
+ (NSArray *)actionsBelongToClassName:(NSString *)className;
+ (CGFloat)maxWidthOfActionCell;
+ (void)refreshActions;
+ (void)applySceneActions;
+ (void)applyStoryActions;
+ (void)appendAction:(BaseAction *)action;
+ (void)appendActions:(NSArray *)actions;
+ (NSArray *)availableActionInActions:(NSArray *)actions;
+ (void)clearActions;

- (BOOL)isAvailable;
- (void)actionResult;

@end
