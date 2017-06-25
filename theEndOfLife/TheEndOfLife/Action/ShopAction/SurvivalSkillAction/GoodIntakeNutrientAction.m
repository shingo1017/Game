//
//  GoodIntakeNutrientAction.m
//  destroy
//
//  Created by 尹楠 on 16/9/24.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "GoodIntakeNutrientAction.h"

@implementation GoodIntakeNutrientAction

- (NSString *)skillName {
    
    return @"营养易吸收";
}

- (NSString *)systemPropertyKey {
    
    return @"goodIntakeNutrientLevel";
}

@end

@implementation UpgradeGoodIntakeNutrientAction

- (NSInteger)survivalPointConsumption {
    
    return 500;
}

- (NSString *)systemPropertyKey {
    
    return @"goodIntakeNutrientLevel";
}

@end
