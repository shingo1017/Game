//
//  BuildingAction.m
//  zombie
//
//  Created by 尹楠 on 17/5/20.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "BuildingAction.h"
#import "SurvivorsPickerScene.h"
#import "TimeGoingOn.h"

@implementation BuildingAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"建  筑" forKey:k_name save:NO];
        self.belongToClassNames = @[@"BuildingScene"];
        self.sort = 20;
    }
    return self;
}

- (BOOL)isAvailable {
    
    return [[PlaceScene sharedScene].place boolProperty:k_isBuilding];
}

@end

@implementation BuildingCheckAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"搜  索" forKey:k_name save:NO];
        self.belongToClassNames = @[@"BuildingAction"];
        self.sort = 20;
    }
    return self;
}

- (BOOL)isAvailable {
    
    NSInteger value = [[PlaceScene sharedScene].place intProperty:k_zombieInside];
    
    if (value == 0 && ![[PlaceScene sharedScene].place boolProperty:k_searched])
        return YES;
    else
        return NO;
}

- (BOOL)isEnabled {
    
    return [[PlaceScene sharedScene].place numberOfSurvivorsWorkingOnExcutiveClassName:NSStringFromClass(self.class)] == 0;
}

- (void)actionResult {
    
    NSArray *titleKeys = @[k_name, k_logistics, k_health, k_stamina, k_hungry, k_thirsty, k_status];
    
    SurvivorsPickerScene *survivorPickerScene = [SurvivorsPickerScene new];
    [survivorPickerScene showWithPickNumberOfSurvivors:1 titleKeys:titleKeys placeConsumables:nil survivorConsumables:@{k_stamina : @10} completion:^(NSArray<Survivor *> *selectedSurvivors) {
        
        [self workSettingWithSurvivors:selectedSurvivors];
    }];
}

- (void)actionSettlementResult {
    
    [self.excutivePlace setProperty:@(YES) forKey:k_searched];
    
    //消耗精力
    [[TimeGoingOn sharedInstance] settlementWithSurvivors:self.excutiveSurvivors staminaOffset:-10];
    
    NSString *resultText = [NSString stringWithFormat:@"%@被彻底的探索了一下，发现了不少好东西！（ %@ ）", self.excutivePlace.name, self.excutiveSurvivorNames];
    [[TimeGoingOn sharedInstance].resultTexts addObject:resultText];
}

@end

@implementation BuildingSuppressAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"清理丧尸" forKey:k_name save:NO];
        self.belongToClassNames = @[@"BuildingAction"];
        self.sort = 10;
    }
    return self;
}

- (BOOL)isAvailable {
    
    NSInteger value = [[PlaceScene sharedScene].place intProperty:k_zombieInside];
    
    return value > 0;
}

- (void)actionResult {
    
    NSArray *titleKeys = @[k_name, k_combat, k_health, k_stamina, k_hungry, k_thirsty, k_status];
    
    SurvivorsPickerScene *survivorPickerScene = [SurvivorsPickerScene new];
    [survivorPickerScene showWithPickNumberOfSurvivors:3 titleKeys:titleKeys placeConsumables:nil survivorConsumables:@{k_stamina : @50} completion:^(NSArray<Survivor *> *selectedSurvivors) {
        
        [self workSettingWithSurvivors:selectedSurvivors];
    }];
}

- (void)actionSettlementResult {
    
    //惩罚系数
    NSInteger zombieInside = [self.excutivePlace intProperty:k_zombieInside];
    CGFloat penaltyRatio = 1 - (zombieInside * 0.5 - 5) * 0.01;
    
    //计算公式
    CGFloat abilityNumber = [self abilityNumberForKey:k_combat];
    NSInteger offset = abilityNumber * 0.2 * random(7, 13) * 0.1 * penaltyRatio;
    
    //边界限制
    NSInteger newZombieInside = zombieInside;
    if (zombieInside - offset < 0) {
        
        offset = zombieInside;
        newZombieInside = 0;
    }
    else
        newZombieInside = zombieInside - offset;
    [self.excutivePlace setProperty:@(newZombieInside) forKey:k_zombieInside];
    
    //消耗精力
    [[TimeGoingOn sharedInstance] settlementWithSurvivors:self.excutiveSurvivors staminaOffset:-50];
    
    //报告结算结果
    NSString *resultText = [NSString stringWithFormat:@"%@的建筑内丧尸数量减少了%li。%li -> %li（ %@ ）", self.excutivePlace.name, offset, zombieInside, newZombieInside, self.excutiveSurvivorNames];
    [[TimeGoingOn sharedInstance].resultTexts addObject:resultText];
}

@end

@implementation BuildingOccupyAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"占  领" forKey:k_name save:NO];
        self.belongToClassNames = @[@"BuildingAction"];
        self.sort = 20;
    }
    return self;
}

- (BOOL)isAvailable {
    
    if ([[PlaceScene sharedScene].place boolProperty:k_isBuilding] &&
        [[PlaceScene sharedScene].place boolProperty:k_searched] &&
        ![[PlaceScene sharedScene].place boolProperty:k_isLead])
        return YES;
    else
        return NO;
}

- (void)actionResult {
    
    [[PlaceScene sharedScene].place setProperty:@(YES) forKey:k_isFief];
    [[PlaceScene sharedScene].place setProperty:@(YES) forKey:k_isLead];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_SCENE_NOTIFICATION object:nil];
}

@end
