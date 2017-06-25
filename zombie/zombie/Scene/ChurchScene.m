//
//  ChurchScene.m
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "ChurchScene.h"
#import "BuildingScene.h"

@implementation ChurchRoomScene

- (id)init {
    
    self = [super init];
    if (self) {
    
        [self setProperty:@"教堂房间" forKey:@"sceneImageName" save:NO];
        [self setProperty:NSStringFromCGPoint(CGPointMake(0, 0)) forKey:@"coordinate" save:NO];
        [self setProperty:@"church" forKey:@"mapName" save:NO];
        [self setProperty:@YES forKey:@"canStore" save:NO];
        [self setProperty:[Utility getSubClassInstancesWithFatherClassName:@"Group" belongToClassName:NSStringFromClass([self class])] forKey:@"groups" save:NO];
        
        NSMutableArray *actions = [[NSMutableArray alloc] init];
        if (![[Game sharedGame] boolProperty:@"TutorialGoAction"]) {
            
            id tutorialPackBagAction = [Utility objectForClassName:@"TutorialPackBagAction"];
            [actions addObject:tutorialPackBagAction];
        }
        id myAction = [Utility objectForClassName:@"MyAction"];
        id myInfoAction = [Utility objectForClassName:@"MyInfoAction"];
        id myBagAction = [Utility objectForClassName:@"MyBagAction"];
        [myAction setValue:@[myInfoAction, myBagAction] forKey:@"actions"];
        
        id storeAction = [Utility objectForClassName:@"StoreAction"];
        id myRestAction = [Utility objectForClassName:@"MyRestAction"];
        id mySleepAction = [Utility objectForClassName:@"MySleepAction"];
        
        id goChurchWorshipAction = [Utility objectForClassName:@"GoChurchWorshipAction"];
        [actions addObjectsFromArray:@[myAction, myRestAction, mySleepAction, storeAction, goChurchWorshipAction]];
        [self setProperty:actions forKey:@"actions" save:NO];
    }
    return self;
}

@end

@implementation ChurchWorshipScene

- (id)init {
    
    self = [super init];
    if (self) {
        
        [self setProperty:@"教堂礼拜间" forKey:@"sceneImageName" save:NO];
        [self setProperty:NSStringFromCGPoint(CGPointMake(0, 1)) forKey:@"coordinate" save:NO];
        [self setProperty:@"church" forKey:@"mapName" save:NO];
        [self setProperty:[Utility getSubClassInstancesWithFatherClassName:@"Group" belongToClassName:NSStringFromClass([self class])] forKey:@"groups" save:NO];
        
        NSMutableArray *actions = [[NSMutableArray alloc] init];
        id myAction = [Utility objectForClassName:@"MyAction"];
        id myInfoAction = [Utility objectForClassName:@"MyInfoAction"];
        id myBagAction = [Utility objectForClassName:@"MyBagAction"];
        [myAction setValue:@[myInfoAction, myBagAction] forKey:@"actions"];
        
        id churchPrayAction = [Utility objectForClassName:@"ChurchPrayAction"];
        id churchPraySafeAction = [Utility objectForClassName:@"ChurchPraySafeAction"];
        id churchPrayLuckAction = [Utility objectForClassName:@"ChurchPrayLuckAction"];
        [churchPrayAction setValue:@[churchPraySafeAction, churchPrayLuckAction] forKey:@"actions"];
        [actions addObjectsFromArray:@[myAction, churchPrayAction]];
        
        if (![[Game sharedGame] boolProperty:@"TutorialGoAction"]) {
            
            id tutorialPrayAction = [Utility objectForClassName:@"TutorialPrayAction"];
            [actions addObject:tutorialPrayAction];
        }
        
        id goChurchRoomAction = [Utility objectForClassName:@"GoChurchRoomAction"];
        id goChurchAction = [Utility objectForClassName:@"GoChurchAction"];
        [actions addObjectsFromArray:@[goChurchRoomAction, goChurchAction]];
        [self setProperty:actions forKey:@"actions" save:NO];
    }
    return self;
}

@end

@implementation ChurchScene

+ (void)reloadActions {
    
    ChurchScene *churchScene = (ChurchScene *)[Scene sceneWithClassName:@"ChurchScene"];
    [churchScene reloadMutableActions];
}

- (id)init {
    
    self = [super init];
    if (self) {
        
        [self setProperty:@"教堂" forKey:@"name"];
        [self setProperty:@"教堂外面" forKey:@"sceneImageName" save:NO];
        [self setProperty:NSStringFromCGPoint(CGPointMake(0, 0)) forKey:@"coordinate" save:NO];
        [self setProperty:@"world" forKey:@"mapName" save:NO];
        [self setProperty:[Utility getSubClassInstancesWithFatherClassName:@"Group" belongToClassName:NSStringFromClass([self class])] forKey:@"groups" save:NO];
        
        //不可变Action组
        NSMutableArray *actions = [[NSMutableArray alloc] init];
        id myAction = [Utility objectForClassName:@"MyAction"];
        id myInfoAction = [Utility objectForClassName:@"MyInfoAction"];
        id myBagAction = [Utility objectForClassName:@"MyBagAction"];
        [myAction setValue:@[myInfoAction, myBagAction] forKey:@"actions"];
        
        id churchCamouflageAction = [Utility objectForClassName:@"ChurchCamouflageAction"];
        id goChurchWorshipAction = [Utility objectForClassName:@"GoChurchWorshipAction"];
        [actions addObjectsFromArray:@[myAction, churchCamouflageAction, goChurchWorshipAction]];
        
        if (![[Game sharedGame] boolProperty:@"TutorialGoAction"]) {
            
            id tutorialGoAction = [Utility objectForClassName:@"TutorialGoAction"];
            [actions addObject:tutorialGoAction];
        }
        [self setProperty:actions forKey:@"actions" save:NO];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMutableActions) name:K_SHOULD_RELOAD_HOME_MUTABLEACTIONS_NOTIFICATION object:nil];
    }
    return self;
}

- (void)reloadMutableActions {
    
    NSMutableArray *mutableActions = [[NSMutableArray alloc] init];
    for (Scene *scene in [BuildingScene buildingScenes]) {
        
        Action *churchWayToSceneAction = [Utility objectForClassName:@"ChurchWayToSceneAction"];
        [churchWayToSceneAction setProperty:scene forKey:@"scene"];
        [mutableActions addObject:churchWayToSceneAction];
    }
    [self setProperty:mutableActions forKey:@"mutableActions" save:NO];
}

@end
