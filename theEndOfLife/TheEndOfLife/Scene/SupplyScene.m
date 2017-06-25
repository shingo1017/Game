//
//  SupplyScene.m
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "SupplyScene.h"

@implementation SupplyScene

- (id)init {
    
    self = [super init];
    if (self) {
    
        [self setProperty:@"生存训练营" forKey:@"sceneImageName" save:NO];
        [self setProperty:[Utility getSubClassInstancesWithFatherClassName:@"Group" belongToClassName:NSStringFromClass([self class])] forKey:@"groups" save:NO];
        
        id supplyWaterAction = [Utility objectForClassName:@"SupplyWaterAction"];
        id buySupplyWaterAction = [Utility objectForClassName:@"BuySupplyWaterAction"];
        [supplyWaterAction setValue:@[buySupplyWaterAction] forKey:@"actions"];
        
        id supplyFoodAction = [Utility objectForClassName:@"SupplyFoodAction"];
        id buySupplyFoodAction = [Utility objectForClassName:@"BuySupplyFoodAction"];
        [supplyFoodAction setValue:@[buySupplyFoodAction] forKey:@"actions"];
        
        [self setProperty:@[supplyFoodAction, supplyWaterAction] forKey:@"actions" save:NO];
    }
    return self;
}

@end
