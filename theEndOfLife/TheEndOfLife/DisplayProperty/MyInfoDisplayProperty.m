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
        
        self.belongToClassNames = @[@"MyStatusOnMainScreenGroup"];
        self.caption = @"能 量";
        self.type = DisplayPropertyTypeBar;
        self.keyPath = @"Person.hungry";
        self.notificationKeyPaths = @[@"Person.info"];
        self.sort = 0;
    }
    return self;
}

- (BOOL)isAvailable {
    
    if ([[Person me] intProperty:@"hungry"] > 0 &&
        [[Game sharedGame] boolProperty:@"TutorialGoStory"])
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
        
        self.belongToClassNames = @[@"MyStatusOnMainScreenGroup"];
        self.caption = @"脂 肪";
        self.type = DisplayPropertyTypeBar;
        self.keyPath = @"Person.energy";
        self.notificationKeyPaths = @[@"Person.info"];
        self.sort = 0;
    }
    return self;
}

- (BOOL)isAvailable {
    
    if ([[Person me] intProperty:@"hungry"] <= 0 &&
        [[Person me] intProperty:@"energy"] > 0 &&
        [[Game sharedGame] boolProperty:@"TutorialGoStory"])
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
        
        self.belongToClassNames = @[@"MyStatusOnMainScreenGroup"];
        self.caption = @"生 命";
        self.type = DisplayPropertyTypeBar;
        self.keyPath = @"Person.life";
        self.notificationKeyPaths = @[@"Person.info"];
        self.sort = 0;
    }
    return self;
}

- (BOOL)isAvailable {
    
    if ([[Person me] intProperty:@"hungry"] <= 0 &&
        [[Person me] intProperty:@"energy"] <= 0 &&
        [[Game sharedGame] boolProperty:@"TutorialGoStory"])
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
        
        self.belongToClassNames = @[@"MyStatusOnMainScreenGroup"];
        self.caption = @"水 分";
        self.type = DisplayPropertyTypeBar;
        self.keyPath = @"Person.thirsty";
        self.notificationKeyPaths = @[@"Person.info"];
        self.sort = 10;
    }
    return self;
}

- (BOOL)isAvailable {
    
    if ([[Person me] intProperty:@"thirsty"] > 0 &&
        [[Game sharedGame] boolProperty:@"TutorialGoStory"])
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
        
        self.belongToClassNames = @[@"MyStatusOnMainScreenGroup"];
        self.caption = @"脱 水";
        self.type = DisplayPropertyTypeBar;
        self.keyPath = @"Person.dehydration";
        self.notificationKeyPaths = @[@"Person.info"];
        self.sort = 10;
    }
    return self;
}

- (BOOL)isAvailable {
    
    if ([[Person me] intProperty:@"thirsty"] <= 0 &&
        [[Game sharedGame] boolProperty:@"TutorialGoStory"])
        return YES;
    else
        return NO;
}

- (NSInteger)displayNumber {
    
    return [[Person me] intProperty:@"dehydration"];
}

@end

@implementation MySoberDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"MyStatusOnMainScreenGroup"];
        self.caption = @"清 醒";
        self.type = DisplayPropertyTypeBar;
        self.keyPath = @"Person.sober";
        self.notificationKeyPaths = @[@"Person.info"];
        self.sort = 20;
    }
    return self;
}

- (BOOL)isAvailable {
    
    if ([[Game sharedGame] boolProperty:@"TutorialGoStory"])
        return YES;
    else
        return NO;
}

- (NSInteger)displayNumber {
    
    return [[Person me] intProperty:@"sober"];
}

@end

@implementation MyStrengthDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"MyStatusGroup"];
        self.caption = @"健 康";
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Person.health";
        self.notificationKeyPaths = @[@"Person.info"];
        self.sort = 0;
    }
    return self;
}

- (NSString *)displayText {
    
    NSString *displayText;
    NSInteger health = [[Person me] intProperty:@"health"];
    if (health > 900)
        displayText = @"非常好";
    else if (health > 700)
        displayText = @"良好";
    else if (health > 500)
        displayText = @"营养缺乏";
    else if (health > 300)
        displayText = @"虚弱";
    else if (health > 200)
        displayText = @"慢性病";
    else if (health > 100)
        displayText = @"衰竭";
    else if (health > 50)
        displayText = @"末期";
    else if (health > 0)
        displayText = @"濒死";
    return displayText;
}

@end

