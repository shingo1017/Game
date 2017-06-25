//
//  FaintStory.m
//  destroy
//
//  Created by 尹楠 on 16/9/25.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "FaintStory.h"

@implementation FaintStory

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [[TimerManager sharedManager] stopAllTimer];
    }
    return self;
}

- (void)storyResult {
    
    
}

@end
