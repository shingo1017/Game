//
//  BuildingScene.m
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "BuildingScene.h"

@implementation BuildingScene

+ (NSArray *)buildingScenes {
    
    NSMutableArray *buildingScenes = [[NSMutableArray alloc] init];
    for (NSString *key in [self sceneDictionaries].allKeys) {
        
        Scene *scene = [[self sceneDictionaries] objectForKey:key];
        if ([scene isKindOfClass:[self class]])
            [buildingScenes addObject:scene];
    }
    return buildingScenes;
}

- (id)init {
    
    self = [super init];
    if (self) {
    
         [self setProperty:[Utility getSubClassInstancesWithFatherClassName:@"Group" belongToClassName:NSStringFromClass([self class])] forKey:@"groups" save:NO];
        
        id myAction = [Utility objectForClassName:@"MyAction"];
        id myInfoAction = [Utility objectForClassName:@"MyInfoAction"];
        id myBagAction = [Utility objectForClassName:@"MyBagAction"];
        [myAction setValue:@[myInfoAction, myBagAction] forKey:@"actions"];
        
        id buildingEntryAction = [Utility objectForClassName:@"BuildingEntryAction"];
        id buildingLeaveAction = [Utility objectForClassName:@"BuildingLeaveAction"];
        [self setProperty:@[myAction, buildingEntryAction, buildingLeaveAction] forKey:@"actions" save:NO];
    }
    return self;
}

@end

@implementation ResidenceScene

- (id)init {
    
    self = [super init];
    if (self) {
        
        [self setProperty:@"住宅区" forKey:@"name"];
        [self setProperty:@"民宅" forKey:@"sceneImageName" save:NO];
        [self setProperty:@2 forKey:@"survivorEncounterRating" save:NO];
        [self setProperty:@5 forKey:@"stolenRating" save:NO];
    }
    return self;
}

@end

