//
//  BttenUtils.m
//  freeuse
//
//  Created by whbt_mac on 16/4/23.
//  Copyright © 2016年 StoneMover. All rights reserved.
//

#import "BTUtils.h"
#import <AudioToolbox/AudioToolbox.h>
#import "NSString+BTString.h"
#import "UIImage+BTImage.h"
#import "UIColor+BTColor.h"



@implementation BTUtils

+ (CGFloat)NAV_HEIGHT{
    return BTUtils.NAVCONTENT_HEIGHT+BTUtils.STATUS_BAR_HEIGHT;
}

+ (CGFloat)NAVCONTENT_HEIGHT{
    return 44;
}

+ (CGFloat)STATUS_BAR_HEIGHT{
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}

+ (CGFloat)HOME_INDICATOR_HEIGHT{
    if (BTUtils.UI_IS_IPHONEX) {
        return 34;
    }else{
        return 0;
    }
}

+ (CGFloat)HOME_INDICATOR_HEIGHT_MEDIUM{
    if (BTUtils.UI_IS_IPHONEX) {
        return 24;
    }else{
        return 0;
    }
}

+ (CGFloat)HOME_INDICATOR_HEIGHT_SMALL{
    if (BTUtils.UI_IS_IPHONEX) {
        return 14;
    }else{
        return 0;
    }
}

+ (CGFloat)TAB_HEIGHT{
    if (BTUtils.UI_IS_IPHONEX) {
        return 49+34;
    }else{
        return 49;
    }
}

+ (BOOL)UI_IS_IPHONEX{
    if (BTUtils.SCREEN_W == 375.f && BTUtils.SCREEN_H == 812.f) {
        return YES;
    }
    
    if (BTUtils.SCREEN_W == 414.f && BTUtils.SCREEN_H == 896.f) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)UI_IS_IPHONE_6{
    if (BTUtils.SCREEN_W == 375.f && BTUtils.SCREEN_H == 667.f) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)UI_IS_IPHONE_6_P{
    if (BTUtils.SCREEN_W == 414.f && BTUtils.SCREEN_H == 736.f) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)UI_IS_IPHONE_SE{
    if (BTUtils.SCREEN_W == 320.f && BTUtils.SCREEN_H == 568.f) {
        return YES;
    }
    
    return NO;
}

+ (UIApplication*)APP{
    return [UIApplication sharedApplication];
}

+ (UIWindow*)APP_WINDOW{
    return [UIApplication sharedApplication].delegate.window;
}

+ (UIViewController*)ROOT_VC{
    return [UIApplication sharedApplication].delegate.window.rootViewController;
}

+ (NSObject<UIApplicationDelegate>*)APP_DELEGATE{
    return [UIApplication sharedApplication].delegate;
}

+ (NSNotificationCenter*)NOTIFI_CENTER{
    return [NSNotificationCenter defaultCenter];
}

+ (CGFloat)SYS_VERION{
    return [[UIDevice currentDevice].systemVersion doubleValue];
}

+ (CGFloat)SCREEN_W{
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (CGFloat)SCREEN_H{
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGRect)SCREEN_BOUNDS{
    return [UIScreen mainScreen].bounds;
}

+ (CGFloat)SCALE_6_W:(CGFloat)width{
    return (width)*(BTUtils.SCREEN_W/375.0f);
}

+ (CGFloat)SCALE_6_H:(CGFloat)height{
    return (height)*(BTUtils.SCREEN_H/667.0f);
}

+ (UIFont*)SYS_FONT_SIZE:(CGFloat)size weight:(UIFontWeight)weight{
    return [UIFont systemFontOfSize:size weight:weight];
}

+ (UIFont*)SYS_FONT_SIZE:(CGFloat)size{
    return [BTUtils SYS_FONT_SIZE:size weight:UIFontWeightThin];
}



+ (NSString*)SAFE_STR:(NSString*)str{
    if ([BTUtils isEmpty:str]) {
        return @"";
    }
    
    return str;
}

+ (UIImage*)PLACE_HOLDER_IMAGE{
    return [UIImage imageNamed:@"bt_default_placeholder"];
}

+ (NSURL*)URL:(NSString*)url{
    if (![BTUtils isEmpty:url]) {
        NSURL * result = [NSURL URLWithString:url];
        if (result != nil) {
            return result;
        }
    }
    return [NSURL URLWithString:@"http://www.baidu.com"];
}

+ (NSString*)APP_VERSION{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString * appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return appVersion;
}


+ (void)openSetVc{
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:^(BOOL success) {
            
        }];
    } else {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] ];
    }
    
}

+ (UIViewController *)getCurrentVc
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVc
{
    UIViewController *currentVC;
    if ([rootVc presentedViewController]) {
        // 视图是被presented出来的
        rootVc = [rootVc presentedViewController];
    }
    
    if ([rootVc isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVc selectedViewController]];
    } else if ([rootVc isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVc visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVc;
    }
    return currentVC;
}


+ (BOOL)isEmpty:(NSString*)str{
    
    if (![str isKindOfClass:NSString.class]) {
        return YES;
    }
    
    if (str == nil || str == NULL) {
        return YES;
    }
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    
    if ([str isEqualToString:@"<null>"]) {
        return YES;
    }
    
    if ([str isEqualToString:@"(null)"]) {
        return YES;
    }
    
    return NO;
    
}




+ (void)setAppIconNotifiNum:(NSString*)num{
    // 应用程序右上角数字
    UIApplication *app = [UIApplication sharedApplication];
    app.applicationIconBadgeNumber =num.intValue;
}







+ (NSString *)translationArabicNum:(NSInteger)arabicNum{
    NSString *arabicNumStr = [NSString stringWithFormat:@"%ld",(long)arabicNum];
    NSArray *arabicNumeralsArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chineseNumeralsArray = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"个",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chineseNumeralsArray forKeys:arabicNumeralsArray];
    
    if (arabicNum < 20 && arabicNum > 9) {
        if (arabicNum == 10) {
            return @"十";
        }else{
            NSString *subStr1 = [arabicNumStr substringWithRange:NSMakeRange(1, 1)];
            NSString *a1 = [dictionary objectForKey:subStr1];
            NSString *chinese1 = [NSString stringWithFormat:@"十%@",a1];
            return chinese1;
        }
    }else{
        NSMutableArray *sums = [NSMutableArray array];
        for (int i = 0; i < arabicNumStr.length; i ++)
        {
            NSString *substr = [arabicNumStr substringWithRange:NSMakeRange(i, 1)];
            NSString *a = [dictionary objectForKey:substr];
            NSString *b = digits[arabicNumStr.length -i-1];
            NSString *sum = [a stringByAppendingString:b];
            if ([a isEqualToString:chineseNumeralsArray[9]])
            {
                if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
                {
                    sum = b;
                    if ([[sums lastObject] isEqualToString:chineseNumeralsArray[9]])
                    {
                        [sums removeLastObject];
                    }
                }else
                {
                    sum = chineseNumeralsArray[9];
                }
                
                if ([[sums lastObject] isEqualToString:sum])
                {
                    continue;
                }
            }
            
            [sums addObject:sum];
        }
        NSString *sumStr = [sums  componentsJoinedByString:@""];
        NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
        return chinese;
    }
}


+ (NSString*)convertSecToTime:(int)second{
    int h=0;
    int m=0;
    int s=0;
    
    if (second%3600==0) {
        h=second/3600;
        return [self convertSecToTimeStr:h minute:m second:s];
    }
    h=second/3600;
    int secondMinute=second%3600;
    
    if (secondMinute%60==0) {
        m=secondMinute/60;
        return [self convertSecToTimeStr:h minute:m second:s];
    }
    
    m=secondMinute/60;
    s=secondMinute%60;
    
    return [self convertSecToTimeStr:h minute:m second:s];
}

+ (NSString*)convertSecToTimeStr:(int)h minute:(int)minute second:(int)second{
    NSString * hstr=h<10?[NSString stringWithFormat:@"0%d",h]:[NSString stringWithFormat:@"%d",h];
    
    NSString * mstr=minute<10?[NSString stringWithFormat:@"0%d",minute]:[NSString stringWithFormat:@"%d",minute];
    
    NSString * sstr=second<10?[NSString stringWithFormat:@"0%d",second]:[NSString stringWithFormat:@"%d",second];
    if (h==0) {
        return [NSString stringWithFormat:@"%@:%@",mstr,sstr];
    }
    return [NSString stringWithFormat:@"%@:%@:%@",hstr,mstr,sstr];
    
}

+ (NSString*)getString:(NSDictionary*)dict withKey:(NSString*)key{
    //不存在该KEY就返回nil
    if (![dict.allKeys containsObject:key]) {
        NSLog(@"该字典没有对应的key:%@",key);
        return nil;
    }
    
    return [NSString stringWithFormat:@"%@",[dict objectForKey:key]];
}



+ (NSString*)convertDictToJsonStr:(NSDictionary *)dic
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}



+ (NSString*)convertArrayToJsonStr:(NSArray *)array
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}











+ (UIViewController*)createVc:(NSString*)storyBoardName{
    return [self createVc:storyBoardName storyBoardName:@"Main"];
}
+ (UIViewController*)createVc:(NSString*)storyBoardId storyBoardName:(NSString*)name{
    UIStoryboard *story = [UIStoryboard storyboardWithName:name bundle:[NSBundle mainBundle]];
    UIViewController *vc = [story instantiateViewControllerWithIdentifier:storyBoardId];
    return vc;
}


+ (CAGradientLayer*)createGradient:(CGSize)size
                             start:(CGPoint)start
                               end:(CGPoint)end
                            colors:(NSArray*)colors{
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0, 0, size.width, size.height);
    gl.startPoint=start;
    gl.endPoint=end;
    NSMutableArray * array=[NSMutableArray new];
    
    for (int i=0;i<colors.count;i++) {
        UIColor * color =colors[i];
        [array addObject:(id)color.CGColor];
    }
    
    gl.colors=array;
    
    return gl;
}

//水平方向渐变
+ (CAGradientLayer*)createGradientHoz:(CGSize)size
                               colors:(NSArray*)colors{
    return [self createGradient:size start:CGPointMake(0, .5) end:CGPointMake(1, .5) colors:colors];
}

//垂直方向渐变
+ (CAGradientLayer*)createGradientVer:(CGSize)size
                               colors:(NSArray*)colors{
    return [self createGradient:size start:CGPointMake(.5, 0) end:CGPointMake(.5, 1) colors:colors];
}

//00 - 11 渐变
+ (CAGradientLayer*)createGradientInclined:(CGSize)size
                                    colors:(NSArray*)colors{
    return [self createGradient:size start:CGPointMake(0, 0) end:CGPointMake(1, 1) colors:colors];
}
//11 - 00渐变
+ (CAGradientLayer*)createGradientInclinedOpposite:(CGSize)size
                                            colors:(NSArray*)colors{
    return [self createGradient:size start:CGPointMake(1, 1) end:CGPointMake(0, 0) colors:colors];
}



+ (void)shake{
    AudioServicesPlaySystemSound(1520);
}


//MARK:废弃方法
+ (NSString*)phoneEncrypt:(NSString*)phone{
    return phone.phoneEncrypt;
}

+ (BOOL)isStrAllNumber:(NSString*)checkedNumString{
    return checkedNumString.isStrAllNumber;
}

+ (NSString*)base64Decode:(NSString*)str{
    return str.base64Decode;
}

+ (NSString*)base64Encode:(NSString*)str{
    return str.base64Encode;
}

+ (NSString*)MD5:(NSString*)str{
    return str.md5;
}

+ (NSString*)createJsStr:(NSString*)name,...{
    NSString*result=name;
    NSString*ns;
    va_list arg_list;
    va_start(arg_list, name);
    result=[result stringByAppendingString:@"("];
    
    while ((ns = va_arg(arg_list, NSString*))) {
        result=[result stringByAppendingString:@"'"];
        result=[result stringByAppendingString:ns];
        result=[result stringByAppendingString:@"'"];
        result=[result stringByAppendingString:@","];
    }
    NSString*fir=[result substringFromIndex:result.length-1];
    if (![fir isEqualToString:@"("]) {
        result=[result substringToIndex:result.length-1];
    }
    result=[result stringByAppendingString:@");"];
    va_end(arg_list);
    NSLog(@"%@",[NSString stringWithFormat:@"调用的JS方法:%@",result]);
    return result;
}

+ (CGFloat)calculateStrHeight:(NSString*)str width:(CGFloat)width font:(UIFont*)font{
    return [str calculateStrHeight:width font:font];
}

+ (CGFloat)calculateStrHeight:(NSString*)str width:(CGFloat)width font:(UIFont*)font lineSpeace:(CGFloat)lineSpeace{
    return [str calculateStrHeight:width font:font lineSpeace:lineSpeace];
}

+ (CGFloat)calculateStrWidth:(NSString*)str height:(CGFloat)height font:(UIFont*)font{
    return [str calculateStrWidth:height font:font];
}

+ (CGFloat)calculateLabelHeight:(UILabel*)label{
    return [label.text calculateStrHeight:label.frame.size.width font:label.font];
}


+ (CGFloat)calculateLabelWidth:(UILabel*)label{
    return [label.text calculateStrWidth:label.frame.size.height font:label.font];
}

+ (UIImage*)circleImage:(UIImage*)image{
    return image.circleImage;
}

+ (NSDictionary *)convertJsonToDict:(NSString *)jsonString {
    return jsonString.toDict;
}

+ (NSArray *)convertJsonToArray:(NSString *)jsonString {
    return jsonString.toArray;
}

+ (UIColor*)RGB:(CGFloat)R G:(CGFloat)G B:(CGFloat)B{
    return [UIColor R:R G:G B:B];
}

+ (UIColor*)RGBA:(CGFloat)R G:(CGFloat)G B:(CGFloat)B A:(CGFloat)A{
    return [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:A];
}

+ (UIColor*)RANDOM_COLOR{
    return [BTUtils RGB:arc4random_uniform(256) G:arc4random_uniform(256) B:arc4random_uniform(256)];
}


@end


