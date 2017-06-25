//
//  Message.m
//  girl
//
//  Created by 尹楠 on 16/9/6.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "Message.h"

#define DEFAULT_TIMEINTERVAL   0.1f

static NSMutableArray *_messages;

@implementation Message

+ (NSArray *)messages {
    
    return _messages;
}

+ (Message *)lastMessage {
    
    return [_messages lastObject];
}

+ (void)clearMessages {
    
    [MainViewClass sharedView].messageLabel.text = @"";
}

+ (void)hideMessage {
    
    [MainViewClass sharedView].messageLabel.text = @"";
    [MainViewClass sharedView].messageContainerView.hidden = YES;
}

+ (void)appendText:(NSString *)text {
    
    [Message appendText:text displayDirectly:NO];
}

+ (void)appendText:(NSString *)text displayDirectly:(BOOL)displayDirectly {
    
    Message *message = [[Message alloc] init];
    message.text = text;
    message.displayDirectly = displayDirectly;
    
    if (!_messages)
        _messages = [[NSMutableArray alloc] init];
    
    [_messages addObject:message];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_MESSAGE_NOTIFICATION object:nil];
}

@end
