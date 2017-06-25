//
//  WaterItem.m
//  destroy
//
//  Created by 尹楠 on 16/9/28.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "WaterItem.h"

@implementation WaterItem

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self setProperty:[[NSUUID UUID] UUIDString] forKey:@"key" save:NO];
        [self setProperty:@([Utility getRandomNumber:50 to:600]) forKey:@"durability"];
        
        [self initializationNonSave];
    }
    return self;
}

- (void)initializationNonSave {
    
    [self setProperty:@"矿泉水" forKey:@"name" save:NO];
    [self setProperty:@"水是非常宝贵的资源，平时也要合理的计划饮用。" forKey:@"description" save:NO];
    [self setProperty:@"补充水分" forKey:@"use" save:NO];
    [self setProperty:@600 forKey:@"maxDurability" save:NO];
    [self setProperty:@0.25 forKey:@"burden" save:NO];
    [self setProperty:@50 forKey:@"consumption" save:NO];
    [self setProperty:@"ItemBarDurabilityGroup" forKey:@"infoGroupClassName" save:NO];
    
    id useOneAction = [Utility objectForClassName:@"WaterItemConsumeOneAction"];
    [self setProperty:@[useOneAction] forKey:@"actions" save:NO];
}

@end

@implementation WaterItemConsumeOneAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"喝一口" forKey:k_name save:NO];
    }
    return self;
}

- (void)actionResult {
    
    [[Game sharedGame] dateProperty:@"time" plus:Minutes(1)];
    [Cutscene excuteCommandText:@"#c|补充了水分。"];
    [[Person me] intProperty:@"thirsty" plus:150];
    
    [super actionResult];
}

@end
