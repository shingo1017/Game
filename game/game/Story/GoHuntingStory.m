//
//  GoHuntingStory.m
//  girl
//
//  Created by 尹楠 on 16/9/6.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "GoHuntingStory.h"
#import "Cutscene.h"

@implementation GoHuntingStory

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        NSMutableArray *cutscenes = [[NSMutableArray alloc] init];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"你拿上了蒙汗药、手帕就出门了。" secondsOfAutoGoNext:3.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"" imageName:@"工厂外面" secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"（汽车打火的声音）" imageName:@"开车" secondsOfAutoGoNext:2.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"汽车行驶中.." secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"汽车行驶中...." secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"汽车行驶中......" secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"汽车行驶中........" secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"汽车行驶中.........." secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"汽车行驶中............" secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"汽车行驶中.............." secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"汽车行驶中................" secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"夜市到了，今晚的夜市街依然是灯火通明。" imageName:@"夜市"]];
        self.cutscenes = cutscenes;
        self.sceneClassNameWhenEndOfStory = @"HuntingScene";
    }
    return self;
}

@end
