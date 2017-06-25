//
//  OutsideAction.m
//  zombie
//
//  Created by 尹楠 on 17/6/4.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "OutsideAction.h"
#import "SurvivorsPickerScene.h"
#import "PlacePickerScene.h"
#import "TimeGoingOn.h"
#import "MoveConfirmationScene.h"
#import "ResourceReorganizationScene.h"

@implementation OutsideAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"外  出" forKey:k_name save:NO];
        self.belongToClassNames = @[@"PlaceScene", @"BuildingScene", @"FiefScene"];
        self.sort = 10;
    }
    return self;
}

- (BOOL)isAvailable {
    
    return YES;
}

@end

@implementation OutsideSuppressAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"清理丧尸" forKey:k_name save:NO];
        self.belongToClassNames = @[@"OutsideAction"];
        self.sort = 20;
    }
    return self;
}

- (BOOL)isAvailable {
    
    NSInteger value = [[PlaceScene sharedScene].place intProperty:k_zombieOutside];
    
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
    NSInteger zombieOutside = [self.excutivePlace intProperty:k_zombieOutside];
    CGFloat penaltyRatio = 1 - (zombieOutside * 0.6 - 10) * 0.01;
    
    //计算公式
    CGFloat abilityNumber = [self abilityNumberForKey:k_combat];
    NSInteger offset = abilityNumber * 0.2 * random(7, 13) * 0.1 * penaltyRatio;
    
    //边界限制
    NSInteger newZombieOutside = zombieOutside;
    if (zombieOutside - offset < 0) {
        
        offset = zombieOutside;
        newZombieOutside = 0;
    }
    else
        newZombieOutside = zombieOutside - offset;
    [self.excutivePlace setProperty:@(newZombieOutside) forKey:k_zombieOutside];
    
    //消耗精力
    [[TimeGoingOn sharedInstance] settlementWithSurvivors:self.excutiveSurvivors staminaOffset:-50];
    
    //报告结算结果
    NSString *resultText = [NSString stringWithFormat:@"%@的附近丧尸数量减少了%li。%li -> %li（ %@ ）", self.excutivePlace.name, offset, zombieOutside, newZombieOutside, self.excutiveSurvivorNames];
    [[TimeGoingOn sharedInstance].resultTexts addObject:resultText];
}

@end

@implementation OutsideRunAwayAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"逃  离" forKey:k_name save:NO];
        self.belongToClassNames = @[@"OutsideAction"];
        self.sort = 10;
    }
    return self;
}

- (BOOL)isAvailable {
    
    NSInteger value = [[PlaceScene sharedScene].place intProperty:k_zombieInside];
    
    return [[PlaceScene sharedScene].place boolProperty:k_isBuilding] && value > 0;
}

- (void)actionResult {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认" message:@"逃离时无法自由选择方向，有可能从建筑的任何出口逃出，是否要逃离？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"逃离" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        NSMutableArray *exits = [NSMutableArray arrayWithArray:@[@(1),@(2),@(3),@(4)]];
        Place *exitPlace = [self placeAtExitArray:exits];
        [[Map sharedMap] moveToPlace:exitPlace];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [[MainView sharedView] presentViewController:alert animated:YES completion:nil];
}

- (Place *)placeAtExitArray:(NSMutableArray *)exitArray {
    
    NSInteger exit = random(1, exitArray.count);
    
    Place *exitPlace = nil;
    if (exit == 1) {
        
        //北出口
        exitPlace = (Place *)[PlaceScene sharedScene].place.northPlace;
        [exitArray removeObject:@(1)];
    }
    else if (exit == 2) {
        
        //西出口
        exitPlace = (Place *)[PlaceScene sharedScene].place.westPlace;
        [exitArray removeObject:@(2)];
    }
    else if (exit == 3) {
        
        //南出口
        exitPlace = (Place *)[PlaceScene sharedScene].place.southPlace;
        [exitArray removeObject:@(3)];
    }
    else if (exit == 4) {
        
        //东出口
        exitPlace = (Place *)[PlaceScene sharedScene].place.eastPlace;
        [exitArray removeObject:@(4)];
    }
    
    if (!exitPlace)
        exitPlace = [self placeAtExitArray:exitArray];
    
    return exitPlace;
}

@end

@implementation OutsideMoveAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"迁  移" forKey:k_name save:NO];
        self.belongToClassNames = @[@"OutsideAction"];
        self.sort = 10;
    }
    return self;
}

- (BOOL)isAvailable {
    
    NSInteger value = [[PlaceScene sharedScene].place intProperty:k_zombieInside];
    
    return value == 0;
}

- (void)actionResult {
    
    if ([PlaceScene sharedScene].place.numberOfWorkingSurvivors > 0) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:@"有些幸存者正准备执行任务，不能进行迁移" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:nil]];
        [[MainView sharedView] presentViewController:alert animated:YES completion:nil];
    }
    else {
        
        //选择迁移地点
        PlacePickerScene *placePickerScene = [PlacePickerScene new];
        [placePickerScene showForDistance:6 fromPlaceId:[PlaceScene sharedScene].place.id title:@"选择要迁移的地点" completion:^(Place *moveToPlace) {
            
            //负重不足，进行资源调配
            if ([PlaceScene sharedScene].place.resourceBurden > [PlaceScene sharedScene].place.survivorsBurden) {
                
                ResourceReorganizationScene *resourceReorganizationScene = [ResourceReorganizationScene new];
                [resourceReorganizationScene showForMoveWithCompletion:^(BOOL isConfirmed, NSDictionary *takeResourceDictionary) {
                    
                    if (isConfirmed) {
                        
                        [resourceReorganizationScene hide];
                        
                        //迁移确认
                        MoveConfirmationScene *moveConfirmationScene = [MoveConfirmationScene new];
                        [moveConfirmationScene showWithTargetPlaceId:moveToPlace.id completion:^(BOOL isConfirmed) {
                            
                            if (isConfirmed) {
                                
                                [placePickerScene hide];
                                [moveConfirmationScene hide];
                                [self workSettingWithSurvivors:[PlaceScene sharedScene].place.survivors];
                                [TimeGoingOn sharedInstance].settlementData[NSStringFromClass(self.class)] = @{ @"moveToPlace" : moveToPlace, @"takeResource" : takeResourceDictionary };
                            }
                        }];
                    }
                }];
            }
            else {
                
                //迁移确认
                MoveConfirmationScene *moveConfirmationScene = [MoveConfirmationScene new];
                [moveConfirmationScene showWithTargetPlaceId:moveToPlace.id completion:^(BOOL isConfirmed) {
                    
                    if (isConfirmed) {
                        
                        [placePickerScene hide];
                        [moveConfirmationScene hide];
                        [self workSettingWithSurvivors:[PlaceScene sharedScene].place.survivors];
                        [TimeGoingOn sharedInstance].settlementData[NSStringFromClass(self.class)] = @{ @"moveToPlace" : moveToPlace };
                    }
                }];
            }
        }];
    }
}

+ (NSInteger)foodConsumption {
    
    return [PlaceScene sharedScene].place.survivors.count;
}

+ (NSInteger)waterConsumption {
    
    return [PlaceScene sharedScene].place.survivors.count;
}

- (void)actionSettlementResult {
    
    Place *moveToPlace = self.settlementData[@"moveToPlace"];
    NSDictionary *takeResourceDictionary = self.settlementData[@"takeResource"];
    
    NSInteger food = 0;
    NSInteger water = 0;
    NSInteger material = 0;
    NSInteger medicine = 0;
    NSInteger ammunition = 0;
    
    if (takeResourceDictionary) {
        
        //搬走部分资源
        food = [takeResourceDictionary[k_food] integerValue];
        water = [takeResourceDictionary[k_water] integerValue];
        material = [takeResourceDictionary[k_material] integerValue];
        medicine = [takeResourceDictionary[k_medicine] integerValue];
        ammunition = [takeResourceDictionary[k_ammunition] integerValue];
    }
    else {
        
        //搬走全部资源
        food = [[PlaceScene sharedScene].place intProperty:k_food];
        water = [[PlaceScene sharedScene].place intProperty:k_water];
        material = [[PlaceScene sharedScene].place intProperty:k_material];
        medicine = [[PlaceScene sharedScene].place intProperty:k_medicine];
        ammunition = [[PlaceScene sharedScene].place intProperty:k_ammunition];
    }
    
    //扣除出发地点的资源
    [[PlaceScene sharedScene].place intProperty:k_food plus:-food];
    [[PlaceScene sharedScene].place intProperty:k_water plus:-water];
    [[PlaceScene sharedScene].place intProperty:k_material plus:-material];
    [[PlaceScene sharedScene].place intProperty:k_medicine plus:-medicine];
    [[PlaceScene sharedScene].place intProperty:k_ammunition plus:-ammunition];
    
    //将资源分配到团队
    [[Team myTeam] setProperty:@(food) forKey:k_food];
    [[Team myTeam] setProperty:@(water) forKey:k_water];
    [[Team myTeam] setProperty:@(material) forKey:k_material];
    [[Team myTeam] setProperty:@(medicine) forKey:k_medicine];
    [[Team myTeam] setProperty:@(ammunition) forKey:k_ammunition];
    
    //消耗精力
    [[TimeGoingOn sharedInstance] settlementWithSurvivors:self.excutiveSurvivors staminaOffset:-50];
    
    [[Map sharedMap] moveToPlace:moveToPlace];
    
    //报告结算结果
    NSString *resultText = [NSString stringWithFormat:@"迁移到了%@", moveToPlace.name];
    [[TimeGoingOn sharedInstance].resultTexts addObject:resultText];
}

@end

@implementation OutsideDiscoverAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"探  索" forKey:k_name save:NO];
        self.belongToClassNames = @[@"OutsideAction"];
        self.sort = 30;
    }
    return self;
}

- (BOOL)isAvailable {
    
    return YES;
}

- (void)actionResult {
    
    //选择探索的地点
    PlacePickerScene *placePickerScene = [PlacePickerScene new];
    [placePickerScene showForDistance:3 fromPlaceId:[PlaceScene sharedScene].place.id title:@"选择要探索的地点" completion:^(Place *place) {
        
        //选择执行探索的幸存者
        NSArray *titleKeys = @[k_name, k_survival, k_health, k_stamina, k_hungry, k_thirsty, k_status];
        
        SurvivorsPickerScene *survivorPickerScene = [SurvivorsPickerScene new];
        [survivorPickerScene showWithPickNumberOfSurvivors:3 titleKeys:titleKeys placeConsumables:nil survivorConsumables:@{k_stamina : @25} completion:^(NSArray<Survivor *> *selectedSurvivors) {
            
            [self workSettingWithSurvivors:selectedSurvivors];
            [TimeGoingOn sharedInstance].settlementData[NSStringFromClass(self.class)] = place;
            
            [placePickerScene hide];
        }];
    }];
}

- (void)actionSettlementResult {
    
    Place *place = self.settlementData;
    
    //消耗精力
    [[TimeGoingOn sharedInstance] settlementWithSurvivors:self.excutiveSurvivors staminaOffset:-25];
    
    [[Map sharedMap] discoverPlaceAtCoordinate:place.coordinate];
    
    //报告结算结果
    NSString *resultText = [NSString stringWithFormat:@"探索了%@（%@）", place.name, self.excutiveSurvivorNames];
    [[TimeGoingOn sharedInstance].resultTexts addObject:resultText];
}

@end
