//
//  NSString+BTString.h
//  BTHelpExample
//
//  Created by apple on 2020/6/28.
//  Copyright © 2020 stonemover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (BTString)

//返回156*****8016电话
- (NSString*)bt_phoneEncrypt;

//是否全部为数字
- (BOOL)bt_isStrAllNumber;

//是否为浮点型数据
- (BOOL)bt_isPureFloat;

//加密&解密
- (NSString*)bt_base64Decode;

- (NSString*)bt_base64Encode;

- (NSString*)bt_md5;

//计算文字高度,传入文字的固定高度、字体、行间距参数
- (CGFloat)bt_calculateStrHeight:(CGFloat)width font:(UIFont*)font;

- (CGFloat)bt_calculateStrHeight:(CGFloat)width font:(UIFont*)font lineSpeace:(CGFloat)lineSpeace;

//计算文字宽度，传入文字的固定高度
- (CGFloat)bt_calculateStrWidth:(CGFloat)height font:(UIFont*)font;

//将字典转为字符串
- (nullable NSDictionary *)bt_toDict;

- (nullable NSArray<NSDictionary *> *)bt_toArray;

//获取domain（ip）
- (nullable NSString*)bt_host;

- (NSDictionary*)bt_urlParameters;

+ (NSString*)bt_randomStr;

+ (NSString *)bt_randomStrWithLenth:(NSInteger)lenth;

+ (NSString *)bt_randomNumStrWithLenth:(NSInteger)lenth;

+ (NSString *)bt_randomCapitalStrWithLenth:(NSInteger)lenth;

+ (NSString *)bt_randomLowercaseStrWithLenth:(NSInteger)lenth;

+ (NSString *)bt_randomStrWithLenth:(NSInteger)lenth isNumber:(BOOL)isNumber isCapital:(BOOL)isCapital isLowercase:(BOOL)isLowercase;

@end

NS_ASSUME_NONNULL_END
