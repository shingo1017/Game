//
//  GoodIntakeRestAction.m
//  destroy
//
//  Created by 尹楠 on 16/9/24.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "GoodIntakeRestAction.h"

@implementation GoodIntakeRestAction

- (NSString *)skillName {
    
    return @"睡眠少";
}

- (NSString *)systemPropertyKey {
    
    return @"goodIntakeRestLevel";
}

@end

@implementation UpgradeGoodIntakeRestAction

- (NSInteger)survivalPointConsumption {
    
    return 1000;
}

- (NSString *)systemPropertyKey {
    
    return @"goodIntakeRestLevel";
}

@end
