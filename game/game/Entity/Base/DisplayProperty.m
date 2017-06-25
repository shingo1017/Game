//
//  DisplayProperty.m
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "DisplayProperty.h"

@implementation DisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.color = [UIColor whiteColor];
    }
    
    return self;
}

- (BOOL)isAvailable {
    
    return YES;
}

@end
