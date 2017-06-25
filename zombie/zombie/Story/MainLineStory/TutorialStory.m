//
//  TutorialStory.m
//  girl
//
//  Created by 尹楠 on 16/9/6.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "TutorialStory.h"
#import "Cutscene.h"
#import "NSString+Additions.h"
#import "Entity.h"

@implementation TutorialStory

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self addCutscenesWithCommandTexts:@[
                                             @"#ic:黑色|剧情略。",
                                             ]];
        //设置剧情结束后跳转到的场景
        //self.sceneClassNameWhenEndOfStory = @"PlaceScene";
    }
    return self;
}

- (void)storyResult {
    
    [super storyResult];
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_SCENE_NOTIFICATION object:nil];
    
    [Message hideMessage];
}

@end

//@implementation TutorialPackBagStory
//
//- (id)init {
//    
//    self = [super init];
//    if (self) {
//        // Initialization code here.
//        
//        [self addCutscenesWithCommandTexts:@[
//                                             @"#m|出发前|#w:0.8|，我都会检查一遍背包|#w:0.8|，这一天的食粮|#w:0.8|，和防身用的东西。|#w:0.8|#c|然后带着一天的收获|#w:0.8|，晚上再回到这里。",
//                                             
//                                             @"#ic:教堂礼拜间|#m|偶尔|#w:0.8|，我会来这里祈祷|#w:0.8|，有时候|#w:0.6|，人们其实需要靠信仰活下去。",
//                                             ]];
//        self.sceneClassNameWhenEndOfStory = @"ChurchWorshipScene";
//    }
//    return self;
//}
//
//- (void)storyResult {
//    
//    [super storyResult];
//    
//    [[Game sharedGame] dateProperty:@"time" plus:Minutes(8)];
//    
//    [Bag setSharedBag:[Utility objectForClassName:@"PlasticBag"]];
//    
//    Item *canItem = [[Bag sharedBag] addItemWithClassName:@"LuncheonMeatCanItem"];
//    [canItem setProperty:@([canItem intProperty:@"maxDurability"]) forKey:@"durability"];
//    Item *waterItem = [[Bag sharedBag] addItemWithClassName:@"WaterItem"];
//    [waterItem setProperty:@([waterItem intProperty:@"maxDurability"]) forKey:@"durability"];
//    
//    //额外补给
//    if ([[System system] boolProperty:@"foodPurchased"]) {
//        
//        [[Bag sharedBag] addItemWithClassName:@"LuncheonMeatCanItem" count:1];
//        [[System system] setProperty:@NO forKey:@"foodPurchased"];
//    }
//    if ([[System system] boolProperty:@"waterPurchased"]) {
//        
//        [[Bag sharedBag] addItemWithClassName:@"WaterItem" count:1];
//        [[System system] setProperty:@NO forKey:@"waterPurchased"];
//    }
//    
//    [[Person me] setProperty:@"ChurchWorshipScene" forKey:@"scene"];
//    [Message hideMessage];
//}
//
//@end
//
//@implementation TutorialPrayStory
//
//- (id)init {
//    
//    self = [super init];
//    if (self) {
//        // Initialization code here.
//        
//        [self addCutscenesWithCommandTexts:@[
//                                             @"#m|希望今天可以平安归来。",
//                                             
//                                             @"#ic:教堂外面|#m|在出发之前|#w:0.8|，还有一件小事|#w:0.8|，把家的入口伪装一下|#w:0.6|，让其他生还者以为这里被废弃了|#w:0.6|，否则被发现这里有人住|#w:0.6|，就全完了。",
//                                             ]];
//        self.sceneClassNameWhenEndOfStory = @"ChurchScene";
//    }
//    return self;
//}
//
//- (void)storyResult {
//    
//    [super storyResult];
//    
//    [[Game sharedGame] dateProperty:@"time" plus:Minutes(5)];
//    [[Person me] setProperty:@"ChurchScene" forKey:@"scene"];
//    
//    [Message hideMessage];
//}
//
//@end
//
//@implementation TutorialGoStory
//
//- (id)init {
//    
//    self = [super init];
//    if (self) {
//        // Initialization code here.
//        
//        [self addCutscenesWithCommandTexts:@[
//                                             @"#m|教堂旁边有一栋住宅楼，让我们从这里开始吧。",
//                                             
//                                             @"#ic:天桥街|#c|行进中……|#w:1.0|#c|行进中……|#w:1.0|#c|行进中……",
//                                             
//                                             @"#ic:民宅|#m|到了|#w:0.8|，住宅楼里通常会找到人们撤离时没来得及带走的罐头和一些生活用品。",
//                                             ]];
//        self.sceneClassNameWhenEndOfStory = @"ResidenceScene";
//    }
//    return self;
//}

//- (void)storyResult {
//    
//    [super storyResult];
//    
//    Scene *residenceScene = [Utility objectForClassName:@"ResidenceScene"];
//    [residenceScene setProperty:@"BridgeStreetScene" forKey:@"passWayScene"];
//    [residenceScene setProperty:@3 forKey:@"timeOfPassWayToChurchScene"];
//    [residenceScene setProperty:@"ChurchScene" forKey:@"outsideSceneClassName"];
//    [residenceScene setProperty:@"ResidenceRoomScene" forKey:@"insideSceneClassName"];
//    [residenceScene setProperty:@0 forKey:@"progress"];
//    [residenceScene setProperty:@YES forKey:@"isTutorial"];
//    [Scene setScene:residenceScene forClassName:@"ResidenceScene"];
//    [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_HOME_MUTABLEACTIONS_NOTIFICATION object:nil];
//   
//    [[Game sharedGame] dateProperty:@"time" plus:Minutes(10)];
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldReloadMyStatusOnMainScreenGroup" object:nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldReloadTimeGroup" object:nil];
//    
//    [Message hideMessage];
//}

//@end
