//
//  HuntingScene.m
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "HuntingScene.h"

@implementation HuntingScene

- (id)init {
    
    self = [super init];
    if (self) {
    
        [self setProperty:[Utility getSubClassInstancesWithFatherClassName:@"Group" belongToClassName:@"HuntingScene"] forKey:@"groups" save:NO];
        
        //不可变Action组
        id myAction = [Utility objectForClassName:@"MyAction"];
        id myInfoAction = [Utility objectForClassName:@"MyInfoAction"];
        id myBagAction = [Utility objectForClassName:@"MyBagAction"];
        [myAction setValue:@[myInfoAction, myBagAction] forKey:@"actions"];
        
        id myRestAction = [Utility objectForClassName:@"MyRestAction"];
        id huntingStartAction = [Utility objectForClassName:@"HuntingStartAction"];
        id huntingLeaveAction = [Utility objectForClassName:@"HuntingLeaveAction"];
        [self setProperty:@[myAction, myRestAction, huntingStartAction, huntingLeaveAction] forKey:@"actions" save:NO];
    }
    return self;
}

@end

@implementation ResidenceRoomScene

- (id)init {
    
    self = [super init];
    if (self) {
        
        [self setProperty:@"民宅" forKey:@"name"];
        [self setProperty:@"民宅内部" forKey:@"sceneImageName" save:NO];
        [self setProperty:@"ResidenceScene" forKey:@"outsideSceneClassName"];
        [self setProperty:@1 forKey:@"survivorEncounterRating" save:NO];
        [self setProperty:@1 forKey:@"stolenRating" save:NO];
        [self setProperty:@[
                            [ItemDrop itemDropWithClassName:@"LuncheonMeatCanItem" dropRating:100],
                            [ItemDrop itemDropWithClassName:@"JerkyItem" dropRating:100],
                            [ItemDrop itemDropWithClassName:@"HardTackItem" dropRating:30],
                            [ItemDrop itemDropWithClassName:@"HoneyItem" dropRating:50],
                            [ItemDrop itemDropWithClassName:@"PeanutButterItem" dropRating:50],
                            [ItemDrop itemDropWithClassName:@"WaterItem" dropRating:100],
                            [ItemDrop itemDropWithClassName:@"AntiphlogisticItem" dropRating:500],
                            [ItemDrop itemDropWithClassName:@"PlasticBag" dropRating:100],
                            [ItemDrop itemDropWithClassName:@"RucksackBag" dropRating:300],
                            ] forKey:@"itemDrops" save:NO];
        
    }
    return self;
}

@end

