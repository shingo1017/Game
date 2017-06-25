//
//  InformationAction.m
//  zombie
//
//  Created by 尹楠 on 17/5/25.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "InformationAction.h"
#import "SurvivorsPickerScene.h"
#import "SurvivorInfoScene.h"

@implementation InformationAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"检  视" forKey:k_name save:NO];
        self.belongToClassNames = @[@"PlaceScene", @"BuildingScene", @"FiefScene"];
        self.sort = 30;
    }
    return self;
}

- (BOOL)isAvailable {
    
    return YES;
}

@end

@implementation InformationSurvivorsAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"幸 存 者" forKey:k_name save:NO];
        self.belongToClassNames = @[@"InformationAction"];
        self.sort = 10;
    }
    return self;
}

- (BOOL)isAvailable {
    
    return YES;
}

- (void)actionResult {
    
    NSArray *titleKeys = @[k_name, k_gender];
    
    SurvivorsPickerScene *survivorPickerScene = [SurvivorsPickerScene new];
    [survivorPickerScene showWithTitleKeys:titleKeys completion:^(NSArray<Survivor *> *selectedSurvivors) {
        
        Survivor *survivor = [selectedSurvivors firstObject];
        if (survivor)
            [[SurvivorInfoScene new] showWithSurvivorId:survivor.id];
    }];
}

@end
