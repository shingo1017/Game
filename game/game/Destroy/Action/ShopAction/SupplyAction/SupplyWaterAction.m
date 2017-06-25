//
//  SupplyWaterAction.m
//  destroy
//
//  Created by 尹楠 on 16/9/24.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "SupplyWaterAction.h"

@implementation SupplyWaterAction

- (NSString *)itemName {

    return @"矿泉水";
}

- (NSString *)systemPropertyKey {
    
    return @"waterPurchased";
}

@end

@implementation BuySupplyWaterAction

- (NSInteger)survivalPointConsumption {
    
    return 300;
}

- (NSString *)systemPropertyKey {
    
    return @"waterPurchased";
}

@end
