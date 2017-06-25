//
//  SurvivalSkillScene.m
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "SurvivalSkillScene.h"

@implementation SurvivalSkillScene

- (id)init {
    
    self = [super init];
    if (self) {
    
        [self setProperty:@"生存训练营" forKey:@"sceneImageName" save:NO];
        [self setProperty:[Utility getSubClassInstancesWithFatherClassName:@"Group" belongToClassName:NSStringFromClass([self class])] forKey:@"groups" save:NO];
        
        id littleEatAction = [Utility objectForClassName:@"LittleEatAction"];
        id upgradeLittleEatAction = [Utility objectForClassName:@"UpgradeLittleEatAction"];
        [littleEatAction setValue:@[upgradeLittleEatAction] forKey:@"actions"];
        
        id goodIntakeNutrientAction = [Utility objectForClassName:@"GoodIntakeNutrientAction"];
        id upgradeGoodIntakeNutrientAction = [Utility objectForClassName:@"UpgradeGoodIntakeNutrientAction"];
        [goodIntakeNutrientAction setValue:@[upgradeGoodIntakeNutrientAction] forKey:@"actions"];
        
        id littleDrinkAction = [Utility objectForClassName:@"LittleDrinkAction"];
        id upgradeLittleDrinkAction = [Utility objectForClassName:@"UpgradeLittleDrinkAction"];
        [littleDrinkAction setValue:@[upgradeLittleDrinkAction] forKey:@"actions"];
        
        id goodIntakeDurabilityAction = [Utility objectForClassName:@"GoodIntakeDurabilityAction"];
        id upgradeGoodIntakeDurabilityAction = [Utility objectForClassName:@"UpgradeGoodIntakeDurabilityAction"];
        [goodIntakeDurabilityAction setValue:@[upgradeGoodIntakeDurabilityAction] forKey:@"actions"];
        
        id goodIntakeRestAction = [Utility objectForClassName:@"GoodIntakeRestAction"];
        id upgradeGoodIntakeRestAction = [Utility objectForClassName:@"UpgradeGoodIntakeRestAction"];
        [goodIntakeRestAction setValue:@[upgradeGoodIntakeRestAction] forKey:@"actions"];
        
        [self setProperty:@[littleEatAction, goodIntakeNutrientAction, littleDrinkAction, goodIntakeDurabilityAction, goodIntakeRestAction] forKey:@"actions" save:NO];
    }
    return self;
}

@end
