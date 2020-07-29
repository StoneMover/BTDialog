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

- (NSString*)year;

- (NSString*)month;

- (NSString*)day;

- (NSString*)hour;

- (NSString*)minute;

- (NSString*)second;

//英文的周几字符串
- (NSString*)weekDay;

//数字周几，0是周日
- (NSInteger)weekDayNum;

//传入头部字符串如周和星期，如果传回周会返回周一、周二..周日等字符串，传星期会返回星期一、星期二..星期天字符串
- (NSString*)weekDayNumStrWithHead:(NSString*)head;

//计算年龄,生成当前date类,传入年月日即可
- (NSInteger)calculateAge:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

//是否是未来时间
- (BOOL)isFutureTime;

//得到距离系统当前时间的显示时间,比如一小时前,三分钟前,时间格式:yyyy-MM-dd HH:mm:ss
- (NSString*)dateFromNowStr;

//获取日期字符串
- (NSString*)dateStr:(NSString*)formater;

//是否是同年、同月、同日、同时、同分
- (BOOL)isSameMonthToDate:(NSDate*)date;

- (BOOL)isSameDayToDate:(NSDate*)date;

- (BOOL)isSameHourToDate:(NSDate*)date;

- (BOOL)isSameMinuteToDate:(NSDate*)date;

#pragma mark 根据出传入日期以及格式化样式获取date
//根据时区获取对应的date
+ (instancetype)initLocalDate;

//传入2010-01-01 这个字符串获取date
+ (NSDate*)dateYMD:(NSString*)dateStr;

//传入2010-01-01 13:04:34 这个字符串获取date
+ (NSDate*)dateYMDHMS:(NSString*)dateStr;

//传入2010-01-01 13:04 这个字符串获取date
+ (NSDate*)dateYMDHM:(NSString*)dateStr;

//传入日期,以及格式化样式获取date
+ (NSDate*)dateFromStr:(NSString*)dateStr formatter:(NSString*)formatterStr;

//获取时区时差秒数
+ (NSInteger)bt_timeZoneSeconods;

@end

NS_ASSUME_NONNULL_END
