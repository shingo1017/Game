//
//  Hair.m
//  girl
//
//  Created by 尹楠 on 16/9/2.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "Hair.h"

@implementation Hair

+ (Part *)randomPart {
    
    Hair *part = [[Hair alloc] init];
    [part initialization];
    
    return part;
}

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        self.name = @"头发";
    }
    
    return self;
}

- (void)initialization {
    
    self.color = [Utility getRandomNumber:1 to:3];
    self.tactility = [Utility getRandomNumber:30 to:80];
}

- (BOOL)canWatch {
    
    return YES;
}

- (BOOL)canTouch {
    
    return YES;
}

@end
