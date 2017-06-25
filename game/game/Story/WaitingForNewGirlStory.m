//
//  WaitingForNewGirlStory.m
//  girl
//
//  Created by 尹楠 on 16/9/6.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "WaitingForNewGirlStory.h"
#import "Cutscene.h"

@implementation WaitingForNewGirlStory

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        NSMutableArray *cutscenes = [[NSMutableArray alloc] init];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"蹲守中.." secondsOfAutoGoNext:1.5f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"蹲守中...." secondsOfAutoGoNext:1.5f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"蹲守中......" secondsOfAutoGoNext:1.5f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"蹲守中........" secondsOfAutoGoNext:1.5f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"吼 ~ 来了一个！看看怎么样？"]];
        self.cutscenes = cutscenes;
    }
    return self;
}

- (void)storyResult {
    
    Girl *girl = [[Girl alloc] init];
    [girl initialization];
    [girl setProperty:@"HuntingScene" forKey:@"location" save:YES];
    [Girl setDefaultGirl:girl];
}

@end
