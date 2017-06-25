//
//  OutsideAction.h
//  zombie
//
//  Created by 尹楠 on 17/6/4.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "BaseAction.h"
#import "SettlementAction.h"

@interface OutsideAction : Action

@end

@interface OutsideSuppressAction : SettlementAction

@end

@interface OutsideRunAwayAction : SettlementAction

@end

@interface OutsideMoveAction : SettlementAction

+ (NSInteger)foodConsumption;
+ (NSInteger)waterConsumption;

@end

@interface OutsideDiscoverAction : SettlementAction

@end

@interface OutsidePatrolAction : SettlementAction

@end
