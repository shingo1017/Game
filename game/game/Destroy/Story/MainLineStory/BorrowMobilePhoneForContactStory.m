//
//  BorrowMobilePhoneForContactStory.m
//  girl
//
//  Created by 尹楠 on 16/9/6.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "BorrowMobilePhoneForContactStory.h"
#import "Cutscene.h"
#import "NSString+Additions.h"

@implementation BorrowMobilePhoneForContactStory

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self addCutscenesWithCommandTexts:@[
                                             @"#pis:真吾_平常|#p|若叶……",
                                             
                                             @"#mis:若叶_平常|#m|什么事？",
                                             
                                             @"#p|我可以借用你的手机吗?",
                                             
                                             @"#m|啊！|#w:0.2|你的家人还不知道你的情况|#w:0.3|，快告诉他们吧。",
                                             
                                             @"#c|若叶将手机交给了真吾。",
                   
                                             @"#c|#pih|真吾往家里打了一通电话。",
                                             
                                             @"#pis:真吾_平常|#p|好了|#w:0.3|，我打完了|#w:0.3|，手机还给你。",
                                             
                                             @"#pis:真吾_大笑|#p|谢谢！",
                                             
                                             @"#mis:若叶_微笑|#m|不客气。",
                                             ]];
        
    }
    return self;
}

+ (BOOL)isAvailable {

    NSDate *fireDate = [@"1987-02-11 18:23:00" datetimeValue];
    if (![[Game sharedGame] boolProperty:@"BorrowMobilePhoneForContactStory"] &&
        [[[Game sharedGame] time] earlierDate:fireDate] == fireDate &&
        [[Game sharedGame] boolProperty:@"CheckOverStory"])
        return YES;
    else
        return NO;
}

- (void)storyResult {
    
    [super storyResult];
    
    [[Game sharedGame] setProperty:@YES forKey:NSStringFromClass([self class])];
    [[Game sharedGame] dateProperty:@"time" plus:Minutes(3)];
    [[Game sharedGame] intProperty:@"batteryConsumption" plus:1];
    
    [[Person partner] setProperty:[[Person me] property:@"scene"] forKey:@"scene"];
    [[Person me] setProperty:@2 forKey:@"talkLimit"];
    
    [[MainView sharedView] hideMyImageWithAnimation:YES];
    [[MainView sharedView] showPartnerImage:@"真吾_平常" animation:YES];
    [Message hideMessage];
}

@end

@implementation TalkBorrowMobilePhoneForContactStory

- (id)init {
    
    self = [super init];
    if (self) {
        
        [self addCutscenesWithCommandTexts:@[
                                             @"#mis:若叶_悲伤|#m|平良君……|#w:0.5|你的家人一定也很焦急吧？",
                                             
                                             @"#pis:真吾_疑虑|#p|……|#w:0.3|……|#w:0.3|……",
                                             
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
