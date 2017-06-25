//
//  PlaceInfoGroup.m
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "PlaceInfoGroup.h"
#import "DisplayProperty.h"

@implementation PlaceInfoGroup

- (id)init {
    
    self = [super init];
    if (self) {
        
        self.name = @"地方信息";
        self.belongToClassNames = @[@"PlaceScene"];
        self.displayProperties = [Utility getSubClassInstancesWithFatherClassName:@"DisplayProperty" belongToClassName:NSStringFromClass([self class])];
    }
    return self;
}

@end
