//
//  BuildingAction.h
//  zombie
//
//  Created by 尹楠 on 17/5/20.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "Action.h"
#import "SettlementAction.h"

@interface BuildingAction : Action

@end

@interface BuildingCheckAction : SettlementAction

@end

@interface BuildingSuppressAction : SettlementAction

@end

@interface BuildingOccupyAction : SettlementAction

@end
