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

@implementation TutorialStory

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self addCutscenesWithCommandTexts:@[
                                             @"#ic:黑色|这个世界|#w:1.2|，结束了。|#w:1.2|#ic:路灯|#c|所有的一切|#w:1.2|，都被人类自己毁灭了。|#w:1.2|#ic:商场废墟|#c|阳光永远的消失了|#w:1.2|，植物已经不再生长。|#w:1.2|#ic:桥梁废墟|水源几乎全被污染了|#w:1.2|，所有的一切已经被洗劫一空。|#w:1.2|#ic:高楼废墟1|#c|繁华的城市已经不在。|#w:1.4|#ic:高楼废墟2|剩下的只有一些不幸的生还者和世界的哀鸣。",
                                             
                                             @"#ic:黑色|#c|某年 秋|#w:0.8| 日本|#w:0.8| 东京|#w:0.8| 某教堂里间……",
                                             
                                             @"#ic:教堂房间|#m|我是其中一个不幸的生还者|#w:1.0|，老实说|#w:1.0|，这种环境|#w:1.0|，还不如死了|#w:1.0|，是吧？",
                                             
                                             @"#m|我每天可以做的|#w:1.0|，就是数着剩下的食物和水还可以存活几天|#w:1.0|，然后祈祷今天能捡到一罐花生酱。",
                                             
                                             @"#m|和我一样生活的人还有一些|#w:1.0|，每个人都很不友好|#w:1.0|，不要相信任何人|#w:1.0|，这就是现在世界的生存法则。",
                                             ]];
        //设置剧情结束后跳转到的场景
        self.sceneClassNameWhenEndOfStory = @"ChurchRoomScene";
    }
    return self;
}

- (void)storyResult {
    
    [super storyResult];
    
    [[Game sharedGame] setProperty:[@"2016-10-08 13:45:00" datetimeValue] forKey:@"time"];
    [[Game sharedGame] setProperty:[@"2016-10-08 13:45:00" datetimeValue] forKey:@"lastSleepTime"];
    [[Game sharedGame] setProperty:@([[Game sharedGame] daysPass]) forKey:@"daysForCheckHealth"];
    
    [Message hideMessage];
}

@end

@implementation TutorialPackBagStory

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self addCutscenesWithCommandTexts:@[
                                             @"#m|出发前|#w:0.8|，我都会检查一遍背包|#w:0.8|，这一天的食粮|#w:0.8|，和防身用的东西。|#w:0.8|#c|然后带着一天的收获|#w:0.8|，晚上再回到这里。",
                                             
                                             @"#ic:教堂礼拜间|#m|偶尔|#w:0.8|，我会来这里祈祷|#w:0.8|，有时候|#w:0.6|，人们其实需要靠信仰活下去。",
                                             ]];
        self.sceneClassNameWhenEndOfStory = @"ChurchWorshipScene";
    }
    return self;
}

- (void)storyResult {
    
    [super storyResult];
    
    [[Game sharedGame] dateProperty:@"time" plus:Minutes(8)];
    
    [Bag setSharedBag:[Utility objectForClassName:@"PlasticBag"]];
    
    Item *canItem = [[Bag sharedBag] addItemWithClassName:@"LuncheonMeatCanItem"];
    [canItem setProperty:@([canItem intProperty:@"maxDurability"]) forKey:@"durability"];
    Item *waterItem = [[Bag sharedBag] addItemWithClassName:@"WaterItem"];
    [waterItem setProperty:@([waterItem intProperty:@"maxDurability"]) forKey:@"durability"];
    
    //额外补给
    if ([[System system] boolProperty:@"foodPurchased"]) {
        
        [[Bag sharedBag] addItemWithClassName:@"LuncheonMeatCanItem" count:1];
        [[System system] setProperty:@NO forKey:@"foodPurchased"];
    }
    if ([[System system] boolProperty:@"waterPurchased"]) {
        
        [[Bag sharedBag] addItemWithClassName:@"WaterItem" count:1];
        [[System system] setProperty:@NO forKey:@"waterPurchased"];
    }
    
    [[Person me] setProperty:@"ChurchWorshipScene" forKey:@"scene"];
    [Message hideMessage];
}

@end

@implementation TutorialPrayStory

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self addCutscenesWithCommandTexts:@[
                                             @"#m|希望今天可以平安归来。",
                                             
                                             @"#ic:教堂外面|#m|在出发之前|#w:0.8|，还有一件小事|#w:0.8|，把家的入口伪装一下|#w:0.6|，让其他生还者以为这里被废弃了|#w:0.6|，否则被发现这里有人住|#w:0.6|，就全完了。",
                                             ]];
        self.sceneClassNameWhenEndOfStory = @"ChurchScene";
    }
    return self;
}

- (void)storyResult {
    
    [super storyResult];
    
    [[Game sharedGame] dateProperty:@"time" plus:Minutes(5)];
    [[Person me] setProperty:@"ChurchScene" forKey:@"scene"];
    
    [Message hideMessage];
}

@end

@implementation TutorialGoStory

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self addCutscenesWithCommandTexts:@[
                                             @"#m|教堂旁边有一栋住宅楼，让我们从这里开始吧。",
                                             
                                             @"#ic:天桥街|#c|行进中……|#w:1.0|#c|行进中……|#w:1.0|#c|行进中……",
                                             
                                             @"#ic:民宅|#m|到了|#w:0.8|，住宅楼里通常会找到人们撤离时没来得及带走的罐头和一些生活用品。",
                                             ]];
        self.sceneClassNameWhenEndOfStory = @"ResidenceScene";
    }
    return self;
}

- (void)storyResult {
    
    [super storyResult];
    
    Scene *residenceScene = [Scene sceneWithClassName:@"ResidenceScene"];
    [residenceScene setProperty:@"BridgeStreetScene" forKey:@"passWayScene"];
    [residenceScene setProperty:@3 forKey:@"timeOfPassWayToChurchScene"];
    [residenceScene setProperty:@"ChurchScene" forKey:@"outsideSceneClassName"];
    [residenceScene setProperty:@"ResidenceRoomScene" forKey:@"insideSceneClassName"];
    [residenceScene setProperty:@0 forKey:@"progress"];
    [residenceScene setProperty:@YES forKey:@"isTutorial"];
    [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_HOME_MUTABLEACTIONS_NOTIFICATION object:nil];
   
    [[Game sharedGame] dateProperty:@"time" plus:Minutes(10)];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldReloadMyStatusOnMainScreenGroup" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldReloadTimeGroup" object:nil];
    
    [Message hideMessage];
}

@end
