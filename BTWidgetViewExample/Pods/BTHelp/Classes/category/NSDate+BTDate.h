//
//  NSDate+BTDate.h
//  live
//
//  Created by stonemover on 2019/5/8.
//  Copyright © 2019 stonemover. All rights reserved.
//


/***
 
 G: 公元时代，例如AD公元
 yy: 年的后2位
 yyyy: 完整年
 MM: 月，显示为1-12
 MMM: 月，显示为英文月份简写,如 Jan
 MMMM: 月，显示为英文月份全称，如 Janualy
 dd: 日，2位数表示，如02
 d: 日，1-2位显示，如 2
 EEE: 简写星期几，如Sun
 EEEE: 全写星期几，如Sunday
 aa: 上下午，AM/PM
 H: 时，24小时制，0-23
 K：时，12小时制，0-11
 m: 分，1-2位
 mm: 分，2位
 s: 秒，1-2位
 ss: 秒，2位
 S：毫秒
 
 **/

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (BTDate)

- (NSString*)bt_year;

- (NSString*)bt_month;

- (NSString*)bt_day;

- (NSString*)bt_hour;

- (NSString*)bt_minute;

- (NSString*)bt_second;

//英文的周几字符串
- (NSString*)bt_weekDay;

//数字周几，0是周日
- (NSInteger)bt_weekDayNum;

//传入头部字符串如周和星期，如果传回周会返回周一、周二..周日等字符串，传星期会返回星期一、星期二..星期天字符串
- (NSString*)bt_weekDayNumStrWithHead:(NSString*)head;

//计算年龄,生成当前date类,传入年月日即可
- (NSInteger)bt_calculateAge:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

//是否是未来时间
- (BOOL)bt_isFutureTime;

//得到距离系统当前时间的显示时间,比如一小时前,三分钟前,时间格式:yyyy-MM-dd HH:mm:ss,仅限使用该分类生成对象使用
- (NSString*)bt_dateFromNowStr;

//获取日期字符串
- (NSString*)bt_dateStr:(NSString*)formater;

//是否是同年、同月、同日、同时、同分
- (BOOL)bt_isSameMonthToDate:(NSDate*)date;

- (BOOL)bt_isSameDayToDate:(NSDate*)date;

- (BOOL)bt_isSameHourToDate:(NSDate*)date;

- (BOOL)bt_isSameMinuteToDate:(NSDate*)date;

#pragma mark 根据出传入日期以及格式化样式获取date
//根据时区获取对应的date
+ (instancetype)bt_initLocalDate;

//传入2010-01-01 这个字符串获取date
+ (NSDate*)bt_dateYMD:(NSString*)dateStr;

//传入2010-01-01 13:04:34 这个字符串获取date
+ (NSDate*)bt_dateYMDHMS:(NSString*)dateStr;

//传入2010-01-01 13:04 这个字符串获取date
+ (NSDate*)bt_dateYMDHM:(NSString*)dateStr;

//传入日期,以及格式化样式获取date
+ (NSDate*)bt_dateFromStr:(NSString*)dateStr formatter:(NSString*)formatterStr;

//获取时区时差秒数
+ (NSInteger)bt_timeZoneSeconods;

/*
 由于调用系统方法会在原有的date上加8小时的秒数，调用这个会在在原有的秒数上减去时区的相差秒数，仅限校正时区后的date使用
 */
- (NSTimeInterval)bt_timeIntervalSince1970;

@end

NS_ASSUME_NONNULL_END
