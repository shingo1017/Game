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
                                             @"#pih|#mis:若叶_悲伤|#m|爸爸……|#w:0.4|我……|#w:0.2|好想你……",
                                             
                                             @"#c|最终因为长期没有进食|#w:0.3|，身体得不到能量补充|#w:0.3|，若叶的生命走到了尽头。",
                                             ]];
    }
    return self;
}

@end
