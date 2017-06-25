//
//  DieStory.m
//  destroy
//
//  Created by 尹楠 on 16/9/25.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "DieStory.h"
#import "EndingRewardView.h"

@implementation DieStory

- (void)storyEffect {
    
    
}

- (void)storyResult {
    
    [UIView animateWithDuration:1.5f animations:^{
        
        [MainView sharedView].sceneTransferMaskView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
        //[Game deleteLoad];
        
        EndingRewardView *endingRewardView = [[MainView sharedView].storyboard instantiateViewControllerWithIdentifier:@"EndingRewardView"];
        [[MainView sharedView].navigationController pushViewController:endingRewardView animated:NO];
    }];
}

@end
