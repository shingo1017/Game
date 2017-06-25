//
//  TimeGoingOn.m
//  zombie
//
//  Created by 尹楠 on 17/6/2.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "TimeGoingOn.h"
#import "SettlementAction.h"

static TimeGoingOn *_sharedInstance;

@interface TimeGoingOn ()



@end

@implementation TimeGoingOn

+ (TimeGoingOn *)sharedInstance {
    
    if (!_sharedInstance) {
        
        _sharedInstance = [TimeGoingOn new];
        _sharedInstance.resultTexts = [NSMutableArray new];
        _sharedInstance.settlementData = [NSMutableDictionary new];
    }
    
    return _sharedInstance;
}

- (void)Settlement {
    
    //TODO:现在是一个领地，以后会扩展多个。
    for (Place *place in @[[PlaceScene sharedScene].place]) {
        
        //声明结算队列
        NSMutableDictionary *settlementDictionaries = [NSMutableDictionary new];
        NSMutableArray *freeSurvivors = [NSMutableArray new];
        for (Survivor *survivor in place.survivors) {
            
            NSString *excutiveClassName = [survivor property:k_excutiveClassName];
            if (excutiveClassName.length > 0) {
                
                //该幸存者有任务，加入结算队列
                if (!settlementDictionaries[excutiveClassName]) {
                    
                    //新增
                    settlementDictionaries[excutiveClassName] = [NSMutableDictionary new];
                    settlementDictionaries[excutiveClassName][@"place"] = place;
                    settlementDictionaries[excutiveClassName][k_survivors] = [NSMutableArray new];
                }
                
                [settlementDictionaries[excutiveClassName][k_survivors] addObject:survivor];
            }
            else {
                
                //该幸存者没有任务，加入空闲结算队列
                [freeSurvivors addObject:survivor];
            }
        }
        
        //遍历结算队列
        for (NSString *excutiveClassName in settlementDictionaries.allKeys) {
            
            NSDictionary *settlementDictionary = settlementDictionaries[excutiveClassName];
            
            SettlementAction *action = [Utility objectForClassName:excutiveClassName];
            action.excutivePlace = settlementDictionary[@"place"];
            action.excutiveSurvivors = settlementDictionary[k_survivors];
            action.settlementData = self.settlementData[excutiveClassName];
            
            //进行任务结算
            [action actionSettlementResult];
            
            //结算后，清空幸存者的任务
            for (Survivor *survivor in action.excutiveSurvivors) {
                
                [survivor setProperty:@"" forKey:k_excutiveClassName];
                [survivor setProperty:@"空闲" forKey:k_status];
            }
        }
        
        //饥饿结算
        NSInteger numberOfEaters = [self settlementWithSurvivors:place.survivors hungryOffset:-25];
        [place intProperty:k_food plus:-numberOfEaters];
        
        //口渴结算
        NSInteger numberOfDrinkers = [self settlementWithSurvivors:place.survivors thirstyOffset:-25];
        [place intProperty:k_water plus:-numberOfDrinkers];
        
        //进行空闲结算
        [self settlementWithSurvivors:freeSurvivors staminaOffset:50];
    }
    
    [[Game sharedGame] timePassWorkHours];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_SCENE_NOTIFICATION object:nil];
}

#pragma mark 精力结算

- (void)settlementWithSurvivors:(NSArray *)survivors staminaOffset:(NSInteger)staminaOffset {
    
    for (Survivor *survivor in survivors) {
        
        [survivor intProperty:k_stamina plus:staminaOffset];
    }
}

#pragma mark 饥饿结算

- (NSInteger)settlementWithSurvivors:(NSArray *)survivors hungryOffset:(NSInteger)hungryOffset {
    
    NSInteger numberOfEaters = 0;
    
    for (Survivor *survivor in survivors) {
        
        NSInteger hungry = [survivor intProperty:k_hungry];
        NSInteger newHungry = hungry + hungryOffset;
        if (newHungry < 30) {
            
            //进食，食物消耗结算
            newHungry += 50;
            numberOfEaters += 1;
        }
        [survivor setProperty:@(newHungry) forKey:k_hungry];
    }
    
    return numberOfEaters;
}

#pragma mark 口渴结算

- (NSInteger)settlementWithSurvivors:(NSArray *)survivors thirstyOffset:(NSInteger)thirstyOffset {
    
    NSInteger numberOfDrinkers = 0;
    
    for (Survivor *survivor in survivors) {
        
        NSInteger thirsty = [survivor intProperty:k_thirsty];
        NSInteger newThirsty = thirsty + thirstyOffset;
        if (newThirsty < 30) {
            
            //进水，饮用水消耗结算
            newThirsty += 50;
            numberOfDrinkers += 1;
        }
        [survivor setProperty:@(newThirsty) forKey:k_thirsty];
    }
    
    return numberOfDrinkers;
}

@end
