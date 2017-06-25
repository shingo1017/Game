//
//  Game.m
//  theEndOfLife
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
    
    [saveDictionary setObject:[Scene arrayForSave] forKey:@"scenes"];
    
    [saveDictionary setObject:[[Game sharedGame] dictionaryForSave] forKey:@"game"];
    
    if ([Person me])
        [saveDictionary setObject:[[Person me] dictionaryForSave] forKey:@"me"];
    else
        [saveDictionary removeObjectForKey:@"me"];
    
    if ([Person partner])
        [saveDictionary setObject:[[Person partner] dictionaryForSave] forKey:@"partner"];
    else
        [saveDictionary removeObjectForKey:@"partner"];
    
    [saveDictionary setObject:[[Store sharedStore] dictionaryForSave] forKey:@"store"];
    [saveDictionary setObject:[[Bag sharedBag] dictionaryForSave] forKey:@"bag"];
    
    return saveDictionary;
}

- (BOOL)canLoadGameWithSaveFile:(NSDictionary *)saveDictionary {
    
    id me = [saveDictionary objectForKey:@"me"];
    id scenes = [saveDictionary objectForKey:@"scenes"];
    
    if (me && scenes)
        return YES;
    else
        return NO;
}

- (void)loadGameContentWithSaveFile:(NSDictionary *)saveDictionary {
    
    [Game loadWithSaveDictionary:[saveDictionary objectForKey:@"game"]];
    
    [Person loadMeWithSaveDictionary:[saveDictionary objectForKey:@"me"]];
    [Person loadPartnerWithSaveDictionary:[saveDictionary objectForKey:@"partner"]];
    
    [Store loadWithSaveDictionary:[saveDictionary objectForKey:@"store"]];
    [Bag loadWithSaveDictionary:[saveDictionary objectForKey:@"bag"]];
    
    [Scene loadWithSaveArray:[saveDictionary objectForKey:@"scenes"]];
}

- (void)timeChanged {
    
    //自动降低健康指数
    if ([[Game sharedGame] daysPass] > [[Game sharedGame] intProperty:@"daysForCheckHealth"]) {
        
        [[Person me] intProperty:@"health" plus:-1];
        [[Game sharedGame] setProperty:@([[Game sharedGame] daysPass]) forKey:@"daysForCheckHealth"];
        [[Game sharedGame] setProperty:@NO forKey:@"isPraySafe"];
        [[Game sharedGame] setProperty:@NO forKey:@"isPrayLuck"];
    }
    
    //检查是否有剧情触发
    [Story checkStoryFireByTime];
}

@end
