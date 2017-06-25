//
//  PhysiologyGroup.m
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "PhysiologyGroup.h"
#import "DisplayProperty.h"

@implementation PhysiologyGroup

- (id)init {
    
    self = [super init];
    if (self) {
        
        self.name = @"生理";
        self.belongToClassNames = @[@"BasementScene"];
        self.displayProperties = [Utility getSubClassInstancesWithFatherClassName:@"DisplayProperty" belongToClassName:NSStringFromClass([self class])];
        self.sort = 20;
    }
    return self;
}

@end
