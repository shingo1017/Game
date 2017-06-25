//
//  SupplyFoodAction.m
//  destroy
//
//  Created by 尹楠 on 16/9/24.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "SupplyFoodAction.h"

@implementation SupplyFoodAction

- (NSString *)itemName {

    return @"面包";
}

- (NSString *)systemPropertyKey {
    
    return @"foodPurchased";
}

@end

@implementation BuySupplyFoodAction

- (NSInteger)survivalPointConsumption {
    
    return 150;
}

- (NSString *)systemPropertyKey {
    
    return @"foodPurchased";
}

@end
