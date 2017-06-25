//
//  Team.m
//  zombie
//
//  Created by 尹楠 on 17/6/12.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "Team.h"

static Team *_myTeam;

@implementation Team

+ (Team *)myTeam {
    
    if (!_myTeam) {
        
        NSString *teamId = [[Game sharedGame] property:k_myTeamId];
        _myTeam = (Team *)[Team entityWithId:teamId];
    }
    
    return _myTeam;
}

+ (BOOL)allowSaveArray {
    
    return YES;
}

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self setProperty:[NSString uniqueString] forKey:k_id];
    }
    return self;
}

- (NSArray *)survivors {
    
    if (!_survivors) {
        
        NSMutableArray *survivors = [NSMutableArray new];
        for (NSString *survivorId in [self property:k_survivorIds]) {
            
            [survivors addObject:[Survivor entityWithId:survivorId]];
        }
        _survivors = survivors;
    }
    
    return _survivors;
}

@end
