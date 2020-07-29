//
//  BttenUtils.h
//  freeuse
//
//  Created by whbt_mac on 16/4/23.
//  Copyright © 2016年 StoneMover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BTUtils : NSObject

#pragma mark 常用方法

+ (CGFloat)NAV_HEIGHT;

+ (CGFloat)NAVCONTENT_HEIGHT;

+ (CGFloat)STATUS_BAR_HEIGHT;

+ (CGFloat)HOME_INDICATOR_HEIGHT;

+ (CGFloat)HOME_INDICATOR_HEIGHT_MEDIUM;

+ (CGFloat)HOME_INDICATOR_HEIGHT_SMALL;

+ (CGFloat)TAB_HEIGHT;

+ (BOOL)UI_IS_IPHONEX;

+ (BOOL)UI_IS_IPHONE_6;

+ (BOOL)UI_IS_IPHONE_6_P;

+ (BOOL)UI_IS_IPHONE_SE;

+ (UIApplication*)APP;

+ (UIWindow*)APP_WINDOW;

+ (UIViewController*)ROOT_VC;

+ (NSObject<UIApplicationDelegate>*)APP_DELEGATE;

+ (NSNotificationCenter*)NOTIFI_CENTER;

+ (CGFloat)SYS_VERION;

+ (CGFloat)SCREEN_W;

+ (CGFloat)SCREEN_H;

+ (CGRect)SCREEN_BOUNDS;

+ (CGFloat)SCALE_6_W:(CGFloat)value;

+ (CGFloat)SCALE_6_H:(CGFloat)value;

+ (UIFont*)SYS_FONT_SIZE:(CGFloat)size weight:(UIFontWeight)weight;

+ (UIFont*)SYS_FONT_SIZE:(CGFloat)size;

+ (NSString*)SAFE_STR:(nullable NSString*)str;

+ (UIImage*)PLACE_HOLDER_IMAGE;

+ (NSURL*)URL:(nullable NSString*)url;

+ (NSString*)APP_VERSION;

+ (void)openSetVc;

+ (UIViewController*)getCurrentVc;

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVc;

+ (BOOL)isEmpty:(nullable NSString*)str;

//设置ios 推送bage 数字
+ (void)setAppIconNotifiNum:(NSString*)num;

//将阿拉伯数字转换为中文数字
+ (NSString *)translationArabicNum:(NSInteger)arabicNum;


//传入秒数,转换成00:00:00格式
+ (NSString*)convertSecToTime:(int)second;

#pragma mark 字典常用方法

//得到字典中对应key的string类型字段
+ (NSString*)getString:(NSDictionary*)dict withKey:(NSString*)key;


//将字典转为json字符串
+ (NSString*)convertDictToJsonStr:(NSDictionary *)dic;

+ (NSString*)convertArrayToJsonStr:(NSArray *)array;


#pragma mark storyboard

+ (UIViewController*)createVc:(NSString*)storyBoardName;

+ (UIViewController*)createVc:(NSString*)storyBoardId storyBoardName:(NSString*)name;

#pragma mark 渐变创建
+ (CAGradientLayer*)createGradient:(CGSize)size
                             start:(CGPoint)start
                               end:(CGPoint)end
                            colors:(NSArray*)colors;

//水平方向渐变
+ (CAGradientLayer*)createGradientHoz:(CGSize)size
                               colors:(NSArray*)colors;

//垂直方向渐变
+ (CAGradientLayer*)createGradientVer:(CGSize)size
                               colors:(NSArray*)colors;


//00 - 11 渐变
+ (CAGradientLayer*)createGradientInclined:(CGSize)size
                                    colors:(NSArray*)colors;

//11 - 00渐变
+ (CAGradientLayer*)createGradientInclinedOpposite:(CGSize)size
                                            colors:(NSArray*)colors;



//震动
+ (void)shake;



//MARK:废弃方法

//返回156*****8016电话
+ (NSString*)phoneEncrypt:(nullable NSString*)phone DEPRECATED_MSG_ATTRIBUTE("已废弃,使用NSString+BTString");

//是否全部为数字
+ (BOOL)isStrAllNumber:(nullable NSString*)checkedNumString DEPRECATED_MSG_ATTRIBUTE("已废弃,使用NSString+BTString");

+ (NSString*)base64Decode:(NSString*)str DEPRECATED_MSG_ATTRIBUTE("已废弃,使用NSString+BTString");

+ (NSString*)base64Encode:(NSString*)str DEPRECATED_MSG_ATTRIBUTE("已废弃,使用NSString+BTString");

+ (NSString*)MD5:(NSString*)str DEPRECATED_MSG_ATTRIBUTE("已废弃,使用NSString+BTString");

+ (NSString*)createJsStr:(NSString*)name,...DEPRECATED_MSG_ATTRIBUTE("废弃,仅仅使用UIWebView方式，现在使用WKWebView方式进行交互");

+ (CGFloat)calculateStrHeight:(NSString*)str width:(CGFloat)width font:(UIFont*)font DEPRECATED_MSG_ATTRIBUTE("已废弃,使用NSString+BTString");

+ (CGFloat)calculateStrHeight:(NSString*)str width:(CGFloat)width font:(UIFont*)font lineSpeace:(CGFloat)lineSpeace DEPRECATED_MSG_ATTRIBUTE("已废弃,使用NSString+BTString");

+ (CGFloat)calculateStrWidth:(NSString*)str height:(CGFloat)height font:(UIFont*)font DEPRECATED_MSG_ATTRIBUTE("已废弃,使用NSString+BTString");

+ (CGFloat)calculateLabelHeight:(UILabel*)label DEPRECATED_MSG_ATTRIBUTE("已废弃,使用UILabel+BTLabel");

+ (CGFloat)calculateLabelWidth:(UILabel*)label DEPRECATED_MSG_ATTRIBUTE("已废弃,使用UILabel+BTLabel");

+ (UIImage*)circleImage:(UIImage*)image DEPRECATED_MSG_ATTRIBUTE("已废弃,使用UIImage+BTImage");

//将json字符串转为字典
+ (NSDictionary *)convertJsonToDict:(NSString *)jsonString DEPRECATED_MSG_ATTRIBUTE("已废弃,使用NSString+BTString");

+ (NSArray *)convertJsonToArray:(NSString *)jsonString DEPRECATED_MSG_ATTRIBUTE("已废弃,使用NSString+BTString");

+ (UIColor*)RGB:(CGFloat)R G:(CGFloat)G B:(CGFloat)B DEPRECATED_MSG_ATTRIBUTE("已废弃,使用UIColor+BTColor.h");

+ (UIColor*)RGBA:(CGFloat)R G:(CGFloat)G B:(CGFloat)B A:(CGFloat)A DEPRECATED_MSG_ATTRIBUTE("已废弃,使用UIColor+BTColor.h");

+ (UIColor*)RANDOM_COLOR DEPRECATED_MSG_ATTRIBUTE("已废弃,使用UIColor+BTColor.h");

@end


NS_ASSUME_NONNULL_END
