//
//  MyInfoGroup.m
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "MyInfoGroup.h"
#import "DisplayProperty.h"

@implementation MyInfoGroup

- (id)init {
    
    self = [super init];
    if (self) {
        
        self.name = @"信 息";
        self.belongToClassNames = @[@"PersonView"];
        self.displayProperties = [Utility getSubClassInstancesWithFatherClassName:@"DisplayProperty" belongToClassName:NSStringFromClass([self class])];
        self.sort = 0;
    }
    return self;
}

@end

@implementation MyStatusGroup

- (id)init {
    
    self = [super init];
    if (self) {
        
        self.name = @"状 态";
        self.belongToClassNames = @[@"PersonView"];
        self.displayProperties = [Utility getSubClassInstancesWithFatherClassName:@"DisplayProperty" belongToClassName:NSStringFromClass([self class])];
        self.sort = 10;
    }
    return self;
}

@end
