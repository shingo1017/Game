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
                                             @"#ic:黑色|东京时间 PM 18:35|#w:0.8| 日本|#w:0.8| 蝶彩山旅游景区|#w:0.8| 索道候车大厅某处……",
                                             
                                             @"#m|……|#w:0.8|……|#w:0.8|头|#w:0.8|……|#w:0.8|好疼。",
                                             
                                             @"#p|喂！|#w:0.8|…………|#w:0.8|喂！|#w:0.8|…………|#w:0.8|醒|#w:0.4|醒|#w:0.4|啊~！~！",
                                             
                                             @"#ic:休息室|#mis:若叶_害怕|#m|!!!!|#w:0.3|~!!!!!!!|#w:0.3|怎么回事？|#w:0.4|这里是哪儿？|#w:0.3|为什么头这么疼？",
                                             
                                             @"#pis:真吾_紧张|#p|你终于醒了。",
                                             
                                             @"#m|啊啊啊啊啊！！|#w:0.3|到底发生了什么事？！",
                                             
                                             @"#pis:真吾_生气|#p|你冷静点！|#w:0.4|冷静！",
                                             
                                             @"#pis:真吾_紧张|#p|我们被困了|#w:0.8|，我也是刚刚才醒过来|#w:0.5|，这里看起来是个休息室|#w:0.5|，我醒来的时候|#w:0.3|，你就在我身边。",
                                             
                                             @"#mis:若叶_悲伤|#m|这样|#w:0.6|，那……|#w:0.5|到底发生了什么事情？",
                                             
                                             @"#p|昏迷之前|#w:0.3|，我记忆中有过强烈的地震。",
                                             
                                             @"#p|今天中午时间|#w:0.4|，有广播通知所有游客离开景区|#w:0.4|，我没有离开|#w:0.5|…………",
                                             
                                             @"#p|大概下午3点|#w:0.4|，游客差不多走光了|#w:0.4|，我来到了这里|#w:0.4|，突然……|#w:0.4|地面开始晃动|#w:0.5|，站都站不稳了|#w:0.4|，慌乱中我躲在了一张桌子下面|#w:0.6|，后面的事就记不清楚了。",
                                             
                                             @"#m|哦……|#w:0.3|我也想起来了一点|#w:0.5|，当时我不知道发生了什么事|#w:0.4|，地面在震动|#w:0.3|，窗户都碎了。",
                                             
                                             @"#p|对……|#w:0.4|然后我感觉被桌子压倒了|#w:0.4|，昏迷了过去|#w:0.5|。现在看来|#w:0.2|，我们应该是从上面一层的大厅掉下来的|#w:0.5|，你看上面的天花板都已经完全坍塌了。",
                                             @"#m|原来是这样……|#w:0.5|那……|#w:0.3|我们现在怎么出去？",
                                             ]];
        
        [self addCutsceneWithCommandText:@"#p|总之先找找有没有出口吧……|#w:0.5|你身体怎么样？|#w:0.3|可以动吗？"
                        actionClassNames:@[@"TutorialStoryCanMoveAction", @"TutorialStoryCanNotMoveAction"]];
        
        [self addSubCutscenesWithCommandTexts:@[
                                                @"#mis:若叶_平常|#m|我没问题。",
                                                
                                                @"#pis:真吾_大笑|#p|OK|#w:0.5|，那我们分头去找出口。",
                                                
                                                @"#m|好。",
                                                
                                                @"#p|嘿！",
                                                
                                                @"#m|嗯？",
                                                
                                                @"#p|打起精神来！|#w:0.5|我们还有希望！",
                                                
                                                @"#mis:若叶_微笑|#m|嗯！",
                                                ]
                              actionClassName:@"TutorialStoryCanMoveAction"];
        
        [self addSubCutscenesWithCommandTexts:@[
                                                @"#m|我头疼死啦，动不了。",
                                                
                                                @"#p|哦……|#w:0.5|，可能是掉下来的时候碰到了。",
                                                
                                                @"#pis:真吾_疑虑|#p|那你休息吧，我去找出口。",
                                                
                                                @"#m|嗯。",
                                                ]
                              actionClassName:@"TutorialStoryCanNotMoveAction"];
        
        //设置剧情结束后跳转到的场景
        self.sceneClassNameWhenEndOfStory = @"LoungeScene";
    }
    return self;
}

- (void)storyEffect {
    
    
}

- (void)storyResult {
    
    /*NSString *dateString = @"1987-02-11 17:45:00";
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-DD HH:mm:ss"];
    NSDate *currentDate = [dateFormater dateFromString:dateString];*/
    
    [super storyResult];
    
    [[Game sharedGame] setProperty:@YES forKey:NSStringFromClass([self class])];
    [[Game sharedGame] setProperty:[@"1987-02-11 17:45:00" datetimeValue] forKey:@"time"];
    [[Game sharedGame] setProperty:[@"1987-02-11 08:00:00" datetimeValue] forKey:@"lastSleepTime"];
    
    [[MainView sharedView] showTime];
    [[MainView sharedView] hideMyImageWithAnimation:YES];
    [[MainView sharedView] hidePartnerImageWithAnimation:YES];
    [Message hideMessage];
}

@end
