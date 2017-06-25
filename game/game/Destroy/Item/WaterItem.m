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
        [self setProperty:@500 forKey:@"durability"];
        
        [self initializationNonSave];
    }
    return self;
}

- (void)initializationNonSave {
    
    [self setProperty:@"矿泉水" forKey:@"name" save:NO];
    [self setProperty:@"水是非常宝贵的资源，平时也要合理的计划饮用。" forKey:@"description" save:NO];
    [self setProperty:@"补充水分" forKey:@"use" save:NO];
    [self setProperty:@500 forKey:@"maxDurability" save:NO];
    
    id useOneAction = [Utility objectForClassName:@"WaterItemConsumeOneAction"];
    [self setProperty:@[useOneAction] forKey:@"actions" save:NO];
}

@end

@implementation WaterItemConsumeOneAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        self.name = @"喝一口";
        [self setProperty:@20 forKey:@"consumption" save:NO];
    }
    return self;
}

- (void)actionResult {
    
    [[Game sharedGame] dateProperty:@"time" plus:Minutes(1)];
    [Cutscene excuteCommandText:@"#c|补充了水分。"];
    [[Person me] intProperty:@"thirsty" plus:60];
    
    [super actionResult];
}

@end
