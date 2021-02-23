//
//  NSString+BTString.m
//  BTHelpExample
//
//  Created by apple on 2020/6/28.
//  Copyright © 2020 stonemover. All rights reserved.
//

#import "NSString+BTString.h"
#import "BTUtils.h"
#import<CommonCrypto/CommonDigest.h>
#import "NSDate+BTDate.h"

@implementation NSString (BTString)

- (NSString*)bt_phoneEncrypt{
    if (self.length != 11) {
        return @"";
    }
    
    NSString * str = [self stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    return str;
}

- (BOOL)bt_isStrAllNumber{
    if ([BTUtils isEmpty:self]) {
        return NO;
    }
    
    NSString * checkedNumString = [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedNumString.length > 0) {
        return NO;
    }
    return YES;
}

- (BOOL)bt_isPureFloat{
    if ([BTUtils isEmpty:self]) {
        return NO;
    }
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}


//加密&解密
- (NSString*)bt_base64Decode{
    NSData * data = [[NSData alloc]initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString * string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}

- (NSString*)bt_base64Encode{
    NSData * data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString * base64String = [data base64EncodedStringWithOptions:0];
    return base64String;
}

- (NSString*)bt_md5{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        [output appendFormat:@"%02x", digest[i]];
    }
    return  output;
}


- (CGFloat)bt_calculateStrHeight:(CGFloat)width font:(UIFont*)font{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    CGSize labelSize =[self boundingRectWithSize:CGSizeMake(width, 1500) options:NSStringDrawingUsesLineFragmentOrigin  attributes:dic context:nil].size;
    return labelSize.height;
}

- (CGFloat)bt_calculateStrHeight:(CGFloat)width font:(UIFont*)font lineSpeace:(CGFloat)lineSpeace{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = lineSpeace;
    NSDictionary * dic =@{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle};
    
    CGSize labelSize =[self boundingRectWithSize:CGSizeMake(width, 1500) options:NSStringDrawingUsesLineFragmentOrigin  attributes:dic context:nil].size;
    return labelSize.height;
}


- (CGFloat)bt_calculateStrWidth:(CGFloat)height font:(UIFont*)font{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    CGSize labelSize =[self boundingRectWithSize:CGSizeMake(1500, height) options:NSStringDrawingUsesLineFragmentOrigin  attributes:dic context:nil].size;
    return labelSize.width;
}


- (nullable NSDictionary *)bt_toDict{
    NSData * jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError * err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

- (nullable NSArray<NSDictionary *> *)bt_toArray{
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray * array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return array;
}

- (nullable NSString*)bt_host{
    NSURL * url = [NSURL URLWithString:self];
    return url.host;
}

- (NSDictionary*)bt_urlParameters{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:self];
    [urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [params setObject:obj.value forKey:obj.name];
    }];
    
    return params;
}

+ (NSString*)bt_randomStr{
    NSString * randomStr = [self bt_randomStrWithLenth:16];
    NSDate * date = [NSDate bt_initLocalDate];
    randomStr = [NSString stringWithFormat:@"%@%.0f",randomStr,date.bt_timeIntervalSince1970];
    return randomStr;
}


+ (NSString *)bt_randomStrWithLenth:(NSInteger)lenth{
    return [self bt_randomStrWithLenth:lenth isNumber:YES isCapital:YES isLowercase:YES];
}

+ (NSString *)bt_randomNumStrWithLenth:(NSInteger)lenth{
    return [self bt_randomStrWithLenth:lenth isNumber:YES isCapital:NO isLowercase:NO];
}

+ (NSString *)bt_randomCapitalStrWithLenth:(NSInteger)lenth{
    return [self bt_randomStrWithLenth:lenth isNumber:NO isCapital:YES isLowercase:NO];
}

+ (NSString *)bt_randomLowercaseStrWithLenth:(NSInteger)lenth{
    return [self bt_randomStrWithLenth:lenth isNumber:NO isCapital:NO isLowercase:YES];
}

+ (NSString *)bt_randomStrWithLenth:(NSInteger)lenth isNumber:(BOOL)isNumber isCapital:(BOOL)isCapital isLowercase:(BOOL)isLowercase{
    NSString * sourceNumber = @"0123456789";
    NSString * sourceCapital = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSString * sourceLowercase = @"abcdefghijklmnopqrstuvwxyz";
    NSString * sourceStr = @"";
    if (isNumber) {
        sourceStr = [sourceStr stringByAppendingString:sourceNumber];
    }
    
    if (isCapital) {
        sourceStr = [sourceStr stringByAppendingString:sourceCapital];
    }
    
    if (isLowercase) {
        sourceStr = [sourceStr stringByAppendingString:sourceLowercase];
    }
    
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    for (int i = 0; i < lenth; i++)
    {
        //可以用来产生0～(x-1)范围内的随机数
        NSInteger index =arc4random_uniform((int)sourceStr.length);
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

@end
