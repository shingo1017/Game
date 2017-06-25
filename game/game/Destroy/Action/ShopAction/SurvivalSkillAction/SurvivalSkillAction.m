//
//  SurvivalSkillAction.m
//  destroy
//
//  Created by 尹楠 on 16/9/24.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "SurvivalSkillAction.h"

@implementation SurvivalSkillAction

- (NSString *)name {
    
    return [NSString stringWithFormat:@"%@ Level %li", self.skillName, [[System system] intProperty:[self systemPropertyKey]]];
}

- (NSString *)skillName {
    
    return nil;
}

- (NSString *)systemPropertyKey {
    
    return nil;
}

@end
