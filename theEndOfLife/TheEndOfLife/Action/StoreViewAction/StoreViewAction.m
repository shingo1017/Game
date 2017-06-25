//
//  StoreViewAction.m
//  destroy
//
//  Created by 尹楠 on 16/9/29.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "StoreViewAction.h"

@implementation StoreViewTakeAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"取 出" forKey:k_name save:NO];
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
    
    [[Bag sharedBag] addItem:[Item currentItem]];
    [[Store sharedStore] removeItem:[Item currentItem]];
    [Item setCurrentItem:nil];
    //[[Game sharedGame] setProperty:@"" forKey:@"currentItemKey" save:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_STORE_NOTIFICATION object:nil];
    [Game saveGame];
}

@end

@implementation StoreViewCloseAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"关 闭" forKey:k_name save:NO];
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
        
        [StoreView sharedView].right = 0;
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
