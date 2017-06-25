//
//  CarryGirlBackStory.m
//  girl
//
//  Created by 尹楠 on 16/9/6.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "CarryGirlBackStory.h"
#import "Cutscene.h"

@implementation CarryGirlBackStory

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        NSMutableArray *cutscenes = [[NSMutableArray alloc] init];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"你装作是她的男友，搀扶着昏迷的女生，走向你的车。"]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"（脚步声）" secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"（脚步声）...（脚步声）" secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"（脚步声）...（脚步声）...（脚步声）" secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"将女生放入车后座后，你坐到了驾驶座上，回头看了看女生，她摊到在车后座上，一动不动。" imageName:@"开车"]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"（汽车打火的声音）" secondsOfAutoGoNext:2.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"汽车行驶中.." secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"汽车行驶中...." secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"汽车行驶中......" secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"汽车行驶中........" secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"汽车行驶中.........." secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"是不是很激动？" secondsOfAutoGoNext:2.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"汽车行驶中............" secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"汽车行驶中.............." secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"汽车行驶中................" secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"工厂到了，你停下了车，将女生从后座上拖下来，扛到肩膀上，走向工厂里面。" imageName:@"工厂外面" secondsOfAutoGoNext:2.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"（脚步声）" secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"（脚步声）...（脚步声）" secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"（脚步声）...（脚步声）...（脚步声）" secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"（脚步声）" imageName:@"工厂内部" secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"（脚步声）...（脚步声）" secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"（脚步声）...（脚步声）...（脚步声）" secondsOfAutoGoNext:1.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"你把女生放在了地下室的角落里。" imageName:@"地下室" secondsOfAutoGoNext:3.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"然后你将女生的手和脚都用铁链锁在了地面上。" secondsOfAutoGoNext:3.0f]];
//        [cutscenes addObject:[Cutscene cutsceneWithAside:@"恭喜！你成功的绑架了一名女生，现在，你可以和她进行互动了。"]];
        self.cutscenes = cutscenes;
        self.sceneClassNameWhenEndOfStory = @"BasementScene";
    }
    return self;
}

- (void)storyResult {
    
    [[Girl defaultGirl] setProperty:@"BasementScene" forKey:@"location" save:YES];
    [Action applySceneActions];
    [Utility reloadActions];
}

@end
