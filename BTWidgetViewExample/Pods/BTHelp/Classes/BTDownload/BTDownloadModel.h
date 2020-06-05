//
//  BTDownloadModel.h
//  huashi
//
//  Created by stonemover on 16/8/13.
//  Copyright © 2016年 StoneMover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BTUtils.h"

#define BTDownloadTotalSizeKey @"BTDownloadTotalSizeKey"

#define BTDownloadLoadedSizeKey @"BTDownloadLoadedSizeKey"

typedef NS_ENUM(NSInteger,BTDownloadStatus) {
    BTDownloadStatusInit=0,
    BTDownloadStatusDownLoading,
    BTDownloadStatusPause,
    BTDownloadStatusWait,
    BTDownloadStatusCancel,
    BTDownloadStatusFinish
};

@interface BTDownloadModel : NSObject


- (instancetype)initWithUrl:(NSString*)url savePath:(NSString*)savePath saveName:(NSString*)saveName;


//下载地址链接
@property(nonatomic,strong,readonly) NSString * downloadUrl;

//存储路径目录,documents下
@property(nonatomic,strong,readonly) NSString * saveFolder;

//存储文件名,如果不设置会截取下载链接的最后名称作为存储名称，如果无法解析到url最后的文件名称，就以downloadUrl为文件名称
@property(nonatomic,strong,readonly) NSString * saveName;

//完整的存储路径,自己需要拼接前面的document路径
@property (nonatomic, strong,readonly) NSString * path;

#pragma mark 所要记录的下载信息

//下载状态
@property(nonatomic,assign,readonly) BTDownloadStatus status;

//下载进度
@property(nonatomic,assign,readonly) CGFloat progress;

//上次的下载进度
@property(nonatomic,assign,readonly) CGFloat lastProgress;

//是否是断点续传
@property(nonatomic,assign,readonly) BOOL isReplay;

//上次下载后存在本地的文件大小
@property(nonatomic,assign,readonly) int64_t hasSaveInLocation;

//记录在本地的文件大小
@property(nonatomic,assign,readonly) int64_t fileTotalSize;

//存在本地的文件的进度
@property(nonatomic,assign,readonly) float loadedProgress;

//关联的task任务
@property(nonatomic,strong,readonly) NSURLSessionDownloadTask * task;

//可携带的一个obj对象
@property (nonatomic, strong) NSObject * obj;

@end
