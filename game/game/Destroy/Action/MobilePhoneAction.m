//
//  MobilePhoneAction.m
//  destroy
//
//  Created by 尹楠 on 16/9/24.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "MobilePhoneAction.h"

@implementation MobilePhoneAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        self.name = @"手 机";
        self.belongToClassNames = @[@"LoungeScene", @"ToolhouseScene", @"InfirmaryScene"];
    }
    return self;
}

- (NSString *)parentActionName {
    
    return nil;
}

- (BOOL)isAvailable {
    
    return [[Game sharedGame] boolProperty:@"CheckOverStory"];
}

@end

@implementation BatteryAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        self.name = @"查看电量";
    }
    return self;
}

- (BOOL)isAvailable {
    
    return YES;
}

- (void)actionResult {
    
    NSInteger battery = BATTERY - [[Game sharedGame] hoursPass] * 0.1;
    battery -= [[Game sharedGame] intProperty:@"batteryConsumption"];
    
    [Message clearMessages];
    [Message appendText:[NSString stringWithFormat:@"手机剩余电量：%li%%", battery]];
    
    //测试
    //NSLog(@"第%li天", [[Game sharedGame] daysPass]);
}

@end
