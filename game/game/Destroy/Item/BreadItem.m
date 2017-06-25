//
//  BreadItem.m
//  destroy
//
//  Created by 尹楠 on 16/9/28.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "BreadItem.h"

@implementation BreadItem

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self setProperty:[[NSUUID UUID] UUIDString] forKey:@"key" save:NO];
        [self setProperty:@8 forKey:@"durability"];
        
        [self initializationNonSave];
    }
    return self;
}

- (void)initializationNonSave {
    
    [self setProperty:@"面包" forKey:@"name" save:NO];
    [self setProperty:@"膨化食品，平时是垃圾食品，但是关键时期是不错的补充能量的食物，而且非常易于保存。" forKey:@"description" save:NO];
    [self setProperty:@"补充能量" forKey:@"use" save:NO];
    [self setProperty:@8 forKey:@"maxDurability" save:NO];
    [self setProperty:@"片" forKey:@"unit" save:NO];
    
    id useOneAction = [Utility objectForClassName:@"BreadItemConsumeOneAction"];
    [self setProperty:@[useOneAction] forKey:@"actions" save:NO];
}

@end

@implementation BreadItemConsumeOneAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        self.name = @"吃一片";
        [self setProperty:@1 forKey:@"consumption" save:NO];
    }
    return self;
}

- (void)actionResult {
    
    [[Game sharedGame] dateProperty:@"time" plus:Minutes(1)];
    [Cutscene excuteCommandText:@"#c|补充了能量。"];
    [[Person me] intProperty:@"energy" plus:100];
    
    [super actionResult];
}

@end
