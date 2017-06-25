//
//  StoreAction.m
//  theEndOfLife
//
//  Created by 尹楠 on 16/10/15.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "StoreAction.h"

@implementation StoreAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setProperty:@"储物区" forKey:k_name save:NO];
    }
    return self;
}

- (BOOL)isAvailable {
    
    return [[Game sharedGame] boolProperty:@"TutorialGoStory"];
}

- (void)actionResult {
    
    [[StoreView sharedView] show];
}

@end
