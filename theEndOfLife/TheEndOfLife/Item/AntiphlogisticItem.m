//
//  AntiphlogisticItem.m
//  destroy
//
//  Created by 尹楠 on 16/9/28.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "AntiphlogisticItem.h"

@implementation AntiphlogisticItem

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self setProperty:[[NSUUID UUID] UUIDString] forKey:@"key" save:NO];
        [self setProperty:@([Utility getRandomNumber:1 to:12]) forKey:@"durability"];
        
        [self initializationNonSave];
    }
    return self;
}

- (void)initializationNonSave {
    
    [self setProperty:@"消炎药" forKey:@"name" save:NO];
    [self setProperty:@"治疗呕吐、腹泻" forKey:@"use" save:NO];
    [self setProperty:@12 forKey:@"maxDurability" save:NO];
    [self setProperty:@"片" forKey:@"unit" save:NO];
    [self setProperty:@"ItemTextDurabilityGroup" forKey:@"infoGroupClassName" save:NO];
    
    id useOneAction = [Utility objectForClassName:@"AntiphlogisticItemConsumeOneAction"];
    [self setProperty:@[useOneAction] forKey:@"actions" save:NO];
}

@end

@implementation AntiphlogisticItemConsumeOneAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"吃一片" forKey:k_name save:NO];
        [self setProperty:@1 forKey:@"consumption" save:NO];
    }
    return self;
}

- (void)actionResult {
    
    [[Game sharedGame] dateProperty:@"time" plus:Minutes(1)];
    [Cutscene excuteCommandText:@"#c|吃了药，感觉好多了。"];
    
    [super actionResult];
}

@end
