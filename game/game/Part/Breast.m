//
//  Breast.m
//  girl
//
//  Created by 尹楠 on 16/9/2.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "Breast.h"

@implementation Breast

+ (Part *)randomPart {
    
    Breast *part = [[Breast alloc] init];
    [part initialization];
    
    return part;
}

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        self.name = @"胸部";
    }
    
    return self;
}

- (void)initialization {
    
    self.tactility = [Utility getRandomNumber:60 to:80];
    self.sensitive = [Utility getRandomNumber:60 to:80];
}

- (BOOL)canWatch {
    
    return YES;
}

- (BOOL)canTouch {
    
    return YES;
}

@end
