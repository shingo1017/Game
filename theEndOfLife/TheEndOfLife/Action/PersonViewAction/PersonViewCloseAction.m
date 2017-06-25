//
//  PersonViewCloseAction.m
//  destroy
//
//  Created by 尹楠 on 16/9/29.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "PersonViewCloseAction.h"

@implementation PersonViewCloseAction

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
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [PersonView sharedView].right = 0;
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
