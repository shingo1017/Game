//
//  PartnerAction.m
//  destroy
//
//  Created by 尹楠 on 16/9/21.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "PartnerAction.h"

@implementation TalkAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        self.name = @"交 谈";
    }
    return self;
}

- (NSString *)parentActionName {
    
    return nil;
}

- (BOOL)isAvailable {
    
    if ([[Person me] isSameSceneWithPerson:[Person partner]])
        return YES;
    else
        return NO;
}

- (void)actionResult {
    
    NSString *mainStoryName = [Story mainStoryName];
    NSString *mainStoryTalkClassName = [NSString stringWithFormat:@"Talk%@", mainStoryName];
    BOOL mainStoryTalked = [[Game sharedGame] boolProperty:mainStoryTalkClassName];
    
    if (NSClassFromString(mainStoryTalkClassName) && !mainStoryTalked) {
        
        //未进行主线谈话
        [Story beginStoryWithClassName:mainStoryTalkClassName];
    }
    else {
        
        //已经进行过主线谈话
        NSInteger talkLimit = [[Person me] intProperty:@"talkLimit"];
        NSInteger talk = [[Person me] intProperty:@"talk"];
        
        if (talk < talkLimit)
            [Story beginStoryWithClassName:[NSString stringWithFormat:@"Talk%liStory", talk]];
        else
            [Story beginStoryWithClassName:@"NoTalkStory"];
    }
}

@end

