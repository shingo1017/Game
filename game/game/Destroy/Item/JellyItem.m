//
//  JellyItem.m
//  destroy
//
//  Created by 尹楠 on 16/9/28.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "JellyItem.h"

@implementation JellyItem

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self setProperty:[[NSUUID UUID] UUIDString] forKey:@"key" save:NO];
        [self setProperty:@12 forKey:@"durability"];
        
        [self initializationNonSave];
    }
    return self;
}

- (void)initializationNonSave {
    
    [self setProperty:@"果冻" forKey:@"name" save:NO];
    [self setProperty:@"胶装甜食，可以补充少许能量。" forKey:@"description" save:NO];
    [self setProperty:@"补充能量" forKey:@"use" save:NO];
    [self setProperty:@12 forKey:@"maxDurability" save:NO];
    [self setProperty:@"个" forKey:@"unit" save:NO];
    
    id useOneAction = [Utility objectForClassName:@"JellyItemConsumeOneAction"];
    [self setProperty:@[useOneAction] forKey:@"actions" save:NO];
}

@end

@implementation JellyItemConsumeOneAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        self.name = @"吃一个";
        [self setProperty:@1 forKey:@"consumption" save:NO];
    }
    return self;
}

- (void)actionResult {
    
    [[Game sharedGame] dateProperty:@"time" plus:Minutes(1)];
    [Cutscene excuteCommandText:@"#c|补充了能量。"];
    [[Person me] intProperty:@"energy" plus:20];
    
    [super actionResult];
}

@end
