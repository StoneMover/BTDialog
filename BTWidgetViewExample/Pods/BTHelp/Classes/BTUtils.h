//
//  BttenUtils.h
//  freeuse
//
//  Created by whbt_mac on 16/4/23.
//  Copyright © 2016年 StoneMover. All rights reserved.
//  IPhone7 375*667;
//  IPhone7P 414*736
//  IPhone11Pro IPhone12MINI 375*812
//  IPhone11 IPhone11ProMax 414*896
//  IPhone12 IPhone12Pro 390 * 844
//  IPhone12ProMax 428 * 926

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BTUtils : NSObject

#pragma mark 常用方法

//导航器总体高度NAVCONTENT_HEIGHT+STATUS_BAR_HEIGHT
+ (CGFloat)NAV_HEIGHT;

//导航器内容高度44
+ (CGFloat)NAVCONTENT_HEIGHT;

//状态栏高度
+ (CGFloat)STATUS_BAR_HEIGHT;

//全面屏比普通屏幕多出的状态栏高度
+ (CGFloat)IPHONEX_MORE_BAR_HEIGHT;

//全面屏底部指示器高度
+ (CGFloat)HOME_INDICATOR_HEIGHT;

+ (CGFloat)HOME_INDICATOR_HEIGHT_MEDIUM;

+ (CGFloat)HOME_INDICATOR_HEIGHT_SMALL;

//tabbar高度
+ (CGFloat)TAB_HEIGHT_DEFAULT;
+ (CGFloat)TAB_HEIGHT;

//是否为全面屏
+ (BOOL)UI_IS_IPHONEX;

//是否为IPhone6,IPhone7,IPhone8,IPhoneSE第二代 尺寸
+ (BOOL)UI_IS_IPHONE_6;

//是否为IPhone6Plus,IPhone7Plus,IPhone8Plus 尺寸
+ (BOOL)UI_IS_IPHONE_6_P;

//是否为IPhone5,IPhoneSE第一代尺寸
+ (BOOL)UI_IS_IPHONE_SE;

+ (UIApplication*)APP;

+ (UIWindow*)APP_WINDOW;

+ (UIViewController*)ROOT_VC;

+ (NSObject<UIApplicationDelegate>*)APP_DELEGATE;

//通知中心对象
+ (NSNotificationCenter*)NOTIFI_CENTER;

//系统版本号
+ (CGFloat)SYS_VERSION;

//屏幕宽度
+ (CGFloat)SCREEN_W;

//屏幕高度
+ (CGFloat)SCREEN_H;

+ (CGRect)SCREEN_BOUNDS;


//处理空字符串，如果为空则返回@"";
+ (NSString*)SAFE_STR:(nullable NSString*)str;

//处理为空的URL对象，为空的时候返回[NSURL URLWithString:@"http://www.baidu.com"]
+ (NSURL*)URL:(nullable NSString*)url;

//应用的版本号
+ (NSString*)APP_VERSION;

//打开系统设置界面
+ (void)openSetVc;

//获取当前VC
+ (UIViewController*)getCurrentVc;
+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVc;

//字符串是否为空
+ (BOOL)isEmpty:(nullable NSString*)str;

//设置ios 推送bage 数字
+ (void)setAppIconNotifiNum:(NSString*)num;

//将阿拉伯数字转换为中文数字
+ (NSString *)translationArabicNum:(NSInteger)arabicNum;


//传入秒数,转换成00:00:00格式
+ (NSString*)convertSecToTime:(NSInteger)second;

#pragma mark 字典常用方法
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

//获取某月的总天数
+ (NSInteger)getDaysInMonth:(NSInteger)year month:(NSInteger)month;


//MARK:废弃方法

//以宽度的缩放比例，计算对应的高度，比如在375的宽度高度为100，那么在414宽度的屏幕上即为414/375*100
+ (CGFloat)SCALE_6_W:(CGFloat)value DEPRECATED_MSG_ATTRIBUTE("已废弃,BTScaleHelp");

//以高度的缩放比例，计算对应的宽度
+ (CGFloat)SCALE_6_H:(CGFloat)value DEPRECATED_MSG_ATTRIBUTE("已废弃,BTScaleHelp");


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
