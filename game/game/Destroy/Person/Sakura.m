//
//  Sakura.m
//  destroy
//
//  Created by 尹楠 on 16/9/19.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "Sakura.h"

@implementation Sakura

- (id)init {
    
    self = [super init];
    if (self) {
       
        [self setProperty:@"原田" forKey:@"surname"];
        [self setProperty:@"若叶" forKey:@"name"];
        [self setProperty:@155 forKey:@"height"];
        [self setProperty:@43 forKey:@"weight"];
        
        [self setProperty:@950 forKey:@"hungry"];
        [self setProperty:@1000 forKey:@"energy"];
        [self setProperty:@1000 forKey:@"life"];
        [self setProperty:@980 forKey:@"thirsty"];
        [self setProperty:@1000 forKey:@"dehydration"];
        [self setProperty:@500 forKey:@"strength"];
        [self setProperty:@900 forKey:@"kind"];
        [self setProperty:@700 forKey:@"reason"];
        
        [self commonInitialization];
        
        [self initializationNonSave];
    }
    
    return self;
}

- (void)initializationNonSave {
    
    [self setProperty:@700 forKey:@"imageWidth" save:NO];
    [self setProperty:@700 forKey:@"imageHeight" save:NO];
}

@end
