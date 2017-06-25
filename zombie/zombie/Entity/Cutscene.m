//
//  Cutscene.m
//  zombie
//
//  Created by 尹楠 on 17/5/13.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "Cutscene.h"

@implementation Cutscene

+ (Cutscene *)currentCutscene {
    
    return (Cutscene *)[super currentCutscene];
}

- (void)allStepOver {
    
    [[MainView sharedView] showContinueButton];
}

@end
