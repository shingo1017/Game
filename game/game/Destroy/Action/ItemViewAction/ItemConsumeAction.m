//
//  ItemConsumeAction.m
//  destroy
//
//  Created by 尹楠 on 16/9/30.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "ItemConsumeAction.h"

@implementation ItemConsumeAction

- (BOOL)isAvailable {
    
    return YES;
}

- (void)actionResult {
    
    [[Item currentItem] intProperty:@"durability" plus:-1 * [self intProperty:@"consumption"]];
    
    if ([[Item currentItem] intProperty:@"durability"] <= 0) {
        
        [[Bag sharedBag] removeItem:[Item currentItem]];
        [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_CLOSE_ITEMVIEW_NOTIFICATION object:nil];
    }
    
    [Game saveGame];
}

@end
