//
//  SettlementAction.m
//  zombie
//
//  Created by 尹楠 on 17/6/4.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "SettlementAction.h"

@implementation SettlementAction

- (void)workSettingWithSurvivors:(NSArray *)survivors {
    
    for (Survivor *survivor in survivors) {
        
        [survivor setProperty:self.name forKey:k_status];
        [survivor setProperty:NSStringFromClass(self.class) forKey:k_excutiveClassName];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_SCHEDULE_NOTIFICATION object:nil];
}

- (NSArray *)excutiveSurvivorNames {
    
    NSMutableString *survivorNames = [NSMutableString new];
    for (Survivor *survivor in self.excutiveSurvivors) {
        
        [survivorNames appendFormat:@"%@，", survivor.name];
    }
    [survivorNames replaceCharactersInRange:NSMakeRange(survivorNames.length - 1, 1) withString:@""];
    
    return (NSArray *)survivorNames;
}

- (CGFloat)abilityNumberForKey:(NSString *)key {
    
    NSInteger totalAbilityNumber = 0;
    for (Survivor *survivor in self.excutiveSurvivors) {
        
        NSInteger abilityNumber = [survivor intProperty:key];
        //幸存者精力过低的能力惩罚
        if ([survivor intProperty:k_stamina] < 20)
            abilityNumber = abilityNumber * 0.2;
        else if ([survivor intProperty:k_stamina] < 40)
            abilityNumber = abilityNumber * 0.5;
        
        totalAbilityNumber += abilityNumber;
    }
    return totalAbilityNumber;
}

- (void)actionSettlementResult {
    
    
}

@end
