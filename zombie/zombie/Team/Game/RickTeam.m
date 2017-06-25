//
//  RickTeam.m
//  zombie
//
//  Created by 尹楠 on 17/6/12.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "RickTeam.h"

@implementation RickTeam

- (id)init {
    
    self = [super init];
    if (self) {
        
        [self setProperty:@"瑞克" forKey:k_name];
    }
    return self;
}

@end
