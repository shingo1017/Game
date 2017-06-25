//
//  TutorialStory.m
//  girl
//
//  Created by 尹楠 on 16/9/6.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "TutorialStory.h"
#import "Cutscene.h"
#import "Sakura.h"
#import "Shingo.h"

@implementation FactoryInsideTutorialStory

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [Person setMe:[[Sakura alloc] init]];
        [Person setPartner:[[Shingo alloc] init]];
        
        NSMutableArray *cutscenes = [[NSMutableArray alloc] init];
        
        NSArray *commandTexts;
        commandTexts = @[
                         /*@"#ic:黑色|#m|……|#w:0.8|……|#w:0.8|头|#w:0.8|……|#w:0.8|好疼。",
                         
                         @"#p|喂！|#w:0.8|…………|#w:0.8|喂！|#w:0.8|…………|#w:0.8|醒|#w:0.4|醒|#w:0.4|啊~！~！",
                         */
                         @"#ic:密室|#mis:樱_害怕|#m|!!!!|#w:0.3|~!!!!!!!|#w:0.3|怎么回事？|#w:0.4|这里是哪儿？|#w:0.3|为什么头这么疼？",
                         
                         @"#pis:真吾_紧张|#p|我靠|#w:0.4|，你终于醒了。",
                         
                         @"#m|啊啊啊啊啊！！|#w:0.3|到底发生了什么事？！",
                         
                         @"#pis:真吾_生气|#p|你冷静点！|#w:0.4|冷静！",
                         
                         @"#pis:真吾_紧张|#p|我们被困了|#w:0.8|，我也是刚刚才醒过来|#w:0.5|，这里看起来是个仓库|#w:0.5|，我醒来的时候|#w:0.3|，你就在我身边。",
                         
                         @"#mis:樱_悲伤|#m|这样|#w:0.6|，那……|#w:0.5|到底发生了什么事情？",
                         
                         @"#p|昏迷之前|#w:0.3|，我记忆中有过强烈的地震。",
                         
                         @"#p|今天下午时间|#w:0.4|，我在逛超级市场|#w:0.4|，打算买点泡面回去|#w:0.4|，突然……|#w:0.4|地面开始晃动|#w:0.5|，人们都吓坏了|#w:0.4|，慌乱中我躲在了一张桌子下面。",
                         
                         @"#m|哦……|#w:0.3|我也想起来了一点|#w:0.5|，当时我不知道发生了什么事|#w:0.4|，地面在震动|#w:0.3|，窗户都碎了。",
                         
                         @"#p|对……|#w:0.4|然后我感觉被桌子压倒了|#w:0.4|，昏迷了过去|#w:0.5|。现在看来|#w:0.2|，我们应该是从上面一层掉下来的|#w:0.5|，你看上面的天花板都已经完全坍塌了。",
                         
                         @"#m|原来是这样……|#w:0.5|那……|#w:0.3|我们现在怎么出去？",
                         
                         @"#p|总之先找找有没有出口吧……|#w:0.5|你身体怎么样？|#w:0.3|可以动吗？",
                         ];
        
        for (NSString *commandText in commandTexts) {
            
            [cutscenes addObject:[Cutscene cutsceneWithCommandText:commandText]];
        }
        
        self.cutscenes = cutscenes;
        self.sceneClassNameWhenEndOfStory = @"BasementScene";
    }
    return self;
}

- (void)storyEffect {
    
    
}

@end
