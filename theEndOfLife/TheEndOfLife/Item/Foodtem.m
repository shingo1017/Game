//
//  Foodtem.m
//  destroy
//
//  Created by 尹楠 on 16/9/28.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "Foodtem.h"

@implementation FoodItem

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self setProperty:@1 forKey:@"consumption" save:NO];
        
        [self initializationNonSave];
    }
    return self;
}

- (void)initializationNonSave {
    
    [self setProperty:@"补充能量" forKey:@"use" save:NO];
    [self setProperty:@NO forKey:@"canSet" save:NO];
    
    id consumeOneAction = [Utility objectForClassName:@"FoodItemConsumeOneAction"];
    [self setProperty:@[consumeOneAction] forKey:@"actions" save:NO];
}

@end

@implementation FoodItemConsumeOneAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self setProperty:@([[Item currentItem] intProperty:@"consumption"]) forKey:@"consumption" save:NO];
    }
    return self;
}

- (NSString *)name {
    
    return [NSString stringWithFormat:@"吃一%@", [[Item currentItem] property:@"unit"]];
}

- (void)actionResult {
    
    [[Game sharedGame] dateProperty:@"time" plus:Minutes(1)];
    [Cutscene excuteCommandText:@"#c|补充了能量。"];
    
    [[Person me] intProperty:@"energy" plus:[[Item currentItem] intProperty:@"energy"]];
    [[Person me] intProperty:@"thirsty" plus:[[Item currentItem] intProperty:@"thirsty"]];
    
    [super actionResult];
}

@end

@implementation LuncheonMeatCanItem

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self setProperty:@([Utility getRandomNumber:1 to:6]) forKey:@"durability"];
    }
    return self;
}

- (void)initializationNonSave {
    
    [self setProperty:@"午餐肉罐头" forKey:@"name" save:NO];
    [self setProperty:@6 forKey:@"maxDurability" save:NO];
    [self setProperty:@"片" forKey:@"unit" save:NO];
    [self setProperty:@0.25 forKey:@"burden" save:NO];
    [self setProperty:@100 forKey:@"energy" save:NO];
    [self setProperty:@-10 forKey:@"thirsty" save:NO];
    [self setProperty:@"ItemTextDurabilityGroup" forKey:@"infoGroupClassName" save:NO];
    
    [super initializationNonSave];
}

@end

@implementation JerkyItem

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self setProperty:@([Utility getRandomNumber:1 to:5]) forKey:@"durability"];
    }
    return self;
}

- (void)initializationNonSave {
    
    [self setProperty:@"肉干" forKey:@"name" save:NO];
    [self setProperty:@5 forKey:@"maxDurability" save:NO];
    [self setProperty:@"条" forKey:@"unit" save:NO];
    [self setProperty:@0.15 forKey:@"burden" save:NO];
    [self setProperty:@200 forKey:@"energy" save:NO];
    [self setProperty:@-50 forKey:@"thirsty" save:NO];
    [self setProperty:@"ItemTextDurabilityGroup" forKey:@"infoGroupClassName" save:NO];
    
    [super initializationNonSave];
}

@end

@implementation HardTackItem

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self setProperty:@([Utility getRandomNumber:1 to:4]) forKey:@"durability"];
    }
    return self;
}

- (void)initializationNonSave {
    
    [self setProperty:@"压缩饼干" forKey:@"name" save:NO];
    [self setProperty:@4 forKey:@"maxDurability" save:NO];
    [self setProperty:@"块" forKey:@"unit" save:NO];
    [self setProperty:@0.1 forKey:@"burden" save:NO];
    [self setProperty:@150 forKey:@"energy" save:NO];
    [self setProperty:@-40 forKey:@"thirsty" save:NO];
    [self setProperty:@"ItemTextDurabilityGroup" forKey:@"infoGroupClassName" save:NO];
    
    [super initializationNonSave];
}

@end

@implementation HoneyItem

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self setProperty:@([Utility getRandomNumber:20 to:200]) forKey:@"durability"];
    }
    return self;
}

- (void)initializationNonSave {
    
    [self setProperty:@"蜂蜜" forKey:@"name" save:NO];
    [self setProperty:@200 forKey:@"maxDurability" save:NO];
    [self setProperty:@"口" forKey:@"unit" save:NO];
    [self setProperty:@0.2 forKey:@"burden" save:NO];
    [self setProperty:@20 forKey:@"consumption" save:NO];
    [self setProperty:@120 forKey:@"energy" save:NO];
    [self setProperty:@"ItemBarDurabilityGroup" forKey:@"infoGroupClassName" save:NO];
    
    [super initializationNonSave];
}

@end

@implementation PeanutButterItem

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self setProperty:@([Utility getRandomNumber:10 to:200]) forKey:@"durability"];
    }
    return self;
}

- (void)initializationNonSave {
    
    [self setProperty:@"花生酱" forKey:@"name" save:NO];
    [self setProperty:@200 forKey:@"maxDurability" save:NO];
    [self setProperty:@"口" forKey:@"unit" save:NO];
    [self setProperty:@0.2 forKey:@"burden" save:NO];
    [self setProperty:@10 forKey:@"consumption" save:NO];
    [self setProperty:@80 forKey:@"energy" save:NO];
    [self setProperty:@-30 forKey:@"thirsty" save:NO];
    [self setProperty:@"ItemBarDurabilityGroup" forKey:@"infoGroupClassName" save:NO];
    
    [super initializationNonSave];
}

@end
