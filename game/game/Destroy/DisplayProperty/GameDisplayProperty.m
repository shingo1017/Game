//
//  GameDisplayProperty.m
//  destroy
//
//  Created by 尹楠 on 16/9/23.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "GameDisplayProperty.h"
#import "NSString+Additions.h"
#import "NSDate+Additions.h"

@implementation TimeProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"TimeGroup"];
        self.caption = @"时 间";
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Game.time";
        //self.notificationKeyPaths = @[@"Game.time"];
        self.sort = 0;
    }
    return self;
}

- (NSString *)displayText {
    
    NSDate *datetime = [[Game sharedGame] property:@"time"];
    return [datetime timeString];
}

@end
