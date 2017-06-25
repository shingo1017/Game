//
//  ChocolateItem.m
//  destroy
//
//  Created by 尹楠 on 16/9/28.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "ChocolateItem.h"
#import "NSString+Additions.h"

@implementation ChocolateItem

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self setProperty:[[NSUUID UUID] UUIDString] forKey:@"key" save:NO];
        [self setProperty:@9 forKey:@"durability"];
        
        [self initializationNonSave];
    }
    return self;
}

- (void)initializationNonSave {
    
    [self setProperty:@"巧克力" forKey:@"name" save:NO];
    [self setProperty:@"高热量的甜食，可以迅速补充身体所需的热量和糖分，是有效的能量补给品，要节省着吃。" forKey:@"description" save:NO];
    [self setProperty:@"补充能量" forKey:@"use" save:NO];
    [self setProperty:@9 forKey:@"maxDurability" save:NO];
    [self setProperty:@"块" forKey:@"unit" save:NO];
    
    id useOneAction = [Utility objectForClassName:@"ChocolateItemConsumeOneAction"];
    [self setProperty:@[useOneAction] forKey:@"actions" save:NO];
}

@end

@implementation ChocolateItemConsumeOneAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"吃一块" forKey:k_name save:NO];
        [self setProperty:@1 forKey:@"consumption" save:NO];
    }
    return self;
}

- (void)actionResult {

    [[Game sharedGame] dateProperty:@"time" plus:Minutes(1)];
    [Cutscene excuteCommandText:@"#c|补充了能量。"];
    [[Person me] intProperty:@"energy" plus:150];
    
    [super actionResult];
}

@end
