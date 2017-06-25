//
//  TimeGoingOn.h
//  zombie
//
//  Created by 尹楠 on 17/6/2.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeGoingOn : NSObject

//@property (nonatomic, assign) NSInteger hoursPass;
@property (nonatomic, strong) NSMutableDictionary *settlementData;
@property (nonatomic, strong) NSMutableArray *resultTexts;

+ (TimeGoingOn *)sharedInstance;

- (void)Settlement;
- (void)settlementWithSurvivors:(NSArray *)survivors staminaOffset:(NSInteger)staminaOffset;

@end
