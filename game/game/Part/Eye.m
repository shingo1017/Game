//
//  Eye.m
//  girl
//
//  Created by 尹楠 on 16/9/2.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "Eye.h"

@implementation Eye

+ (Part *)randomPart {
    
    Eye *part = [[Eye alloc] init];
    [part initialization];
    
    return part;
}

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        self.name = @"眼睛";
    }
    
    return self;
}

- (void)initialization {
    
    self.color = [Utility getRandomNumber:1 to:3];
}

- (BOOL)canWatch {
    
    return YES;
}

@end
