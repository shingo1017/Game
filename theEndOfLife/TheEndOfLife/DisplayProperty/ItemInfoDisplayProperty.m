//
//  ItemInfoDisplayProperty.m
//  destroy
//
//  Created by 尹楠 on 16/9/23.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "ItemInfoDisplayProperty.h"

@implementation ItemNameDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"ItemTextDurabilityGroup", @"ItemBarDurabilityGroup"];
        self.caption = @"名 称";
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Item.name";
        self.sort = 0;
    }
    return self;
}

- (NSString *)displayText {
    
    return [[Item currentItem] property:@"name"];
}

@end

/*@implementation ItemDescriptionDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"ItemInfoGroup"];
        self.caption = @"描 述";
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Item.description";
        self.sort = 10;
    }
    return self;
}

- (NSString *)displayText {
    
    return [[Item currentItem] property:@"description"];
}

@end*/

@implementation ItemUseDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"ItemTextDurabilityGroup", @"ItemBarDurabilityGroup"];
        self.caption = @"用 途";
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Item.use";
        self.sort = 20;
    }
    return self;
}

- (NSString *)displayText {
    
    return [[Item currentItem] property:@"use"];
}

@end

@implementation ItemDurabilityTextDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"ItemTextDurabilityGroup"];
        self.caption = @"剩 余";
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Item.durability";
        self.sort = 40;
    }
    return self;
}

- (BOOL)isAvailable {
    
    if ([[Item currentItem] intProperty:@"durability"] > 0)
        return YES;
    else
        return NO;
}

- (NSString *)displayText {
    
    return [NSString stringWithFormat:@"%li%@", [[Item currentItem] intProperty:@"durability"], [[Item currentItem] property:@"unit"]];
}

@end

@implementation ItemDurabilityBarDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"ItemBarDurabilityGroup"];
        self.caption = @"剩 余";
        self.type = DisplayPropertyTypeBar;
        self.keyPath = @"Item.durability";
        self.sort = 40;
    }
    return self;
}

- (BOOL)isAvailable {
    
    if ([[Item currentItem] intProperty:@"durability"] > 0)
        return YES;
    else
        return NO;
}

- (NSInteger)maxNumber {
        
    return [[Item currentItem] intProperty:@"maxDurability"];
}

- (NSInteger)displayNumber {
    
    return [[Item currentItem] intProperty:@"durability"];
}

@end

@implementation ItemMaxBurdenDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"ItemTextDurabilityGroup"];
        self.caption = @"负 重";
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Item.maxBurden";
        self.sort = 30;
    }
    return self;
}

- (BOOL)isAvailable {
    
    if ([[Item currentItem] intProperty:@"maxBurden"] > 0)
        return YES;
    else
        return NO;
}

- (NSString *)displayText {
    
    return [NSString stringWithFormat:@"%li kg", [[Item currentItem] intProperty:@"maxBurden"]];
}

@end

