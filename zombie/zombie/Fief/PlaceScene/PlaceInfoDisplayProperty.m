//
//  PlaceInfoDisplayProperty.m
//  zombie
//
//  Created by 尹楠 on 17/5/17.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "PlaceInfoDisplayProperty.h"

@implementation LandAreaDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"PlaceInfoGroup", @"FiefInfoGroup", @"BuildingInfoGroup"];
        self.captionKey = k_landArea;
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Place.landArea";
        self.sort = 10;
    }
    return self;
}

- (BOOL)isAvailable {
    
    return YES;
}

- (NSString *)displayText {
    
//    Place *place = self.displayObject;
//    if ([place boolProperty:k_known])
//        return Int2String([place intProperty:k_landArea]);
//    else
        return @"未知";
}

@end

@implementation NattinessDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"PlaceInfoGroup", @"FiefInfoGroup", @"BuildingInfoGroup"];
        self.captionKey = k_nattiness;
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Place.nattiness";
        self.sort = 120;
    }
    return self;
}

- (BOOL)isAvailable {
    
    return [[PlaceScene sharedScene].place boolProperty:k_searched];
}

- (NSString *)displayText {
    
    return Int2String([[PlaceScene sharedScene].place intProperty:k_nattiness]);
}

@end

@implementation SanitationDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"PlaceInfoGroup", @"FiefInfoGroup", @"BuildingInfoGroup"];
        self.captionKey = k_sanitation;
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Place.sanitation";
        self.sort = 130;
    }
    return self;
}

- (BOOL)isAvailable {
    
    return [[PlaceScene sharedScene].place boolProperty:k_searched];
}

- (NSString *)displayText {
    
    return Int2String([[PlaceScene sharedScene].place intProperty:k_sanitation]);
}

@end

@implementation ThreatDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"PlaceInfoGroup", @"FiefInfoGroup", @"BuildingInfoGroup"];
        self.captionKey = k_zombieOutside;
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Place.zombieOutside";
        self.sort = 50;
    }
    return self;
}

- (BOOL)isAvailable {
    
    NSInteger value = [[PlaceScene sharedScene].place intProperty:k_zombieOutside];
    
    return value > 0;
}

- (NSString *)displayText {
    
//    Place *place = self.displayObject;
//    if ([place boolProperty:k_known])
//        return Int2String([place intProperty:k_zombieOutside]);
//    else
        return @"未知";
}

@end

@implementation FoodDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"PlaceInfoGroup", @"FiefInfoGroup", @"BuildingInfoGroup"];
        self.captionKey = k_food;
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Place.food";
        self.sort = 70;
    }
    return self;
}

- (BOOL)isAvailable {
    
    return [[PlaceScene sharedScene].place boolProperty:k_searched];
}

- (NSString *)displayText {
    
    return Int2String([[PlaceScene sharedScene].place intProperty:k_food]);
}

@end

@implementation WaterDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"PlaceInfoGroup", @"FiefInfoGroup", @"BuildingInfoGroup"];
        self.captionKey = k_water;
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Place.water";
        self.sort = 80;
    }
    return self;
}

- (BOOL)isAvailable {
    
    return [[PlaceScene sharedScene].place boolProperty:k_searched];
}

- (NSString *)displayText {
    
    return Int2String([[PlaceScene sharedScene].place intProperty:k_water]);
}

@end

@implementation MedicineDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"PlaceInfoGroup", @"FiefInfoGroup", @"BuildingInfoGroup"];
        self.captionKey = k_medicine;
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Place.medicine";
        self.sort = 90;
    }
    return self;
}

- (BOOL)isAvailable {
    
    return [[PlaceScene sharedScene].place boolProperty:k_searched];
}

- (NSString *)displayText {
    
    return Int2String([[PlaceScene sharedScene].place intProperty:k_medicine]);
}

@end

@implementation MaterialDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"PlaceInfoGroup", @"FiefInfoGroup", @"BuildingInfoGroup"];
        self.captionKey = k_material;
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Place.material";
        self.sort = 100;
    }
    return self;
}

- (BOOL)isAvailable {
    
    return [[PlaceScene sharedScene].place boolProperty:k_searched];
}

- (NSString *)displayText {
    
    return Int2String([[PlaceScene sharedScene].place intProperty:k_material]);
}

@end

@implementation AmmunitionDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"PlaceInfoGroup", @"FiefInfoGroup", @"BuildingInfoGroup"];
        self.captionKey = k_ammunition;
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Place.ammunition";
        self.sort = 110;
    }
    return self;
}

- (BOOL)isAvailable {
    
    return [[PlaceScene sharedScene].place boolProperty:k_searched];
}

- (NSString *)displayText {
    
    return Int2String([[PlaceScene sharedScene].place intProperty:k_ammunition]);
}

@end
