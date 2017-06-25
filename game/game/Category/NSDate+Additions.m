//
//  NSDate+Additions.m
//  It'sMyCoupon
//
//  Created by Shingo Yabuki on 12-6-4.
//  Copyright (c) 2012年 c2y. All rights reserved.
//

#import "NSDate+Additions.h"

@implementation NSDate (Additions)

+ (NSDate *)now {
    
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *now = [date dateByAddingTimeInterval:interval];
    return now;
}

- (NSDate *)addMinutes:(NSInteger)minutes {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitMinute fromDate:self];
    [comps setMinute:([comps minute] + minutes)];
    return [calendar dateFromComponents:comps];
}

- (NSDate *)addDays:(NSInteger)days {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:0xff fromDate:self];
    [comps setDay:([comps day]+ days)];
    return [calendar dateFromComponents:comps];
}

- (NSInteger)hoursToDate:(NSDate *)date {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comp = [calendar components:NSCalendarUnitHour
                                         fromDate:self
                                           toDate:date
                                          options:NSCalendarWrapComponents];
    
    return comp.hour;
}

- (NSString *)onlineDateFormattedString {
    
    NSString *formattedString;
    
    //NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //NSInteger interval = [zone secondsFromGMTForDate:[NSDate date]];
    //NSDate *now = [[NSDate date] dateByAddingTimeInterval:interval];
    NSDate *now = [NSDate date];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *nowComponents = [cal components:unitFlags fromDate:now];
    NSDateComponents *components = [cal components:unitFlags fromDate:self];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *today = [formatter dateFromString:[NSString stringWithFormat:@"%i-%i-%i 00:00:00", nowComponents.year, nowComponents.month, nowComponents.day]];
    //today = [today dateByAddingTimeInterval:3600*8];
    
    int secDiffInterval = [now timeIntervalSinceDate:self];
    int minDiffInterval = secDiffInterval / 60;
    int hourDiffInterval = minDiffInterval / 60;
    int secDiffIntervalSinceToday = [today timeIntervalSinceDate:self];
    if (minDiffInterval < 1) {
        //小于1分钟
        formattedString = [NSString stringWithFormat:@"%i秒钟前", secDiffInterval];
    }
    else if (hourDiffInterval < 1) {
        //小于1小时
        formattedString = [NSString stringWithFormat:@"%i分钟前", minDiffInterval];
    }
    else if (hourDiffInterval < 24) {
        
        //小于1天
        formattedString = [NSString stringWithFormat:@"%i小时前", hourDiffInterval];
    }
    else if (secDiffIntervalSinceToday > 0 && secDiffIntervalSinceToday < 3600*24) {
        
        //昨天
        formattedString = [NSString stringWithFormat:@"昨天 %i:%i", components.hour, components.minute];
    }
    else {
        
        formattedString = [NSString stringWithFormat:@"%i月%i日", components.month, components.day];
    }
    
    return formattedString;
}

- (NSString *)stringValue {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *destDateString = [formatter stringFromDate:self];
    return destDateString;
}

- (NSString *)timeString {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *destDateString = [formatter stringFromDate:self];
    return destDateString;
}

- (NSInteger)season {
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSMonthCalendarUnit;
    NSDateComponents *components = [cal components:unitFlags fromDate:self];
    if (components.month >= 1 && components.month <=3)
        return 1;
    else if (components.month >= 4 && components.month <=6)
        return 2;
    else if (components.month >= 6 && components.month <=9)
        return 3;
    else if (components.month >= 9 && components.month <=12)
        return 4;
    return 0;
}

- (NSInteger)age {
    
    NSTimeInterval dateDiff = [self timeIntervalSinceNow];
    int age = trunc(dateDiff / (60 * 60 * 24)) / 365 * -1;
    return age;
}

- (NSString *)constellation {
    
    NSString *retStr=@"";
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM"];
    int i_month=0;
    NSString *theMonth = [dateFormat stringFromDate:self];
    if([[theMonth substringToIndex:0] isEqualToString:@"0"]){
        i_month = [[theMonth substringFromIndex:1] intValue];
    }else{
        i_month = [theMonth intValue];
    }
    
    [dateFormat setDateFormat:@"dd"];
    int i_day=0;
    NSString *theDay = [dateFormat stringFromDate:self];
    if([[theDay substringToIndex:0] isEqualToString:@"0"]){
        i_day = [[theDay substringFromIndex:1] intValue];
    }else{
        i_day = [theDay intValue];
    }
    /*
     摩羯座 12月22日------1月19日
     水瓶座 1月20日-------2月18日
     双鱼座 2月19日-------3月20日
     白羊座 3月21日-------4月19日
     金牛座 4月20日-------5月20日
     双子座 5月21日-------6月21日
     巨蟹座 6月22日-------7月22日
     狮子座 7月23日-------8月22日
     处女座 8月23日-------9月22日
     天秤座 9月23日------10月23日
     天蝎座 10月24日-----11月21日
     射手座 11月22日-----12月21日
     */
    switch (i_month) {
        case 1:
            if(i_day>=20 && i_day<=31){
                retStr=@"水瓶座";
            }
            if(i_day>=1 && i_day<=19){
                retStr=@"摩羯座";
            }
            break;
        case 2:
            if(i_day>=1 && i_day<=18){
                retStr=@"水瓶座";
            }
            if(i_day>=19 && i_day<=31){
                retStr=@"双鱼座";
            }
            break;
        case 3:
            if(i_day>=1 && i_day<=20){
                retStr=@"双鱼座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=@"白羊座";
            }
            break;
        case 4:
            if(i_day>=1 && i_day<=19){
                retStr=@"白羊座";
            }
            if(i_day>=20 && i_day<=31){
                retStr=@"金牛座";
            }
            break;
        case 5:
            if(i_day>=1 && i_day<=20){
                retStr=@"金牛座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=@"双子座";
            }
            break;
        case 6:
            if(i_day>=1 && i_day<=21){
                retStr=@"双子座";
            }
            if(i_day>=22 && i_day<=31){
                retStr=@"巨蟹座";
            }
            break;
        case 7:
            if(i_day>=1 && i_day<=22){
                retStr=@"巨蟹座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=@"狮子座";
            }
            break;
        case 8:
            if(i_day>=1 && i_day<=22){
                retStr=@"狮子座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=@"处女座";
            }
            break;
        case 9:
            if(i_day>=1 && i_day<=22){
                retStr=@"处女座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=@"天秤座";
            }
            break;
        case 10:
            if(i_day>=1 && i_day<=23){
                retStr=@"天秤座";
            }
            if(i_day>=24 && i_day<=31){
                retStr=@"天蝎座";
            }
            break;
        case 11:
            if(i_day>=1 && i_day<=21){
                retStr=@"天蝎座";
            }
            if(i_day>=22 && i_day<=31){
                retStr=@"射手座";
            }
            break;
        case 12:
            if(i_day>=1 && i_day<=21){
                retStr=@"射手座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=@"摩羯座";
            }
            break;
    }
    return retStr;
}


@end
