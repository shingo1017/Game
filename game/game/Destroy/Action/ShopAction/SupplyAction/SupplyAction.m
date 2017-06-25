//
//  SupplyAction.m
//  destroy
//
//  Created by 尹楠 on 16/9/24.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "SupplyAction.h"

@implementation SupplyAction

- (NSString *)name {
    
    super.name = self.itemName;
    if ([[System system] boolProperty:[self systemPropertyKey]])
        super.name = [self.itemName stringByAppendingString:@" （ 已购买 ）"];
    return super.name;
}

- (NSString *)itemName {
    
    return nil;
}

- (NSString *)systemPropertyKey {
    
    return nil;
}

@end
