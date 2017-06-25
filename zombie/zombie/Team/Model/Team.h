//
//  Team.h
//  zombie
//
//  Created by 尹楠 on 17/6/12.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "Entity.h"

#define k_myTeamId                      @"myTeamId"
#define k_survivorIds                   @"survivorIds"
#define k_survivors                     @"survivors"

@interface Team : Entity

@property (nonatomic, strong) NSArray *survivors;

+ (Team *)myTeam;

@end
