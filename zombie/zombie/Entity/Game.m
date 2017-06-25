//
//  Game.m
//  zombie
//
//  Created by 尹楠 on 17/5/13.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "Game.h"

@implementation Game

+ (Game *)sharedGame {
    
    return (Game *)[super sharedGame];
}

- (NSDictionary *)saveGameContent {
    
    NSMutableDictionary *saveDictionary = [[NSMutableDictionary alloc] init];
    
    [saveDictionary setObject:[Team arrayForSave] forKey:@"teams"];
    [saveDictionary setObject:[Place arrayForSave] forKey:@"places"];
    [saveDictionary setObject:[Survivor arrayForSave] forKey:@"survivors"];
    [saveDictionary setObject:[[Game sharedGame] dictionaryForSave] forKey:@"game"];
    
    return saveDictionary;
}

- (BOOL)canLoadGameWithSaveFile:(NSDictionary *)saveDictionary {
    
    id places = [saveDictionary objectForKey:@"places"];
    
    if (places)
        return YES;
    else
        return NO;
}

- (void)loadGameContentWithSaveFile:(NSDictionary *)saveDictionary {
    
    [Game loadWithSaveDictionary:[saveDictionary objectForKey:@"game"]];
    [Team loadWithSaveArray:[saveDictionary objectForKey:@"teams"]];
    [Place loadWithSaveArray:[saveDictionary objectForKey:@"places"]];
    [Survivor loadWithSaveArray:[saveDictionary objectForKey:@"survivors"]];
}

- (void)timePassHours:(NSInteger)hours {
    
    [self intProperty:k_hour plus:hours];
    
    [self timePass];
}

- (void)timePassWorkHours {
    
    [self intProperty:k_hour plus:4];
    
    [self timePass];
}

- (void)timePass {
    
    if ([self intProperty:k_hour] >= 24) {
        
        [self setProperty:@(TimePeriodMidnight) forKey:k_hour];
        [self intProperty:k_day plus:1];
        NSLog(@"k_dayAfterLastHumanDay:%li", [self intProperty:k_day]);
    }
}

- (NSString *)timePeriodText {
    
    NSString *text;
    
    NSInteger hour = [self intProperty:k_hour];
    
    if (hour >= TimePeriodMorning && hour < TimePeriodAfternoon)
        text = @"上午";
    else if (hour >= TimePeriodAfternoon && hour < TimePeriodDusk)
        text = @"下午";
    else if (hour >= TimePeriodDusk && hour < TimePeriodEvening)
        text = @"傍晚";
    else if (hour >= TimePeriodEvening)
        text = @"夜晚";
    else if (hour >= TimePeriodMidnight && hour < TimePeriodDawn)
        text = @"午夜";
    else if (hour >= TimePeriodDawn && hour < TimePeriodMorning)
        text = @"清晨";
    else
        text = @"未知";
    
    return text;
}

@end
