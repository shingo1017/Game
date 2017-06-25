//
//  TimeGroup.m
//  destroy
//
//  Created by 尹楠 on 16/9/23.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "TimeGroup.h"

@implementation TimeGroup

- (id)init {
    
    self = [super init];
    if (self) {
        
        self.name = @"时 间";
        self.belongToClassNames = @[@"LoungeScene", @"ToolhouseScene", @"InfirmaryScene"];
        self.displayProperties = [Utility getSubClassInstancesWithFatherClassName:@"DisplayProperty" belongToClassName:NSStringFromClass([self class])];
        self.sort = 0;
    }
    return self;
}

@end
