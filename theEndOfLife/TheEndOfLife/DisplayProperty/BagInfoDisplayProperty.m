//
//  BagInfoDisplayProperty.m
//  destroy
//
//  Created by 尹楠 on 16/9/23.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "BagInfoDisplayProperty.h"

@implementation BagNameDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"BagInfoGroup"];
        self.caption = @"背 包";
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Bag.name";
        self.sort = 0;
    }
    return self;
}

- (NSString *)displayText {
    
    return [[Bag sharedBag] property:@"name"];
}

@end

@implementation BagBurdenDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"BagInfoGroup"];
        self.caption = @"负 重";
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Bag.burden";
        self.sort = 10;
    }
    return self;
}

- (NSString *)displayText {
    
    return [NSString stringWithFormat:@"%.1f kg / %li kg", [Bag sharedBag].burden, [[Bag sharedBag] intProperty:@"maxBurden"]];
}

@end
