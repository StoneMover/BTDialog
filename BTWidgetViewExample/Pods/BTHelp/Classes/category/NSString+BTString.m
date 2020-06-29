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

@implementation NSString (BTString)

- (NSString*)phoneEncrypt{
    if ([BTUtils isEmpty:self]) {
        return @"";
    }
    
    if (self.length != 11) {
        return @"";
    }
    
    NSString * str = [self stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    return str;
}

- (BOOL)isStrAllNumber{
    if ([BTUtils isEmpty:self]) {
        return NO;
    }
    
    NSString * checkedNumString = [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedNumString.length > 0) {
        return NO;
    }
    return YES;
}

//加密&解密
- (NSString*)base64Decode{
    NSData * data = [[NSData alloc]initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString * string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}

- (NSString*)base64Encode{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString*)md5{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        [output appendFormat:@"%02x", digest[i]];
    }
    return  output;
}


- (CGFloat)calculateStrHeight:(CGFloat)width font:(UIFont*)font{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    CGSize labelSize =[self boundingRectWithSize:CGSizeMake(width, 1500) options:NSStringDrawingUsesLineFragmentOrigin  attributes:dic context:nil].size;
    return labelSize.height;
}

- (CGFloat)calculateStrHeight:(CGFloat)width font:(UIFont*)font lineSpeace:(CGFloat)lineSpeace{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = lineSpeace;
    NSDictionary * dic =@{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle};
    
    CGSize labelSize =[self boundingRectWithSize:CGSizeMake(width, 1500) options:NSStringDrawingUsesLineFragmentOrigin  attributes:dic context:nil].size;
    return labelSize.height;
}


- (CGFloat)calculateStrWidth:(CGFloat)height font:(UIFont*)font{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    CGSize labelSize =[self boundingRectWithSize:CGSizeMake(1500, height) options:NSStringDrawingUsesLineFragmentOrigin  attributes:dic context:nil].size;
    return labelSize.width;
}


- (nullable NSDictionary *)toDict{
    NSData * jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError * err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

- (nullable NSArray *)toArray{
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray * array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return array;
}


@end
