//
//  BuySupplyAction.m
//  destroy
//
//  Created by 尹楠 on 16/9/24.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "BuySupplyAction.h"
#import "ShopView.h"

@implementation BuySupplyAction

- (NSString *)name {
    
    return [NSString stringWithFormat:@"购 买 [ %li ]", [self survivalPointConsumption]];
}

- (NSInteger)survivalPointConsumption {
    
    return 0;
}

- (NSString *)systemPropertyKey {
    
    return nil;
}

- (void)actionResult {
    
    if ([[System system] boolProperty:[self systemPropertyKey]]) {
        
        //已购买
    }
    else {
        
        //未购买
        if ([[System system] intProperty:@"survivalPoint"] > [self survivalPointConsumption]) {
            
            [[System system] setProperty:@YES forKey:[self systemPropertyKey]];
            [[System system] intProperty:@"survivalPoint" plus:-1 * [self survivalPointConsumption]];
            [[ShopView sharedView] reloadSurvivalPoint];
            [[ShopView sharedView] reloadCurrentScene];
        }
    }
}

@end
