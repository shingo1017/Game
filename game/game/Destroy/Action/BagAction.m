//
//  BagAction.m
//  destroy
//
//  Created by 尹楠 on 16/9/26.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "BagAction.h"
#import "Bag.h"

@implementation BagAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        self.name = @"背 包";
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadBagItemActions) name:K_SHOULD_RELOAD_BAGITEMACTIONS_NOTIFICATION object:nil];
    }
    return self;
}

- (NSString *)parentActionName {
    
    return nil;
}

- (BOOL)isAvailable {
    
    return [[Game sharedGame] boolProperty:@"CheckOverStory"];
}

- (void)actionResult {
    
    [Message clearMessages];
    [Message appendText:@"若叶的背包空空如也。"];
}

- (void)reloadBagItemActions {
    
    [self setValue:[Action actionsWithBagItems] forKey:@"actions"];
}

@end

@implementation BagItemAction

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        self.belongToClassNames = @[@"LoungeScene", @"ToolhouseScene", @"InfirmaryScene"];
    }
    return self;
}

- (NSString *)parentActionName {
    
    return nil;
}

- (BOOL)isAvailable {
    
    if ([[Bag sharedBag] hasItemWithItemKey:[self property:@"itemKey"]])
        return YES;
    else
        return NO;
}

- (void)actionResult {
    
    [[ItemView sharedView] showWithItemKey:[self property:@"itemKey"]];
}

@end
