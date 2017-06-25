//
//  KidnapStory.m
//  girl
//
//  Created by 尹楠 on 16/9/6.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "KidnapStory.h"
#import "Cutscene.h"

@implementation KidnapStory

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        NSMutableArray *cutscenes = [[NSMutableArray alloc] init];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"好，就是她了。" secondsOfAutoGoNext:2.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"你悄悄地接近女生后面.." secondsOfAutoGoNext:1.5f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"你悄悄地接近女生后面...." secondsOfAutoGoNext:1.5f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"你悄悄地接近女生后面......" secondsOfAutoGoNext:1.5f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"趁女生没有注意，你从后面用蒙汗药捂住了她的嘴和鼻子！" secondsOfAutoGoNext:3.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"女生还没反应过来，意识已经渐渐的模糊.." secondsOfAutoGoNext:1.5f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"女生还没反应过来，意识已经渐渐的模糊...." secondsOfAutoGoNext:1.5f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"女生还没反应过来，意识已经渐渐的模糊......" secondsOfAutoGoNext:1.5f]];
        self.cutscenes = cutscenes;
    }
    return self;
}

- (void)storyResult {
    
    [[Girl defaultGirl] setProperty:@30 forKey:@"mentalState" save:YES];
    [Action applySceneActions];
    [Utility reloadActions];
}

@end
