//
//  TownHospital.m
//  zombie
//
//  Created by 尹楠 on 17/5/16.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "TownHospital.h"

@implementation TownHospital

- (id)init {
    
    self = [super init];
    if (self) {
        
        [self setProperty:@"小镇医院" forKey:k_name save:YES];
        [self setProperty:@"小镇医院" forKey:@"sceneImageName" save:YES];
        [self setProperty:@2820 forKey:k_landArea save:YES];
        [self setProperty:@835 forKey:k_buildingArea save:YES];
        [self setProperty:@225 forKey:k_defence save:YES];
//        [self setProperty:@random(30, 40) forKey:k_zombieInside save:YES];
        [self setProperty:@(0) forKey:k_zombieInside save:YES];
        [self setProperty:@random(10, 30) forKey:k_zombieOutside save:YES];
        [self setProperty:@0 forKey:k_peace save:YES];
        [self setProperty:@random(200, 250) forKey:k_food save:YES];
        [self setProperty:@random(350, 400) forKey:k_water save:YES];
        [self setProperty:@random(350, 450) forKey:k_medicine save:YES];
        [self setProperty:@random(10, 30) forKey:k_material save:YES];
        [self setProperty:@random(0, 10) forKey:k_ammunition save:YES];
        [self setProperty:@30 forKey:k_nattiness save:YES];
        [self setProperty:@55 forKey:k_sanitation save:YES];
        
        [self setProperty:@YES forKey:k_isBuilding save:YES];
        [self setProperty:@YES forKey:k_isFief save:YES];
        [self setProperty:@YES forKey:k_isLead save:YES];
    }
    return self;
}

@end
