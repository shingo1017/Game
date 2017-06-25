//
//  LittleDrinkAction.m
//  destroy
//
//  Created by 尹楠 on 16/9/24.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "LittleDrinkAction.h"

@implementation LittleDrinkAction

- (NSString *)skillName {
    
    return @"不易口渴";
}

- (NSString *)systemPropertyKey {
    
    return @"littleDrinkLevel";
}

@end

@implementation UpgradeLittleDrinkAction

- (NSInteger)survivalPointConsumption {
    
    return 1000;
}

- (NSString *)systemPropertyKey {
    
    return @"littleDrinkLevel";
}

@end
