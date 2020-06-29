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
- (NSString*)phoneEncrypt;

//是否全部为数字
- (BOOL)isStrAllNumber;

//加密&解密
- (NSString*)base64Decode;

- (NSString*)base64Encode;

- (NSString*)md5;

//计算文字高度、宽度
- (CGFloat)calculateStrHeight:(CGFloat)width font:(UIFont*)font;

- (CGFloat)calculateStrHeight:(CGFloat)width font:(UIFont*)font lineSpeace:(CGFloat)lineSpeace;

- (CGFloat)calculateStrWidth:(CGFloat)height font:(UIFont*)font;

//将字典转为字符串
- (nullable NSDictionary *)toDict;

- (nullable NSArray *)toArray;

@end

NS_ASSUME_NONNULL_END
