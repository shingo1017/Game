//
//  Shingo.m
//  destroy
//
//  Created by 尹楠 on 16/9/19.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "Shingo.h"

@implementation Shingo

- (id)init {
    
    self = [super init];
    if (self) {
        
        [self setProperty:@"平良" forKey:@"surname"];
        [self setProperty:@"真吾" forKey:@"name"];
        [self setProperty:@174 forKey:@"height"];
        [self setProperty:@68 forKey:@"weight"];
        
        [self setProperty:@1000 forKey:@"hungry"];
        [self setProperty:@1000 forKey:@"energy"];
        [self setProperty:@1000 forKey:@"life"];
        [self setProperty:@1000 forKey:@"thirsty"];
        [self setProperty:@1000 forKey:@"dehydration"];
        [self setProperty:@1000 forKey:@"sober"];
        [self setProperty:@800 forKey:@"health"];
        [self setProperty:@800 forKey:@"strength"];
        [self setProperty:@700 forKey:@"kind"];
        [self setProperty:@800 forKey:@"reason"];
        
        [self commonInitialization];
        
        [self initializationNonSave];
    }
    
    return self;
}

@end
