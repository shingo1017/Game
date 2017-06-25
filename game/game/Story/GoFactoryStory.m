//
//  GoFactoryStory.m
//  girl
//
//  Created by 尹楠 on 16/9/6.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "GoFactoryStory.h"
#import "Cutscene.h"

@implementation GoFactoryStory

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        NSMutableArray *cutscenes = [[NSMutableArray alloc] init];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"你回到了车上。" imageName:@"开车" secondsOfAutoGoNext:2.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"（汽车打火的声音）" secondsOfAutoGoNext:2.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"汽车行驶中.." secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"汽车行驶中...." secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"汽车行驶中......" secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"汽车行驶中........" secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"汽车行驶中.........." secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"汽车行驶中............" secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"汽车行驶中.............." secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"汽车行驶中................" secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"工厂到了。" imageName:@"工厂外面" secondsOfAutoGoNext:2.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"" imageName:@"工厂内部" secondsOfAutoGoNext:0.5f]];
        self.cutscenes = cutscenes;
        self.sceneClassNameWhenEndOfStory = @"FactoryInsideScene";
    }
    return self;
}

@end
