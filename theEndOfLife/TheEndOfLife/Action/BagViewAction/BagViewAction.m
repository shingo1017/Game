//
//  BagViewAction.m
//  destroy
//
//  Created by 尹楠 on 16/9/29.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "BagViewAction.h"

@implementation BagViewStoreAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"存 入" forKey:k_name save:NO];
    }
    return self;
}

- (BOOL)isAvailable {
    
    if ([[Scene currentScene] boolProperty:@"canStore"] &&
        [Item currentItem])
        return YES;
    else
        return NO;
}

- (void)actionResult {
    
    [[Store sharedStore] addItem:[Item currentItem]];
    [[Bag sharedBag] removeItem:[Item currentItem]];
    [Item setCurrentItem:nil];
    //[[Game sharedGame] setProperty:@"" forKey:@"currentItemKey" save:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_BAG_NOTIFICATION object:nil];
    [Game saveGame];
}

@end

@implementation BagViewDropAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"扔 掉" forKey:k_name save:NO];
    }
    return self;
}

- (BOOL)isAvailable {
    
    if ([Item currentItem])
        return YES;
    else
        return NO;
}

- (void)actionResult {
    
    [[Bag sharedBag] removeItem:[Item currentItem]];
    [Item setCurrentItem:nil];
    //[[Game sharedGame] setProperty:@"" forKey:@"currentItemKey" save:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_BAG_NOTIFICATION object:nil];
    [Game saveGame];
}

@end

@implementation BagViewCloseAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"关 闭" forKey:k_name save:NO];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionResult) name:K_SHOULD_CLOSE_ITEMVIEW_NOTIFICATION object:nil];
    }
    return self;
}

- (NSString *)parentActionName {
    
    return nil;
}

- (BOOL)isAvailable {
    
    return YES;
}

- (void)actionResult {
    
    [Action applySceneActions];
    
    [Item setCurrentItem:nil];
    //[[Game sharedGame] setProperty:@"" forKey:@"currentItemKey" save:NO];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [BagView sharedView].right = 0;
        [MainView sharedView].sceneWidget.alpha = 1.0f;
        [MainView sharedView].viewMaskView.alpha = 0.0f;
    }];
    
    [[MainView sharedView] hideMyImageWithAnimation:YES];
    if ([[Person me] isSameSceneWithPerson:[Person partner]])
        [[MainView sharedView] showPartnerImageWithAnimation:YES];
    else
        [[MainView sharedView] hidePartnerImageWithAnimation:YES];
}

@end
