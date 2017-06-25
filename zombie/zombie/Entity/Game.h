//
//  Game.h
//  zombie
//
//  Created by 尹楠 on 17/5/13.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "Game.h"

#define k_dayAfterLastHumanDay  @"dayAfterLastHumanDay"
#define k_day                   @"day"
#define k_hour                  @"hour"

typedef NS_ENUM(NSInteger, TimePeriod){
    TimePeriodMorning = 8,
    TimePeriodAfternoon = 12,
    TimePeriodDusk = 16,
    TimePeriodEvening = 20,
    TimePeriodMidnight = 0,
    TimePeriodDawn = 4,
};

@interface Game : BaseGame

+ (Game *)sharedGame;

- (void)timePassHours:(NSInteger)hours;
- (void)timePassWorkHours;
- (NSString *)timePeriodText;

@end
