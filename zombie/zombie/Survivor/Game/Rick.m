//
//  Rick.m
//  zombie
//
//  Created by 尹楠 on 17/5/16.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "Rick.h"

@implementation Rick

- (id)init {
    
    self = [super init];
    if (self) {
        
        [self setProperty:@"瑞克" forKey:k_name];
        [self setProperty:@"瑞克" forKey:k_avatar];
        [self setProperty:@1 forKey:k_gender];
        [self setProperty:@34 forKey:k_age];
        
        [self setProperty:@20 forKey:k_prestige];
        
        [self setProperty:@24 forKey:k_courage];
        [self setProperty:@22 forKey:k_strength];
        [self setProperty:@18 forKey:k_agility];
        [self setProperty:@23 forKey:k_strategy];
        [self setProperty:@19 forKey:k_eq];
        [self setProperty:@12 forKey:k_goodness];
        
        [self setProperty:@100 forKey:k_maxHealth];
        [self setProperty:@80 forKey:k_health];
        [self setProperty:@100 forKey:k_stamina];
        [self setProperty:@80 forKey:k_hungry];
        [self setProperty:@80 forKey:k_thirsty];
        
        [self setProperty:@121 forKey:k_combat];
        [self setProperty:@127 forKey:k_shooting];
        [self setProperty:@106 forKey:k_survival];
        [self setProperty:@66 forKey:k_logistics];
    }
    return self;
}

@end

@implementation Morgen

- (id)init {
    
    self = [super init];
    if (self) {
        
        [self setProperty:@"摩根" forKey:k_name];
        [self setProperty:@1 forKey:k_gender];
        [self setProperty:@34 forKey:k_age];
        
        [self setProperty:@100 forKey:k_prestige];
        
        [self setProperty:@24 forKey:k_courage];
        [self setProperty:@22 forKey:k_strength];
        [self setProperty:@18 forKey:k_agility];
        [self setProperty:@23 forKey:k_strategy];
        [self setProperty:@19 forKey:k_eq];
        [self setProperty:@12 forKey:k_goodness];
        
        [self setProperty:@95 forKey:k_maxHealth];
        [self setProperty:@95 forKey:k_health];
        [self setProperty:@100 forKey:k_stamina];
        [self setProperty:@100 forKey:k_hungry];
        [self setProperty:@100 forKey:k_thirsty];
        
        [self setProperty:@93 forKey:k_combat];
        [self setProperty:@54 forKey:k_shooting];
        [self setProperty:@118 forKey:k_survival];
        [self setProperty:@81 forKey:k_logistics];
    }
    return self;
}

@end
