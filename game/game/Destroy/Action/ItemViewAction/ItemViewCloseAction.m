//
//  ItemViewCloseAction.m
//  destroy
//
//  Created by 尹楠 on 16/9/29.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "ItemViewCloseAction.h"

@implementation ItemViewCloseAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        self.name = @"关 闭";
        
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
        
        [ItemView sharedView].right = 0;
        [MainView sharedView].viewMaskView.alpha = 0.0f;
    }];
    
    [[MainView sharedView] hideMyImageWithAnimation:YES];
    if ([[Person me] isSameSceneWithPerson:[Person partner]])
        [[MainView sharedView] showPartnerImageWithAnimation:YES];
    else
        [[MainView sharedView] hidePartnerImageWithAnimation:YES];
}

@end
