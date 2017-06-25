//
//  RucksackBag.m
//  theEndOfLife
//
//  Created by 尹楠 on 16/10/16.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "RucksackBag.h"

@implementation RucksackBag

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self setProperty:[[NSUUID UUID] UUIDString] forKey:@"key" save:NO];
        
        [self initializationNonSave];
    }
    return self;
}

- (void)initializationNonSave {
    
    [self setProperty:@"帆布背包" forKey:@"name" save:NO];
    [self setProperty:@"个" forKey:@"unit" save:NO];
    [self setProperty:@([Utility getRandomNumber:8 to:10]) forKey:@"maxBurden" save:NO];
    [self setProperty:@NO forKey:@"canSet" save:NO];
    [self setProperty:@"ItemTextDurabilityGroup" forKey:@"infoGroupClassName" save:NO];
    
    //id useOneAction = [Utility objectForClassName:@"CanItemConsumeOneAction"];
    //[self setProperty:@[useOneAction] forKey:@"actions" save:NO];
}

@end
