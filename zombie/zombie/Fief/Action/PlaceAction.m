//
//  FiefAction.m
//  zombie
//
//  Created by 尹楠 on 17/6/4.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "FiefAction.h"
#import "SurvivorsPickerScene.h"
#import "TimeGoingOn.h"

@implementation FiefAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"领  地" forKey:k_name save:NO];
        self.belongToClassNames = @[@"PlaceScene"];
        self.sort = 10;
    }
    return self;
}

- (BOOL)isAvailable {
    
    return [[PlaceScene sharedScene].place boolProperty:k_isFief] && [[PlaceScene sharedScene].place boolProperty:k_isLead];
}

@end

@implementation FiefFastenAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"加  固" forKey:k_name save:NO];
        self.belongToClassNames = @[@"FiefAction"];
        self.sort = 10;
    }
    return self;
}

- (BOOL)isAvailable {
    
    return [[PlaceScene sharedScene].place boolProperty:k_isLead];
}

- (BOOL)isEnabled {
    
    return [[PlaceScene sharedScene].place numberOfSurvivorsWorkingOnExcutiveClassName:NSStringFromClass(self.class)] == 0;
}

- (void)actionResult {
    
    NSArray *titleKeys = @[k_name, k_strength, k_health, k_stamina, k_hungry, k_thirsty, k_status];
    
    SurvivorsPickerScene *survivorPickerScene = [SurvivorsPickerScene new];
    [survivorPickerScene showWithPickNumberOfSurvivors:5 titleKeys:titleKeys placeConsumables:@{k_material : @10} survivorConsumables:@{k_stamina : @40}];
    [survivorPickerScene setDidSelectedSurvivorsBlock:^(NSArray *selectedSurvivors) {
        
        NSInteger material = [[PlaceScene sharedScene].place intProperty:k_material];
        NSInteger materialConsumable = selectedSurvivors.count * 10;
        [[PlaceScene sharedScene].place setProperty:@(material - materialConsumable) forKey:k_material];
        
        [self workSettingWithSurvivors:selectedSurvivors];
    }];
}

- (void)actionSettlementResult {
    
    //惩罚系数
    CGFloat penaltyRatio = 0.2;
    
    //计算公式
    NSInteger abilityNumber = [self abilityNumberForKey:k_strength];
    NSInteger defence = [self.excutivePlace intProperty:k_defence];
    NSInteger offset = abilityNumber * penaltyRatio * random(9, 11);
    
    //边界限制
    NSInteger buildingArea = [self.excutivePlace intProperty:k_buildingArea];
    NSInteger newDefence = defence;
    NSInteger maxDefence = buildingArea * 2;
    if (defence + offset > maxDefence) {
        
        offset = maxDefence - defence;
        newDefence = maxDefence;
    }
    else
        newDefence = defence + offset;
    [self.excutivePlace setProperty:@(newDefence) forKey:k_defence];
    
    //消耗精力
    [[TimeGoingOn sharedInstance] settlementWithSurvivors:self.excutiveSurvivors staminaOffset:-40];
    
    //报告结算结果
    NSString *resultText = [NSString stringWithFormat:@"%@的防御增加了%li。%li -> %li（ %@ ）", self.excutivePlace.name, offset, defence, newDefence, self.excutiveSurvivorNames];
    [[TimeGoingOn sharedInstance].resultTexts addObject:resultText];
}

@end

@implementation FiefCleanAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"清  洁" forKey:k_name save:NO];
        self.belongToClassNames = @[@"FiefAction"];
        self.sort = 20;
    }
    return self;
}

- (BOOL)isAvailable {
    
    return [[PlaceScene sharedScene].place boolProperty:k_isLead];
}

- (BOOL)isEnabled {
    
    return [[PlaceScene sharedScene].place numberOfSurvivorsWorkingOnExcutiveClassName:NSStringFromClass(self.class)] == 0;
}

- (void)actionResult {
    
    NSArray *titleKeys = @[k_name, k_logistics, k_health, k_stamina, k_hungry, k_thirsty, k_status];
    
    SurvivorsPickerScene *survivorPickerScene = [SurvivorsPickerScene new];
    [survivorPickerScene showWithPickNumberOfSurvivors:3 titleKeys:titleKeys placeConsumables:nil survivorConsumables:@{k_stamina : @30}];
    [survivorPickerScene setDidSelectedSurvivorsBlock:^(NSArray *selectedSurvivors) {
        
        [self workSettingWithSurvivors:selectedSurvivors];
    }];
}

- (void)actionSettlementResult {
    
    //惩罚系数
    CGFloat penaltyRatio = 0.8;
    
    //计算公式
    NSInteger abilityNumber = [self abilityNumberForKey:k_logistics];
    NSInteger buildingArea = [self.excutivePlace intProperty:k_buildingArea];
    NSInteger sanitation = [self.excutivePlace intProperty:k_sanitation];
    NSInteger offset = abilityNumber * penaltyRatio / buildingArea * random(90, 110);
    
    //边界限制
    NSInteger newSanitation = sanitation;
    if (sanitation + offset > 100) {
        
        offset = 100 - sanitation;
        newSanitation = 100;
    }
    else
        newSanitation = sanitation + offset;
    [self.excutivePlace setProperty:@(newSanitation) forKey:k_sanitation];
    
    //消耗精力
    [[TimeGoingOn sharedInstance] settlementWithSurvivors:self.excutiveSurvivors staminaOffset:-30];
    
    //报告结算结果
    NSString *resultText = [NSString stringWithFormat:@"%@的卫生增加了%li。%li -> %li（ %@ ）", self.excutivePlace.name, offset, sanitation, newSanitation, self.excutiveSurvivorNames];
    [[TimeGoingOn sharedInstance].resultTexts addObject:resultText];
}

@end

@implementation FiefPackAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"整  理" forKey:k_name save:NO];
        self.belongToClassNames = @[@"FiefAction"];
        self.sort = 30;
    }
    return self;
}

- (BOOL)isAvailable {
    
    return [[PlaceScene sharedScene].place boolProperty:k_isLead];
}

- (BOOL)isEnabled {
    
    return [[PlaceScene sharedScene].place numberOfSurvivorsWorkingOnExcutiveClassName:NSStringFromClass(self.class)] == 0;
}

- (void)actionResult {
    
    NSArray *titleKeys = @[k_name, k_logistics, k_health, k_stamina, k_hungry, k_thirsty, k_status];
    
    SurvivorsPickerScene *survivorPickerScene = [SurvivorsPickerScene new];
    [survivorPickerScene showWithPickNumberOfSurvivors:3 titleKeys:titleKeys placeConsumables:nil survivorConsumables:@{k_stamina : @30}];
    [survivorPickerScene setDidSelectedSurvivorsBlock:^(NSArray *selectedSurvivors) {
        
        [self workSettingWithSurvivors:selectedSurvivors];
    }];
}

- (void)actionSettlementResult {
    
    //惩罚系数
    CGFloat penaltyRatio = 0.8;
    
    //计算公式
    NSInteger abilityNumber = [self abilityNumberForKey:k_logistics];
    NSInteger buildingArea = [self.excutivePlace intProperty:k_buildingArea];
    NSInteger nattiness = [self.excutivePlace intProperty:k_nattiness];
    NSInteger offset = abilityNumber * penaltyRatio / buildingArea * random(90, 110);
    
    //边界限制
    NSInteger newNattiness = nattiness;
    if (nattiness + offset > 100) {
        
        offset = 100 - nattiness;
        newNattiness = 100;
    }
    else
        newNattiness = nattiness + offset;
    [self.excutivePlace setProperty:@(newNattiness) forKey:k_nattiness];
    
    //消耗精力
    [[TimeGoingOn sharedInstance] settlementWithSurvivors:self.excutiveSurvivors staminaOffset:-30];
    
    //报告结算结果
    NSString *resultText = [NSString stringWithFormat:@"%@的整洁增加了%li。%li -> %li（ %@ ）", self.excutivePlace.name, offset, nattiness, newNattiness, self.excutiveSurvivorNames];
    [[TimeGoingOn sharedInstance].resultTexts addObject:resultText];
}

@end
