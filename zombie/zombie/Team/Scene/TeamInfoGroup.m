//
//  TeamInfoGroup.m
//  zombie
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "TeamInfoGroup.h"
#import "DisplayProperty.h"

@implementation TeamInfoGroup

- (id)init {
    
    self = [super init];
    if (self) {
        
        self.name = @"团队信息";
        self.belongToClassNames = @[@"Team"];
        self.displayProperties = [Utility getSubClassInstancesWithFatherClassName:@"DisplayProperty" belongToClassName:NSStringFromClass([self class])];
    }
    return self;
}

@end
