//
//  PersonScene.m
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "PersonScene.h"

@implementation PersonScene

- (id)init {
    
    self = [super init];
    if (self) {
    
        [self setProperty:@"工具房" forKey:@"sceneImageName" save:NO];
         [self setProperty:[Utility getSubClassInstancesWithFatherClassName:@"Group" belongToClassName:NSStringFromClass([self class])] forKey:@"groups" save:NO];
        
        id myAction = [Utility objectForClassName:@"MyAction"];
        id myInfoAction = [Utility objectForClassName:@"MyInfoAction"];
        id myRestAction = [Utility objectForClassName:@"MyRestAction"];
        [myAction setValue:@[myInfoAction, myRestAction] forKey:@"actions"];
        
        id mobilePhoneAction = [Utility objectForClassName:@"MobilePhoneAction"];
        id batteryAction = [Utility objectForClassName:@"BatteryAction"];
        [mobilePhoneAction setValue:@[batteryAction] forKey:@"actions"];
        
        id talkAction = [Utility objectForClassName:@"TalkAction"];
        id toolhouseCheckExitAction = [Utility objectForClassName:@"ToolhouseCheckExitAction"];
        id loungeAction = [Utility objectForClassName:@"LoungeAction"];
        [self setProperty:@[myAction, mobilePhoneAction, talkAction, toolhouseCheckExitAction, loungeAction] forKey:@"actions" save:NO];
    }
    return self;
}

@end
