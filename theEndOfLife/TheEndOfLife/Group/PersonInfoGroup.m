//
//  PersonInfoGroup.m
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "PersonInfoGroup.h"
#import "DisplayProperty.h"

@implementation PersonInfoGroup

- (id)init {
    
    self = [super init];
    if (self) {
        
        self.name = @"信 息";
        self.belongToClassNames = @[@"PersonInfoScene"];
        self.displayProperties = [Utility getSubClassInstancesWithFatherClassName:@"DisplayProperty" belongToClassName:NSStringFromClass([self class])];
        self.sort = 0;
    }
    return self;
}

@end
