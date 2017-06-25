//
//  FirstNightStory.m
//  girl
//
//  Created by 尹楠 on 16/9/6.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "FirstNightStory.h"
#import "Cutscene.h"
#import "Sakura.h"
#import "Shingo.h"
#import "NSString+Additions.h"

@implementation FirstNightStory

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self addCutscenesWithCommandTexts:@[
                                             @"#pis:真吾_紧张|#p|时间不早了。",
                                             
                                             @"#mis:若叶_悲伤|#m|没有。",
                                             
                                             @"#p|我刚才去了另一边|#w:0.3|，也没有出口。",
                                             
                                             @"#m|就是说|#w:0.4|，我们出不去了吗……",
                                             
                                             @"#pis:真吾_苦笑|#p|不……|#w:0.3|不会的|#w:0.5|，我们还可以用手机联系外面的人啊。",
                                             
                                             @"#mis:若叶_微笑|#m|对啊！|#w:0.5|我的手机……|#w:0.5|……|#w:0.5|在这里！",
                                             
                                             @"#pis:真吾_大笑|#p|YES！",
                                             
                                             @"#mis:若叶_悲伤|#pis:真吾_紧张|#c|呼叫中……|#w:2|#c|呼叫中……|#w:2|#c|呼叫中……|#w:1|（接通了）",
                                             
                                             @"#c|[男声] 若叶！|#w:0.2|#mis:若叶_害怕|若叶你没事吧！！",
                                             
                                             @"#pis:真吾_惊讶|#m|爸爸！|#w:0.3|爸爸！|#w:0.2|我有事啊！|#w:0.3|刚刚发生地震了|#w:0.2|，我现在被困在了蝶彩山的……|#w:0.3|索道间里了。|#w:0.3|这里没有出口。",
                                             
                                             @"#c|[男声] 若叶！|#mis:若叶_悲伤|#w:0.3|你有受伤吗？",
                                             
                                             @"#m|没有太大的问题|#w:0.4|，就是头有点疼。",
                                             
                                             @"#c|[男声] 你那里怎么样！？|#w:0.3|只有你独自在里面吗！？",
                                             
                                             @"#m|不知道樱在哪里|#w:0.3|，我找不到她|#w:0.4|，不过这里有个男生和我在一起……",
                                             
                                             @"#c|真吾抢过若叶的电话|#w:0.5|#pis:真吾_生气|#p|喂！|#w:0.3|大叔！|#w:0.3|到底发生了什么事情！？",
                                             
                                             @"#c|[男声] 就在刚刚|#w:0.3|新闻播报蝶彩山景区在今天下午3点多时发生了严重的山体滑坡！|#w:0.5|若叶！若叶啊！",
                                             
                                             @"#p|大叔！|#w:0.3|现在外面是什么情况？",
                                             
                                             @"#c|[男声] 景区负责人对外说……|#w:0.2|说此次事故没有造成人员伤亡|#w:0.3|他……|#w:0.2|他们关闭了景区等灾难过去再着手进行修缮工作。",
                                             
                                             @"#pis:真吾_疑虑|#p|该死！|#w:0.2|他们不知道这里有人被困了！",
                                             
                                             @"#c|[男声] 我……|#w:0.2|我去告诉他们你们被困在里面|#w:0.2|，叫他们马上救人！",
                                             
                                             @"#m|爸爸……",
                                             
                                             @"#c|[男声] 年轻人……|#pis:真吾_紧张|#w:0.4|若叶|#w:0.1|就拜托你照顾了|#w:0.2|，我会尽全力让人来救你们|#w:0.5|，一定要坚持住啊。",
                                             
                                             @"#pis:真吾_生气|#p|动作要快啊！！",
                                             
                                             @"#mis:若叶_害怕|#m|爸爸！|#w:0.3|我好害怕！",
                                             
                                             @"#c|[男声] 若叶！|#w:0.4|#mis:若叶_悲伤|爸爸一定会去救你的！|#w:0.3|你要坚强啊！",
                                             
                                             @"#m|好……|#w:0.3|我会坚持下去|#w:0.2|，直到有人来救我。",
                                             
                                             @"#c|(电话挂断了)",
                                             
                                             @"#p|…………|#w:0.4|#pis:真吾_生气|好吧|#w:0.2|，听我说|#w:0.4|，景区还不知道我们被困了|#w:0.3|，大叔去找人救我们|#w:0.2|，也要花些时间|#w:0.3|，在这段时间里|#w:0.3|，我们要努力地活下去。",
                                             
                                             @"#pis:真吾_凝视|#p|你的手机现在还剩余多少电量？",
                                             
                                             [NSString stringWithFormat:@"#m|嗯……|#w:0.3|%i%%", BATTERY],
                                             
                                             @"#pis:真吾_生气|#p|首先|#w:0.4|，手机平常的时候不要使用|#w:0.3|，尽量保持电量充足|#w:0.3|，营救过程中会派上大用场。",
                                             
                                             @"#mis:若叶_平常|#m|你的手机呢？",
                                             
                                             @"#pis:真吾_凝视|#p|摔坏了。",
                                             
                                             @"#m|哦……",
                                             
                                             @"#pis:真吾_紧张|#p|然后是食物问题|#w:0.4|，你那里有多少吃的？",
                                             
                                             @"#m|我看看……|#w:0.8|，还有三根巧克力棒……|#w:0.4|两包薯片……|#w:0.4|四颗果冻……|#w:0.2|，和两瓶矿泉水。",
                                             //@"#p|这些食物足够我们支撑7天|#w:0.4|，希望他们能快点……",
                                             ]];
        
        [self addCutsceneWithCommandText:@"#p|我有一块面包|#w:0.2|，一根火腿|#w:0.2|，和一瓶矿泉水。"
                        actionClassNames:@[@"CheckOverStoryShareAction", @"CheckOverStoryNotShareAction"]];
        
        [self addSubCutscenesWithCommandTexts:@[
                                                @"#mis:若叶_微笑|#m|我吃得少，我可以分给你一些。",
                                                
                                                @"#pis:真吾_惊讶|#p|啊……|#w:0.5|#pis:真吾_大笑|那就先谢谢你了|#w:0.2|，若叶。",
                                                
                                                @"#m|没关系。",
                                                ]
                              actionClassName:@"CheckOverStoryShareAction"];
        
        [self addSubCutscenesWithCommandTexts:@[
                                                @"#m|哦……",
                                                ]
                              actionClassName:@"CheckOverStoryNotShareAction"];
        
        [self addCutscenesWithCommandTexts:@[
                                             @"#mis:若叶_平常|#pis:真吾_紧张|#p|这些食物足够我们支撑7天|#w:0.4|，希望他们能快一点……",
                                             
                                             @"#pis:真吾_平常|#p|然后|#w:0.3|，我们要对这里进行彻底的搜索|#w:0.2|，看看有没有吃的东西|#w:0.3|，或者还有其他出口的可能性。",
                                             
                                             @"#m|嗯|#w:0.3|，我知道了。",
                                             
                                             @"#pis:真吾_惊讶|#p|你的头好些了吗？",
                                             
                                             @"#mis:若叶_微笑|#m|嗯|#w:0.3|，好一些了。",
                                             
                                             @"#pis:真吾_大笑|#p|那我们分头行动吧！",
                                             
                                             @"#m|嗯！",
                                             ]];
        
        self.sceneClassNameWhenEndOfStory = @"InfirmaryScene";
    }
    return self;
}

+ (BOOL)isAvailable {
    
    NSDate *fireDate = [@"1987-02-11 21:02:00" datetimeValue];
    if (![[Game sharedGame] boolProperty:@"FirstNightStory"] &&
        [[[Game sharedGame] time] earlierDate:fireDate] == fireDate &&
        [[Game sharedGame] boolProperty:@"CallForHelpStory"])
        return YES;
    else
        return NO;
}

- (void)storyResult {
    
    [super storyResult];
    
    [[Game sharedGame] setProperty:@YES forKey:NSStringFromClass([self class])];
    [[Game sharedGame] dateProperty:@"time" plus:Minutes(15)];
    
    [[Person partner] setProperty:@"InfirmaryScene" forKey:@"scene"];
    
    [[MainView sharedView] hideMyImageWithAnimation:YES];
    [[MainView sharedView] showPartnerImage:@"真吾_平常" animation:YES];
    [Message hideMessage];
}

@end
