//
//  PassWayScene.m
//  theEndOfLife
//
//  Created by 尹楠 on 16/10/14.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "PassWayScene.h"

@implementation PassWayScene

- (id)init {
    
    self = [super init];
    if (self) {
        
        id myAction = [Utility objectForClassName:@"MyAction"];
        id myInfoAction = [Utility objectForClassName:@"MyInfoAction"];
        id myBagAction = [Utility objectForClassName:@"MyBagAction"];
        [myAction setValue:@[myInfoAction, myBagAction] forKey:@"actions"];

        id backToChurchAction = [Utility objectForClassName:@"BackToChurchAction"];
        [self setProperty:@[myAction, backToChurchAction] forKey:@"actions" save:NO];
    }
    return self;
}

@end

@implementation BridgeStreetScene

- (id)init {
    
    self = [super init];
    if (self) {
        
        [self setProperty:@"天桥街" forKey:@"name"];
        [self setProperty:@"天桥街" forKey:@"sceneImageName" save:NO];
        [self setProperty:@5 forKey:@"survivorEncounterRating" save:NO];
        [self setProperty:@20 forKey:@"stolenRating" save:NO];
    }
    return self;
}

@end
