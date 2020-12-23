//
//  BTDownloadMananger.h
//  huashi
//
//  Created by stonemover on 16/8/13.
//  Copyright © 2016年 StoneMover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTDownloadModel.h"



@protocol BTDownloadDelegate <NSObject>

@optional

- (void)downloadStateChange:(BTDownloadModel *)model;

- (void)downloadProgressChange:(BTDownloadModel *)model;

- (void)downloadError:(BTDownloadModel *)model error:(NSError*)error;

@end



@interface BTDownloadMananger : NSObject

@property (nonatomic, assign, readonly) NSInteger maxDownLoadNum;

+ (BTDownloadMananger*)share;

- (BTDownloadModel*)downLoad:(NSString*)url;

- (BTDownloadModel*)downLoad:(NSString*)url obj:(NSObject*)obj;

- (BTDownloadModel*)downLoad:(NSString *)url savePath:(NSString*)savePath;

- (BTDownloadModel*)downLoad:(NSString *)url savePath:(NSString*)savePath saveName:(NSString*)saveName;

- (BTDownloadModel*)downLoad:(NSString *)url savePath:(NSString*)savePath saveName:(NSString*)saveName obj:(NSObject*)obj;

- (void)downLoadWithModel:(BTDownloadModel *)model;

- (void)cancelWithModel:(BTDownloadModel *)model;

- (void)cancel:(NSString*)url;

- (void)canelAll;

- (void)setMaxDownLoadNum:(NSInteger)maxDownLoadNum;

- (void)addDelegate:(id<BTDownloadDelegate> )delegate;

- (void)removeDelegate:(id<BTDownloadDelegate> )delegate;

- (BOOL)isDownloading:(NSString*)url;


@end
