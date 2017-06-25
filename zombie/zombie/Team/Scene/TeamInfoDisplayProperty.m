//
//  TeamInfoDisplayProperty.m
//  zombie
//
//  Created by 尹楠 on 17/5/17.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "TeamInfoDisplayProperty.h"

@implementation TeamFoodDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"TeamInfoGroup"];
        self.captionKey = k_food;
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Team.food";
        self.sort = 70;
    }
    return self;
}

- (BOOL)isAvailable {
    
    return YES;
}

- (NSString *)displayText {
    
    return Int2String([[Team myTeam] intProperty:k_food]);
}

@end

@implementation TeamWaterDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"TeamInfoGroup"];
        self.captionKey = k_water;
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Team.water";
        self.sort = 80;
    }
    return self;
}

- (BOOL)isAvailable {
    
    return YES;
}

- (NSString *)displayText {
    
    return Int2String([[Team myTeam] intProperty:k_water]);
}

@end

@implementation TeamMedicineDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"TeamInfoGroup"];
        self.captionKey = k_medicine;
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Team.medicine";
        self.sort = 90;
    }
    return self;
}

- (BOOL)isAvailable {
    
    return YES;
}

- (NSString *)displayText {
    
    return Int2String([[Team myTeam] intProperty:k_medicine]);
}

@end

@implementation TeamMaterialDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"TeamInfoGroup"];
        self.captionKey = k_material;
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Team.material";
        self.sort = 100;
    }
    return self;
}

- (BOOL)isAvailable {
    
    return YES;
}

- (NSString *)displayText {
    
    return Int2String([[Team myTeam] intProperty:k_material]);
}

@end

@implementation TeamAmmunitionDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"TeamInfoGroup"];
        self.captionKey = k_ammunition;
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Team.ammunition";
        self.sort = 110;
    }
    return self;
}

- (BOOL)isAvailable {
    
    return YES;
}

- (NSString *)displayText {
    
    return Int2String([[Team myTeam] intProperty:k_ammunition]);
}

@end
