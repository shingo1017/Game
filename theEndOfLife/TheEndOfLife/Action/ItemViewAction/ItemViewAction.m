//
//  ItemViewAction.m
//  destroy
//
//  Created by 尹楠 on 16/9/29.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "ItemViewAction.h"
#import "ItemView.h"

@implementation ItemConsumeAction

- (BOOL)isAvailable {
    
    return YES;
}

- (void)actionResult {
    
    [[Item currentItem] intProperty:@"durability" plus:-1 * [[Item currentItem] intProperty:@"consumption"]];
    
    if ([[Item currentItem] intProperty:@"durability"] <= 0) {
        
        [[Bag sharedBag] removeItem:[Item currentItem]];
        [Item setCurrentItem:nil];
        //[[Game sharedGame] setProperty:@"" forKey:@"currentItemKey" save:NO];
        [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_BAG_NOTIFICATION object:nil];
    }
    
    [Game saveGame];
}

@end

@implementation ItemEquipBagAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"用作容器" forKey:k_name save:NO];
    }
    return self;
}

- (BOOL)isAvailable {
    
    if ([[Item currentItem] intProperty:@"maxBurden"] > 0)
        return YES;
    else
        return NO;
}

- (void)actionResult {
    
    [[Bag sharedBag] replaceBag:(Bag *)[Item currentItem]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Bag.name" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Bag.burden" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_BAG_NOTIFICATION object:nil];
}

@end

@implementation ItemViewCloseAction

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
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [ItemView sharedView].left = SCREEN_WIDTH;;
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
