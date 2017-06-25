//
//  FiefInfoGroup.m
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "FiefInfoGroup.h"
#import "DisplayProperty.h"

@implementation FiefInfoGroup

- (id)init {
    
    self = [super init];
    if (self) {
        
        self.name = @"领地信息";
        self.belongToClassNames = @[@"FiefScene"];
        self.displayProperties = [Utility getSubClassInstancesWithFatherClassName:@"DisplayProperty" belongToClassName:NSStringFromClass([self class])];
    }
    return self;
}

@end
