//
//  TimerManager.m
//  theEndOfLife
//
//  Created by 尹楠 on 16/10/12.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "TimerManager.h"

@implementation TimerManager

static TimerManager *_sharedManager;

+ (TimerManager *)sharedManager {
    
    if (!_sharedManager)
        _sharedManager = [[TimerManager alloc] init];
    
    return _sharedManager;
}

- (void)stopTimerWithKey:(NSString *)key {
    
    NSTimer *timer = [[TimerManager sharedManager] property:key];
    [timer invalidate];
    timer = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:key object:nil];
    
    [[TimerManager sharedManager].propertyDictionary removeObjectForKey:key];
}

- (void)stopAllTimer {
    
    for (NSString *key in [[TimerManager sharedManager].propertyDictionary allKeys]) {
        
        if ([[[TimerManager sharedManager].propertyDictionary objectForKey:key] isKindOfClass:[NSTimer class]])
            [self stopTimerWithKey:key];
    }
}

@end
