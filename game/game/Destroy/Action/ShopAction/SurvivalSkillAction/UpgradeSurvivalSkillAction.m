//
//  UpgradeSurvivalSkillAction.m
//  destroy
//
//  Created by 尹楠 on 16/9/24.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "UpgradeSurvivalSkillAction.h"
#import "ShopView.h"

@implementation UpgradeSurvivalSkillAction

- (NSString *)name {
    
    return [NSString stringWithFormat:@"升 级 [ %li ]", [self survivalPointConsumption]];
}

- (NSInteger)survivalPointConsumption {
    
    return 0;
}

- (NSString *)systemPropertyKey {
    
    return nil;
}

- (void)actionResult {
    
    if ([[System system] intProperty:[self systemPropertyKey]] >= 5) {
        
        //已经满级
    }
    else {
        
        //可以升级
        if ([[System system] intProperty:@"survivalPoint"] > [self survivalPointConsumption]) {
            
            [[System system] intProperty:[self systemPropertyKey] plus:1];
            [[System system] intProperty:@"survivalPoint" plus:-1 * [self survivalPointConsumption]];
            [[ShopView sharedView] reloadSurvivalPoint];
            [[ShopView sharedView] reloadCurrentScene];
        }
    }
}

@end
