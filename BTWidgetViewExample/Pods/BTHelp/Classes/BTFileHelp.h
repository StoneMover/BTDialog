//
//  BTFileHelp.h
//  BTHelpExample
//
//  Created by apple on 2020/6/28.
//  Copyright © 2020 stonemover. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BTFileHelp : NSObject

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
+ (NSString*)homePath;

//得到沙盒下Document文件夹的路径
+ (NSString*)documentPath;

//得到Cache文件夹的路径
+ (NSString*)cachePath;

//得到Library文件夹的路径
+ (NSString*)libraryPath;

//得到tmp文件夹的路径
+ (NSString*)tmpPath;

//获取cache目录下的图片文件夹,没有则创建
+ (NSString*)cachePicturePath;

//获取cache目录下的video文件夹,没有则创建
+ (NSString*)cacheVideoPath;

//获取cache目录下的voice文件夹,没有则创建
+ (NSString*)cacheVoicePath;

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
+ (NSString*)saveFileWithPath:(NSString*)path fileName:(NSString*)fileName data:(NSData*)data;

//保存文件到沙盒,如果存在该文件则继续写入
+ (NSString*)saveFileWithPath:(NSString*)path fileName:(NSString*)fileName data:(NSData*)data isAppend:(BOOL)isAppend;



//获取某一个文件夹下的所有文件
+ (NSArray*)getFolderAllFileName:(NSString*)folderPath fileType:(NSString*)fileType;



@end

NS_ASSUME_NONNULL_END
