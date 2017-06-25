//
//  CallForHelpStory.m
//  girl
//
//  Created by 尹楠 on 16/9/6.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "CallForHelpStory.h"
#import "Cutscene.h"
#import "NSString+Additions.h"

@implementation CallForHelpStory

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self addCutscenesWithCommandTexts:@[
                                             @"#c|手机铃声……|#w:2|#c|手机铃声……|#w:2|（接通了）",
                                             
                                             @"#pis:真吾_紧张|#c|真吾听到手机铃声赶过来了。",
                                             
                                             @"#mis:若叶_平常|#m|爸爸？",
                                             
                                             @"#c|若叶把手机的免提功能打开了。",
                                             
                                             @"#c|[男声] 若叶！|#w:0.2|我已经联系到景区负责人了！",
                                             
                                             @"#pis:真吾_大笑|#mis:若叶_微笑|#m|真的吗？|#w:0.2|那太好了！",
                                             
                                             @"#p|干得漂亮啊大叔！",
                   
                                             @"#c|[男声] 负责人说马上派人前往景区探查。|#w:0.3|，我把你的手机号码给了他|#w:0.3|，他会联系你的。",
                                             
                                             @"#m|嗯|#w:0.2|，我们等候他们的电话。",
                                             
                                             @"#c|[男声] 若叶|#w:0.3|，要坚持到救援啊。",
                                             
                                             @"#m|我会的|#w:0.2|#pis:真吾_紧张|，我还要和爸爸一起钓鱼呢。",
                                             
                                             @"#c|[男声] 若叶……",
                                             
                                             @"#c|电话另一边传来男子的哭泣声音。",
                                             
                                             @"#m|爸爸|#w:0.3|，不要难过|#w:0.3|，我要挂了。",
                                             
                                             @"#c|[男声] 好……|#w:0.2|好……|#w:0.2|（电话挂断了）",
                                             
                                             @"#mis:若叶_悲伤|#m|……",
                                             
                                             @"#p|若叶|#w:0.2|，振作起来|#w:0.2|，这是好消息！",
                                             
                                             @"#mis:若叶_微笑|#m|嗯……|#w:0.3|，我没事。",
                                             
                                             @"#pis:真吾_大笑|#p|我们是不是应该庆祝一下？",
                                             
                                             @"#m|哈哈。",
                                             ]];
        
    }
    return self;
}

+ (BOOL)isAvailable {

    NSDate *fireDate = [@"1987-02-11 19:05:00" datetimeValue];
    if (![[Game sharedGame] boolProperty:@"CallForHelpStory"] &&
        [[[Game sharedGame] time] earlierDate:fireDate] == fireDate &&
        [[Game sharedGame] boolProperty:@"BorrowMobilePhoneForContactStory"])
        return YES;
    else
        return NO;
}

- (void)storyEffect {
    
    
}

- (void)storyResult {
    
    [super storyResult];
    
    [[Game sharedGame] setProperty:@YES forKey:NSStringFromClass([self class])];
    [[Game sharedGame] dateProperty:@"time" plus:Minutes(6)];
    [[Game sharedGame] intProperty:@"batteryConsumption" plus:1];
    
    [[Person partner] setProperty:[[Person me] property:@"scene"] forKey:@"scene"];
    
    [[MainView sharedView] hideMyImageWithAnimation:YES];
    [[MainView sharedView] showPartnerImage:@"真吾_平常" animation:YES];
    [Message hideMessage];
}

@end

@implementation TalkCallForHelpStory

- (id)init {
    
    self = [super init];
    if (self) {
        
        [self addCutscenesWithCommandTexts:@[
                                             @"#mis:若叶_微笑|#m|太好了平良君……|#w:0.4|我们有救了！",
                                             
                                             @"#pis:真吾_大笑|#p|是啊！|#w:0.4|我们只要撑到救援队到来就行了。",
                                             
                                             @"#m|平良君有心事？",
                                             
                                             @"#pis:真吾_平常|#p|没|#w:0.3|，我只是想起了家人。",
                                             
                                             @"#mis:若叶_微笑|#m|我们还没有失去希望|#w:0.4|，这里一定有出口通向外面的。|#w:0.4|加油！",
                                             
                                             @"#p|恩。",
                                             ]];
    }
    return self;
}

- (NSInteger)minutesPass {
    
    return 1;
}

- (void)storyResult {
    
    [super storyResult];
    
    [[Game sharedGame] setProperty:@YES forKey:NSStringFromClass([self class])];
}

@end
