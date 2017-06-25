//
//  BuildingInfoGroup.m
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "BuildingInfoGroup.h"
#import "DisplayProperty.h"

@implementation BuildingInfoGroup

- (id)init {
    
    self = [super init];
    if (self) {
        
        self.name = @"建筑信息";
        self.belongToClassNames = @[@"BuildingScene"];
        self.displayProperties = [Utility getSubClassInstancesWithFatherClassName:@"DisplayProperty" belongToClassName:NSStringFromClass([self class])];
    }
    return self;
}

@end
