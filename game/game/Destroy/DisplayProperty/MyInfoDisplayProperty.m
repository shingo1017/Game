//
//  MyInfoDisplayProperty.m
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "MyInfoDisplayProperty.h"

@implementation MyNameDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"MyInfoGroup"];
        self.caption = @"姓 名";
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Person.name";
        self.sort = 0;
    }
    return self;
}

- (NSString *)displayText {
    
    return [NSString stringWithFormat:@"%@%@", [[Person me] property:@"surname"], [[Person me] property:@"name"]];
}

@end

@implementation MyHeightDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"MyInfoGroup"];
        self.caption = @"身 高";
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Person.height";
        self.sort = 10;
    }
    return self;
}

- (NSString *)displayText {
    
    return [NSString stringWithFormat:@"%li cm", [[Person me] intProperty:@"height"]];
}

@end

@implementation MyWeightDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"MyInfoGroup"];
        self.caption = @"体 重";
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Person.weight";
        self.sort = 20;
    }
    return self;
}

- (NSString *)displayText {
    
    return [NSString stringWithFormat:@"%li kg", [[Person me] intProperty:@"weight"]];
}

@end

@implementation MyHungryDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"MyStatusGroup"];
        self.caption = @"能 量";
        self.type = DisplayPropertyTypeBar;
        self.keyPath = @"Person.hungry";
        self.notificationKeyPaths = @[@"Person.info"];
        self.sort = 0;
    }
    return self;
}

- (BOOL)isAvailable {
    
    if ([[Person me] intProperty:@"hungry"] > 0)
        return YES;
    else
        return NO;
}

- (NSInteger)displayNumber {
    
    return [[Person me] intProperty:@"hungry"];
}

@end

@implementation MyEnergyDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"MyStatusGroup"];
        self.caption = @"脂 肪";
        self.type = DisplayPropertyTypeBar;
        self.keyPath = @"Person.energy";
        self.notificationKeyPaths = @[@"Person.info"];
        self.sort = 0;
    }
    return self;
}

- (BOOL)isAvailable {
    
    if ([[Person me] intProperty:@"hungry"] <= 0 && [[Person me] intProperty:@"energy"] > 0)
        return YES;
    else
        return NO;
}

- (NSInteger)displayNumber {
    
    return [[Person me] intProperty:@"energy"];
}

@end

@implementation MyLifeDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"MyStatusGroup"];
        self.caption = @"生 命";
        self.type = DisplayPropertyTypeBar;
        self.keyPath = @"Person.life";
        self.notificationKeyPaths = @[@"Person.info"];
        self.sort = 0;
    }
    return self;
}

- (BOOL)isAvailable {
    
    if ([[Person me] intProperty:@"hungry"] <= 0 && [[Person me] intProperty:@"energy"] <= 0)
        return YES;
    else
        return NO;
}

- (NSInteger)displayNumber {
    
    return [[Person me] intProperty:@"life"];
}

@end

@implementation MyThirstyDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"MyStatusGroup"];
        self.caption = @"水 分";
        self.type = DisplayPropertyTypeBar;
        self.keyPath = @"Person.thirsty";
        self.notificationKeyPaths = @[@"Person.info"];
        self.sort = 10;
    }
    return self;
}

- (BOOL)isAvailable {
    
    if ([[Person me] intProperty:@"thirsty"] > 0)
        return YES;
    else
        return NO;
}

- (NSInteger)displayNumber {
    
    return [[Person me] intProperty:@"thirsty"];
}

@end

@implementation MyDehydrationDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"MyStatusGroup"];
        self.caption = @"脱 水";
        self.type = DisplayPropertyTypeBar;
        self.keyPath = @"Person.dehydration";
        self.notificationKeyPaths = @[@"Person.info"];
        self.sort = 10;
    }
    return self;
}

- (BOOL)isAvailable {
    
    if ([[Person me] intProperty:@"thirsty"] <= 0)
        return YES;
    else
        return NO;
}

- (NSInteger)displayNumber {
    
    return [[Person me] intProperty:@"dehydration"];
}

@end

@implementation MyStrengthDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"MyStatusGroup"];
        self.caption = @"力 气";
        self.type = DisplayPropertyTypeBar;
        self.keyPath = @"Person.strength";
        self.notificationKeyPaths = @[@"Person.info"];
        self.sort = 20;
    }
    return self;
}

- (NSInteger)displayNumber {
    
    return [[Person me] intProperty:@"strength"];
}

@end

@implementation MyKindDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"MyStatusGroup"];
        self.caption = @"善 良";
        self.type = DisplayPropertyTypeBar;
        self.keyPath = @"Person.kind";
        self.notificationKeyPaths = @[@"Person.info"];
        self.sort = 30;
    }
    return self;
}

- (NSInteger)displayNumber {
    
    return [[Person me] intProperty:@"kind"];
}

@end

@implementation MyReasonDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"MyStatusGroup"];
        self.caption = @"理 性";
        self.type = DisplayPropertyTypeBar;
        self.keyPath = @"Person.reason";
        self.notificationKeyPaths = @[@"Person.info"];
        self.sort = 40;
    }
    return self;
}

- (NSInteger)displayNumber {
    
    return [[Person me] intProperty:@"reason"];
}

@end
