//
//  GirlAI.m
//  girl
//
//  Created by 尹楠 on 16/9/14.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "GirlAI.h"
#import "HitAction.h"

@implementation AwakeFromKidnapAI

- (void)checkAvailableWithAction:(Action *)action {
    
    if ([action.parentActionName isEqualToString:@"HitAction"] && ![[Girl defaultGirl] boolProperty:@"isKnown"]) {
        
        [self startAI];
    }
}

- (void)startAI {
    
    [Message appandAsideText:@"女生从昏迷中惊醒了"];
    [Message appandGirlText:@"嗯...啊！！ 你是谁！这是哪里？？"];
    
    [[Girl defaultGirl] setProperty:@YES forKey:@"isKnown" save:YES];
}


@end

@implementation SingingAI

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
    }
    
    return self;
}

- (void)checkAvailable {
    
    NSInteger chance = [Utility getRandomNumber:0 to:100];
    
    if (chance > 90)
        [self startAI];
}

- (void)startAI {
    
    [Message appandAsideText:@"她唱起了歌"];
    [Message appandGirlText:@""];
}

@end