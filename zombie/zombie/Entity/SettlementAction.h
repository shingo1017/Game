//
//  SettlementAction.h
//  zombie
//
//  Created by 尹楠 on 17/6/4.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "Action.h"
#import "Place.h"

@interface SettlementAction : Action

@property (nonatomic, strong) NSMutableArray *excutiveSurvivors;
@property (nonatomic, strong) Place *excutivePlace;

@property (nonatomic, strong) NSString *resultText;
@property (nonatomic, strong, readonly) NSArray *excutiveSurvivorNames;

@property (nonatomic, strong) id settlementData;

- (void)workSettingWithSurvivors:(NSArray *)survivors;
- (CGFloat)abilityNumberForKey:(NSString *)key;
- (void)actionSettlementResult;

@end
