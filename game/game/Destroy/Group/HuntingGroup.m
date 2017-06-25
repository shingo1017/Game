//
//  HuntingGroup.m
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "HuntingGroup.h"
#import "DisplayProperty.h"

@implementation HuntingAppearenceGroup

- (id)init {
    
    self = [super init];
    if (self) {
        
        self.name = @"基本素质";
        self.belongToClassNames = @[@"HuntingScene"];
        self.displayProperties = [Utility getSubClassInstancesWithFatherClassName:@"DisplayProperty" belongToClassName:NSStringFromClass([self class])];
        self.sort = 0;
    }
    return self;
}

@end

@implementation HuntingDressGroup

- (id)init {
    
    self = [super init];
    if (self) {
        
        self.name = @"穿着打扮";
        self.belongToClassNames = @[@"HuntingScene"];
        self.displayProperties = [Utility getSubClassInstancesWithFatherClassName:@"DisplayProperty" belongToClassName:NSStringFromClass([self class])];
        self.sort = 10;
    }
    return self;
}

@end
