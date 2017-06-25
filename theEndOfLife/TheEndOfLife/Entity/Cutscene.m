//
//  Cutscene.m
//  theEndOfLife
//
//  Created by 尹楠 on 17/5/13.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "Cutscene.h"

@implementation Cutscene

+ (Cutscene *)currentCutscene {
    
    return (Cutscene *)[super currentCutscene];
}

- (BOOL)excuteExtensionCommandText:(NSString *)commandText {
    
    BOOL result = YES;
    
    if ([commandText hasPrefix:@"#mis"]) {
        
        //显示自己立绘
        NSString *value = [[commandText componentsSeparatedByString:@":"] lastObject];
        [[MainView sharedView] showMyImage:value animation:YES];
        
        [self performSelector:@selector(stepOver) withObject:nil];
    }
    else if ([commandText hasPrefix:@"#mih"]) {
        
        //隐藏自己立绘
        [[MainView sharedView] hideMyImageWithAnimation:YES];
        
        [self performSelector:@selector(stepOver) withObject:nil];
    }
    else if ([commandText hasPrefix:@"#pis"]) {
        
        //显示伙伴立绘
        NSString *value = [[commandText componentsSeparatedByString:@":"] lastObject];
        [[MainView sharedView] showPartnerImage:value animation:YES];
        
        [self performSelector:@selector(stepOver) withObject:nil];
    }
    else if ([commandText hasPrefix:@"#pih"]) {
        
        //隐藏伙伴立绘
        [[MainView sharedView] hidePartnerImageWithAnimation:YES];
        
        [self performSelector:@selector(stepOver) withObject:nil];
    }
    else if ([commandText hasPrefix:@"#m"]) {
        
        //清除显示文字 + 显示自己名字
        [MainView sharedView].messageLabel.text = @"";
        [Message appendText:[NSString stringWithFormat:@"[%@] ", [[Person me] property:@"name"]] displayDirectly:YES];
        
        self.afterDelay = [System system].messageSpeed == 0.0f ? 0.0f : 0.3f;
        [self performSelector:@selector(stepOver) withObject:nil afterDelay:self.afterDelay];
    }
    else if ([commandText hasPrefix:@"#p"]) {
        
        //清除显示文字 + 显示伙伴名字
        [MainView sharedView].messageLabel.text = @"";
        
        NSString *partnerName = [[Person me] boolProperty:@"isKnownPartnerName"] ? [[Person partner] property:@"name"] : @"陌生男子";
        [Message appendText:[NSString stringWithFormat:@"[%@] ", partnerName] displayDirectly:YES];
        
        self.afterDelay = [System system].messageSpeed == 0.0f ? 0.0f : 0.3f;
        [self performSelector:@selector(stepOver) withObject:nil afterDelay:self.afterDelay];
    }
    else
        result = NO;
    
    return result;
}

- (void)allStepOver {
    
    //跳过
    if ([[System system] boolProperty:[NSString stringWithFormat:@"skip%@", NSStringFromClass([[Story currentStory] class])]]) {
        
        id storySkipAction = [Utility objectForClassName:@"StorySkipAction"];
        [Action appendAction:storySkipAction];
    }
    
    //继续
    id storyContinueAction = [Utility objectForClassName:@"StoryContinueAction"];
    [Action appendAction:storyContinueAction];
}

@end
