//
//  ReadMe.m
//  zombie
//
//  Created by 尹楠 on 17/5/20.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "ReadMe.h"

@implementation ReadMe

- (void)readme {
    
    //保存游戏
    [Game saveGame];
    
    //读取游戏
    [Game loadGame];
    
    //时间经过
    [[Game sharedGame] timePassWorkHours];                          //时间直接经过4小时
    [[Game sharedGame] dateProperty:@"time" plus:Minutes(5)];       //小时Hours(int)  分钟Minutes(int)
    
    //跳转场景
    [Scene transferSceneWithClassName:@"场景类名"];
    
    //开始剧情
    [Story beginStoryWithClassName:@"剧情类名"];
}

@end
