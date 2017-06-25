//
//  TalkStory.h
//  destroy
//
//  Created by 尹楠 on 16/9/23.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "Story.h"

@interface TalkStory : Story

- (NSInteger)minutesPass;

@end

@interface CommonTalkStory : TalkStory

@end

@interface NoTalkStory : TalkStory

@end

@interface Talk0Story : CommonTalkStory

@end

@interface Talk1Story : CommonTalkStory

@end

@interface Talk2Story : CommonTalkStory

@end
