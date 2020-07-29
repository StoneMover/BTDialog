//
//  NSDate+BTDate.m
//  live
//
//  Created by stonemover on 2019/5/8.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "NSDate+BTDate.h"

@implementation NSDate (BTDate)

- (NSString*)year{
    return [self dateStr:@"YYYY"];
}

- (NSString*)month{
    return [self dateStr:@"MM"];
}

- (NSString*)day{
    return [self dateStr:@"dd"];
}

- (NSString*)hour{
    return [self dateStr:@"HH"];
}

- (NSString*)minute{
    return [self dateStr:@"mm"];
}

- (NSString*)second{
    return [self dateStr:@"ss"];
}

- (NSString*)weekDay{
    return [self dateStr:@"EEEE"];
}

- (NSInteger)weekDayNum{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    comps = [calendar components:unitFlags fromDate:self];
    return [comps weekday] - 1;
}

- (NSString*)weekDayNumStrWithHead:(NSString*)head{
    NSInteger index = [self weekDayNum];
    NSArray * weekDayStrArray = nil;
    if ([head isEqualToString:@"周"]) {
        weekDayStrArray =  @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    }else{
        weekDayStrArray =  @[@"天",@"一",@"二",@"三",@"四",@"五",@"六"];
    }
    NSString * weekStr = weekDayStrArray[index];
    return [NSString stringWithFormat:@"%@%@",head,weekStr];
}

- (NSInteger)calculateAge:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    NSInteger age =[self year].integerValue-year;
    if (month>[self month].integerValue) {
        age--;
    }else if (month==[self month].integerValue){
        if (day>[self day].integerValue) {
            age--;
        }
    }
    
    return age;
}

- (BOOL)isFutureTime{
    NSDate *localeDate = [NSDate initLocalDate];
    if (self.timeIntervalSince1970 > localeDate.timeIntervalSince1970) {
        return YES;
    }
    return NO;
}


- (NSString*)dateFromNowStr{
    NSDate * d= self;
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    NSDate * dat = [NSDate initLocalDate];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSTimeInterval cha=now-late;
    int second=cha;
    int minute=second/60;
    int hour=minute/60;
    int day=hour/24;
    if (day!=0) {
        if (day>30) {
            return [NSString stringWithFormat:@"%d月前",day/30];
        }
        
        if (day>365) {
            return [NSString stringWithFormat:@"%d年前",day/365];
        }
        
        return [NSString stringWithFormat:@"%d天前",day];
    }
    if (hour!=0) {
        return [NSString stringWithFormat:@"%d小时前",hour];
    }
    if (minute!=0) {
        return [NSString stringWithFormat:@"%d分钟前",minute];
    }
    return @"刚刚";
}

- (NSString*)dateStr:(NSString*)formater{
    NSDateFormatter * formatter =[[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    formatter.dateFormat=formater;
    NSString * str = [formatter stringFromDate:self];
    return str;
}

- (BOOL)isSameMonthToDate:(NSDate*)date{
    NSString * strSelf = [self dateStr:@"YYYY-MM"];
    NSString * strDate = [date dateStr:@"YYYY-MM"];
    return [strSelf isEqualToString:strDate];
}

- (BOOL)isSameDayToDate:(NSDate*)date{
    NSString * strSelf = [self dateStr:@"YYYY-MM-dd"];
    NSString * strDate = [date dateStr:@"YYYY-MM-dd"];
    return [strSelf isEqualToString:strDate];
}

- (BOOL)isSameHourToDate:(NSDate*)date{
    NSString * strSelf = [self dateStr:@"YYYY-MM-dd HH"];
    NSString * strDate = [date dateStr:@"YYYY-MM-dd HH"];
    return [strSelf isEqualToString:strDate];
}

- (BOOL)isSameMinuteToDate:(NSDate*)date{
    NSString * strSelf = [self dateStr:@"YYYY-MM-dd HH:mm"];
    NSString * strDate = [date dateStr:@"YYYY-MM-dd HH:mm"];
    return [strSelf isEqualToString:strDate];
}

+ (instancetype)initLocalDate{
    NSDate * date = [[NSDate alloc] init];
    NSDate * localeDate = [date dateByAddingTimeInterval:[self bt_timeZoneSeconods]];
    return localeDate;
}

+ (NSDate*)dateYMD:(NSString*)dateStr{
    return [self dateFromStr:dateStr formatter:@"YYYY-MM-dd"];
}



+ (NSDate*)dateYMDHMS:(NSString*)dateStr{
    return [self dateFromStr:dateStr formatter:@"YYYY-MM-dd HH:mm:ss"];
}


+ (NSDate*)dateYMDHM:(NSString*)dateStr{
    return [self dateFromStr:dateStr formatter:@"YYYY-MM-dd HH:mm"];
}

+ (NSDate*)dateFromStr:(NSString*)dateStr formatter:(NSString*)formatterStr{
    NSDateFormatter * formatter =[[NSDateFormatter alloc] init];
    formatter.dateFormat=formatterStr;
    NSDate * date = [formatter dateFromString:dateStr];
    NSTimeZone * zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate * localeDate = [date dateByAddingTimeInterval: interval];
    return localeDate;
}


+ (NSInteger)bt_timeZoneSeconods{
    NSDate * date = [[NSDate alloc] init];
    NSTimeZone * zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    return interval;
}

@end
