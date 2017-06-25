//
//  StoreInfoDisplayProperty.m
//  destroy
//
//  Created by 尹楠 on 16/9/23.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "StoreInfoDisplayProperty.h"

@implementation StoreNameDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"StoreInfoGroup"];
        self.caption = @"名 称";
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Store.name";
        self.sort = 0;
    }
    return self;
}

- (NSString *)displayText {
    
    return [[Store sharedStore] property:@"name"];
}

@end
