//
//  LittleEatAction.m
//  destroy
//
//  Created by 尹楠 on 16/9/24.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "LittleEatAction.h"

@implementation LittleEatAction

- (NSString *)skillName {
    
    return @"食量小";
}

- (NSString *)systemPropertyKey {
    
    return @"littleEatLevel";
}

@end

@implementation UpgradeLittleEatAction

- (NSInteger)survivalPointConsumption {
    
    return 500;
}

- (NSString *)systemPropertyKey {
    
    return @"littleEatLevel";
}

@end
