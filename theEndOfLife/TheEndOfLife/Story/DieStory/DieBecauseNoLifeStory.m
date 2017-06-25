//
//  DieBecauseNoLifeStory.m
//  destroy
//
//  Created by 尹楠 on 16/9/25.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "DieBecauseNoLifeStory.h"
#import "EndingRewardView.h"

@implementation DieBecauseNoLifeStory

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self addCutscenesWithCommandTexts:@[
                                             @"#m|终……|#w:0.4|终于……|#w:0.6|到来了……",
                                             
                                             @"#c|最终因为长期没有进食|#w:0.4|，身体得不到能量补充|#w:0.4|，真吾的生命走到了尽头。",
                                             ]];
    }
    return self;
}

@end
