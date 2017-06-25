//
//  LoungeScene.m
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "LoungeScene.h"

@implementation LoungeScene

- (id)init {
    
    self = [super init];
    if (self) {
    
        [self setProperty:@"休息室" forKey:@"sceneImageName" save:NO];
        [self setProperty:[Utility getSubClassInstancesWithFatherClassName:@"Group" belongToClassName:NSStringFromClass([self class])] forKey:@"groups" save:NO];
        
        /*id communicationAction = [Utility objectForClassName:@"CommunicationAction"];
        id talkAction = [Utility objectForClassName:@"TalkAction"];
        [communicationAction setValue:@[talkAction] forKey:@"actions"];
        
        id eatAction = [Utility objectForClassName:@"EatAction"];
        id eatFullAction = [Utility objectForClassName:@"EatFullAction"];
        id eatHalfAction = [Utility objectForClassName:@"EatHalfAction"];
        id eatLittleAction = [Utility objectForClassName:@"EatLittleAction"];
        [eatAction setValue:@[eatFullAction, eatHalfAction, eatLittleAction] forKey:@"actions"];
        
        id drinkAction = [Utility objectForClassName:@"DrinkAction"];
        id drinkFullAction = [Utility objectForClassName:@"DrinkFullAction"];
        id drinkHalfAction = [Utility objectForClassName:@"DrinkHalfAction"];
        id drinkLittleAction = [Utility objectForClassName:@"DrinkLittleAction"];
        [drinkAction setValue:@[drinkFullAction, drinkHalfAction, drinkLittleAction] forKey:@"actions"];
        
        id peeAction = [Utility objectForClassName:@"PeeAction"];
        id peeAloneAction = [Utility objectForClassName:@"PeeAloneAction"];
        id peeFaceMeAction = [Utility objectForClassName:@"PeeFaceMeAction"];
        [peeAction setValue:@[peeAloneAction, peeFaceMeAction] forKey:@"actions"];
        */
        
        id myAction = [Utility objectForClassName:@"MyAction"];
        id myInfoAction = [Utility objectForClassName:@"MyInfoAction"];
        id myRestAction = [Utility objectForClassName:@"MyRestAction"];
        [myAction setValue:@[myInfoAction, myRestAction] forKey:@"actions"];
        
        id bagAction = [Utility objectForClassName:@"BagAction"];
        [bagAction setValue:[Action actionsWithBagItems] forKey:@"actions"];

        id mobilePhoneAction = [Utility objectForClassName:@"MobilePhoneAction"];
        id batteryAction = [Utility objectForClassName:@"BatteryAction"];
        [mobilePhoneAction setValue:@[batteryAction] forKey:@"actions"];
         
        id talkAction = [Utility objectForClassName:@"TalkAction"];
        id loungeCheckExitAction = [Utility objectForClassName:@"LoungeCheckExitAction"];
        id toolhouseAction = [Utility objectForClassName:@"ToolhouseAction"];
        id infirmaryAction = [Utility objectForClassName:@"InfirmaryAction"];
        [self setProperty:@[myAction, bagAction, mobilePhoneAction, talkAction, loungeCheckExitAction, toolhouseAction, infirmaryAction] forKey:@"actions" save:NO];
    }
    return self;
}

@end
