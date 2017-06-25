//
//  StoreInfoGroup.m
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "StoreInfoGroup.h"
#import "DisplayProperty.h"

@implementation StoreInfoGroup

- (id)init {
    
    self = [super init];
    if (self) {
        
        self.name = @"物 品";
        self.belongToClassNames = @[@"StoreView"];
        self.displayProperties = [Utility getSubClassInstancesWithFatherClassName:@"DisplayProperty" belongToClassName:NSStringFromClass([self class])];
        self.sort = 0;
    }
    return self;
}

@end
