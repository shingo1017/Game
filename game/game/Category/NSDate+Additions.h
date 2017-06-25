//
//  NSDate+Additions.h
//  It'sMyCoupon
//
//  Created by Shingo Yabuki on 12-6-4.
//  Copyright (c) 2012年 c2y. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Additions)

+ (NSDate *)now;
- (NSDate *)addMinutes:(NSInteger)minutes;
- (NSDate *)addDays:(NSInteger)days;
- (NSInteger)hoursToDate:(NSDate *)date;
- (NSString *)onlineDateFormattedString;
- (NSString *)timeString;
- (NSString *)stringValue;
- (NSInteger)season;
- (NSInteger)age;
- (NSString *)constellation;
@end
