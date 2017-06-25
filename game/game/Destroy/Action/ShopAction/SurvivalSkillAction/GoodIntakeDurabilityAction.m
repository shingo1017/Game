//
//  GoodIntakeDurabilityAction.m
//  destroy
//
//  Created by 尹楠 on 16/9/24.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "GoodIntakeDurabilityAction.h"

@implementation GoodIntakeDurabilityAction

- (NSString *)skillName {
    
    return @"水分易吸收";
}

- (NSString *)systemPropertyKey {
    
    return @"goodIntakeDurabilityLevel";
}

@end

@implementation UpgradeGoodIntakeDurabilityAction

- (NSInteger)survivalPointConsumption {
    
    return 1000;
}

- (NSString *)systemPropertyKey {
    
    return @"goodIntakeDurabilityLevel";
}

@end
