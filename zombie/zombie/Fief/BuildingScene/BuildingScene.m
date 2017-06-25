//
//  BuildingScene.m
//  zombie
//
//  Created by 尹楠 on 17/5/16.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "BuildingScene.h"

@interface BuildingScene ()

@end

@implementation BuildingScene

+ (BuildingScene *)sharedScene {
    
    return (BuildingScene *)[super sharedScene];
}

- (void)initGroups {
    
    self.infoGroup = [Utility objectForClassName:@"BuildingInfoGroup"];
}

- (void)initActions {
    
    id buildingAction = [Utility objectForClassName:@"BuildingAction"];
    id buildingCheckAction = [Utility objectForClassName:@"BuildingCheckAction"];
    id buildingSuppressAction = [Utility objectForClassName:@"BuildingSuppressAction"];
    id buildingRunAwayAction = [Utility objectForClassName:@"BuildingRunAwayAction"];
    [buildingAction setValue:@[buildingCheckAction, buildingSuppressAction, buildingRunAwayAction] forKey:@"actions"];
    
    [self setProperty:@[buildingAction] forKey:@"actions" save:NO];
}

@end
