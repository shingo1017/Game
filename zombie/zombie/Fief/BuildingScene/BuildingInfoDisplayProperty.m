//
//  BuildingInfoDisplayProperty.m
//  zombie
//
//  Created by 尹楠 on 17/5/17.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "BuildingInfoDisplayProperty.h"

@implementation BuildingAreaDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"FiefInfoGroup", @"BuildingInfoGroup"];
        self.captionKey = k_buildingArea;
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Place.buildingArea";
        self.sort = 20;
    }
    return self;
}

- (BOOL)isAvailable {
    
    return YES;
}

- (NSString *)displayText {
    
    Place *place = self.displayObject;
    if ([place boolProperty:k_known])
        return Int2String([place intProperty:k_buildingArea]);
    else
        return @"未知";
}

@end

@implementation DefenceDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"FiefInfoGroup", @"BuildingInfoGroup"];
        self.captionKey = k_defence;
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Place.defence";
        self.sort = 30;
    }
    return self;
}

- (NSString *)displayText {
    
    Place *place = self.displayObject;
    if ([place boolProperty:k_known])
        return Int2String([place intProperty:k_defence]);
    else
        return @"未知";
}

@end

@implementation ZombieInsideDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"FiefInfoGroup", @"BuildingInfoGroup"];
        self.captionKey = k_zombieInside;
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Place.zombieInside";
        self.sort = 40;
    }
    return self;
}

- (BOOL)isAvailable {
    
    NSInteger value = [[PlaceScene sharedScene].place intProperty:k_zombieInside];
    
    return value > 0;
}

- (NSString *)displayText {
    
    Place *place = self.displayObject;
    if ([place boolProperty:k_known])
        return Int2String([place intProperty:k_zombieInside]);
    else
        return @"未知";
}

@end
