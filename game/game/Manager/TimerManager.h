//
//  TimerManager.h
//  theEndOfLife
//
//  Created by 尹楠 on 16/10/12.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "Entity.h"

@interface TimerManager : Entity

+ (TimerManager *)sharedManager;

- (void)stopTimerWithKey:(NSString *)key;
- (void)stopAllTimer;

@end
