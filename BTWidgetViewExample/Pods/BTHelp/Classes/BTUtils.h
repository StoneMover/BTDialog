//
//  BttenUtils.h
//  freeuse
//
//  Created by whbt_mac on 16/4/23.
//  Copyright © 2016年 StoneMover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


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

+ (UIColor*)RGB:(CGFloat)R G:(CGFloat)G B:(CGFloat)B;

+ (UIColor*)RGBA:(CGFloat)R G:(CGFloat)G B:(CGFloat)B A:(CGFloat)A;

+ (UIColor*)RANDOM_COLOR;

+ (NSString*)SAFE_STR:(NSString*)str;

+ (UIImage*)PLACE_HOLDER_IMAGE;

+ (NSURL*)URL:(NSString*)url;

+ (NSString*)APP_VERSION;

+ (void)openSetVc;

+ (UIViewController*)getCurrentVc;

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVc;

+ (BOOL)isEmpty:(NSString*)str;

//将UIimage重绘成圆形,如果不是等宽,等高则绘制中心图片
+ (UIImage*)circleImage:(UIImage*)image;

//设置ios 推送bage 数字
+ (void)setAppIconNotifiNum:(NSString*)num;


//计算文字的高度,
+ (CGFloat)calculateStrHeight:(NSString*)str width:(CGFloat)width font:(UIFont*)font;

+ (CGFloat)calculateLabelHeight:(UILabel*)label;

+ (CGFloat)calculateStrWidth:(NSString*)str height:(CGFloat)height font:(UIFont*)font;

+ (CGFloat)calculateLabelWidth:(UILabel*)label;

//将阿拉伯数字转换为中文数字
+ (NSString *)translationArabicNum:(NSInteger)arabicNum;


//传入秒数,转换成00:00:00格式
+ (NSString*)convertSecToTime:(int)second;

#pragma mark 字典常用方法

//得到字典中对应key的string类型字段
+ (NSString*)getString:(NSDictionary*)dict withKey:(NSString*)key;

//将json字符串转为字典
+ (NSDictionary *)convertJsonToDict:(NSString *)jsonString;

//将字典转为json字符串
+ (NSString*)convertDictToJsonStr:(NSDictionary *)dic;

+ (NSArray *)convertJsonToArray:(NSString *)jsonString;

+ (NSString*)convertArrayToJsonStr:(NSArray *)array;

#pragma mark 沙盒常用方法
/*
 默认情况下，每个沙盒含有3个文件夹：Documents, Library 和 tmp和一个应用程序文件（也是一个文件）。因为应用的沙盒机制，应用只能在几个目录下读写文件
 
 Documents：苹果建议将程序中建立的或在程序中浏览到的文件数据保存在该目录下，iTunes备份和恢复的时候会包括此目录
 
 Library：存储程序的默认设置或其它状态信息；
 
 Library/Caches：存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除
 
 tmp：提供一个即时创建临时文件的地方。
 
 iTunes在与iPhone同步时，备份所有的Documents和Library文件。
 
 iPhone在重启时，会丢弃所有的tmp文件。
 
 */

//得到沙盒的root路径
+ (NSString*)getHomePath;

//得到沙盒下Document文件夹的路径
+ (NSString*)getDocumentPath;

//得到Cache文件夹的路径
+ (NSString*)getCachePath;

//得到Library文件夹的路径
+ (NSString*)getLibraryPath;

//得到tmp文件夹的路径
+ (NSString*)getTmpPath;

//文件是否存在
+ (BOOL)isFileExit:(NSString*)path;

//删除文件
+ (void)deleteFile:(NSString*)path;

//复制文件到某个路径
+ (void)copyFile:(NSString*)filePath toPath:(NSString*)path isOverride:(BOOL)overrid;


//创建路径
+ (void)createPath:(NSString*)path;

//在document目录下创建子文件路径
+ (void)createDocumentPath:(NSString*)path;

//保存文件到沙盒,如果存在该文件则继续写入
+ (NSString*)saveFile:(NSString*)path withFileName:(NSString*)name withData:(NSData*)data;

//保存文件到沙盒,如果存在该文件则继续写入
+ (NSString*)saveFile:(NSString*)path withFileName:(NSString*)name withData:(NSData*)data isCover:(BOOL)cover;

//获取cache目录下的图片文件夹,没有则创建
+ (NSString*)getCachePic;

//获取cache目录下的video文件夹,没有则创建
+ (NSString*)getCacheVideo;

//获取cache目录下的voice文件夹,没有则创建
+ (NSString*)getCacheVoice;

//获取某一个文件夹下的所有文件
+ (NSArray*)getFolderAllFileName:(NSString*)folderPath fileType:(NSString*)fileType;

#pragma mark webview 与js操作的方法

+ (NSString*)createJsStr:(NSString*)name,...;


#pragma mark 加密&解密
+ (NSString*)base64Decode:(NSString*)str;

+ (NSString*)base64Encode:(NSString*)str;

+ (NSString*)MD5:(NSString*)str;

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

//是否全部为数字
+ (BOOL)isStrAllNumber:(NSString*)checkedNumString;

//震动
+ (void)shake;

//返回156*****8016电话
+ (NSString*)phoneEncrypt:(NSString*)phone;

@end


