//
//  BTDownloadMananger.m
//  huashi
//
//  Created by stonemover on 16/8/13.
//  Copyright © 2016年 StoneMover. All rights reserved.
//

#import "BTDownloadMananger.h"
#import "XMLReader.h"
#import "NSString+BTString.h"
#import "BTFileHelp.h"

static BTDownloadMananger * mananger=nil;

@interface BTDownloadMananger()<NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSMutableArray<BTDownloadModel*> * waitModel;

@property (nonatomic, strong) NSMutableArray<BTDownloadModel*> * dataModel;

@property (nonatomic, strong) NSMutableArray<id<BTDownloadDelegate>> * delegates;


@end

@implementation BTDownloadMananger

+ (BTDownloadMananger*)share{
    if (!mananger) {
        mananger=[[BTDownloadMananger alloc] init];
    }
    return mananger;
}

- (instancetype)init{
    self=[super init];
    self.dataModel=[NSMutableArray new];
    self.waitModel=[NSMutableArray new];
    self.delegates=[NSMutableArray new];
    _maxDownLoadNum=2;
    return self;
}


- (void)createTask:(BTDownloadModel*)model{
    NSURL * urlResult =[NSURL URLWithString:model.downloadUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlResult];
    if (model.isReplay) {
        [request setValue:[self getRangeStr:model] forHTTPHeaderField:@"Range"];
    }
    NSURLSessionConfiguration * sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession  * session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    NSURLSessionDownloadTask * task=[session downloadTaskWithRequest:request];
    [model setValue:task forKey:@"task"];
}


- (BTDownloadModel*)downLoad:(NSString*)url{
    return [self downLoad:url savePath:nil saveName:nil];
}

- (BTDownloadModel*)downLoad:(NSString*)url obj:(NSObject*)obj{
    return [self downLoad:url savePath:nil saveName:nil obj:obj];
}

- (BTDownloadModel*)downLoad:(NSString *)url savePath:(NSString*)savePath{
    return [self downLoad:url savePath:savePath saveName:nil];
}

- (BTDownloadModel*)downLoad:(NSString *)url savePath:(NSString*)savePath saveName:(NSString*)saveName{
    return [self downLoad:url savePath:savePath saveName:saveName obj:nil];
}

- (BTDownloadModel*)downLoad:(NSString *)url savePath:(NSString*)savePath saveName:(NSString*)saveName obj:(NSObject*)obj{
    BTDownloadModel * model = [self modelWithUrl:url];
    if (model) {
        NSLog(@"%@",@"该文件正在下载中");
        return model;
    }
    
    model =[[BTDownloadModel alloc] initWithUrl:url savePath:savePath saveName:saveName];
    model.obj=obj;
    [self downLoadWithModel:model];
    return model;
}

- (void)downLoadWithModel:(BTDownloadModel *)model{
    if ([self.dataModel containsObject:model]) {
        NSLog(@"%@",@"该文件正在下载中");
        return;
    }
    
    if (model.status==BTDownloadStatusFinish) {
        NSLog(@"%@",@"该文件存在本地并且下载完成");
        [self changeModelStatus:model status:BTDownloadStatusFinish];
        return;
    }
    
    
    if (self.dataModel.count>=self.maxDownLoadNum) {
        [self.waitModel addObject:model];
        [self changeModelStatus:model status:BTDownloadStatusWait];
        return;
    }
    [self startDownLoad:model];
}


- (void)startDownLoad:(BTDownloadModel*)model{
    [self.dataModel addObject:model];
    [self createTask:model];
    [self changeModelStatus:model status:BTDownloadStatusDownLoading];
    [model.task resume];
}

- (void)cancelWithModel:(BTDownloadModel *)model{
    if (!model) {
        NSLog(@"取消下载链接获取不到model为空");
        return;
    }
    
    [self changeModelStatus:model status:BTDownloadStatusCancel];
    [model.task cancelByProducingResumeData:^(NSData *resumeData) {
        NSString * str=[[NSString alloc]initWithData:resumeData encoding:NSUTF8StringEncoding];
        NSError * error;
        NSDictionary* dic = [XMLReader dictionaryForXMLString:str error:&error];
        NSDictionary * plist=[dic objectForKey:@"plist"];
        NSDictionary * dict=[plist objectForKey:@"dict"];
        NSArray * array=[dict objectForKey:@"string"];
        NSDictionary * result=array[2];
        NSString * tmpName=[result objectForKey:@"text"];
        NSString * path=[BTFileHelp tmpPath];
        NSString * filePath=[NSString stringWithFormat:@"%@/%@",path,tmpName];
        NSData * data=[NSData dataWithContentsOfFile:filePath];
        [BTFileHelp saveFileWithPath:model.saveFolder fileName:model.saveName data:data];
    }];
}

- (void)cancel:(NSString*)url{
    if ([BTUtils isEmpty:url]) {
        NSLog(@"取消下载链接为空");
        return;
    }
    BTDownloadModel * model=[self modelWithUrl:url];
    [self cancelWithModel:model];
}

- (void)canelAll{
    for (BTDownloadModel * model in self.dataModel) {
        [self cancelWithModel:model];
    }
}

- (void)changeModelStatus:(BTDownloadModel*)model status:(BTDownloadStatus)status{
    [model setValue:[NSNumber numberWithInteger:status] forKey:@"status"];
    dispatch_async(dispatch_get_main_queue(), ^{
        for (id<BTDownloadDelegate> delegate in self.delegates) {
            if (delegate&&[delegate respondsToSelector:@selector(downloadStateChange:)]) {
                [delegate downloadStateChange:model];
            }
        }
    });
}

/**
    表示头500个字节：bytes=0-499
 　　表示第二个500字节：bytes=500-999
 　　表示最后500个字节：bytes=-500
 　　表示500字节以后的范围：bytes=500-
 　　第一个和最后一个字节：bytes=0-0,-1
 　　同时指定几个范围：bytes=500-600,601-999
 */
-(NSString*)getRangeStr:(BTDownloadModel*)model{
    int64_t startSize=model.fileTotalSize-model.hasSaveInLocation;
    NSString *range = [NSString stringWithFormat:@"Bytes=-%lld",startSize];
    return range;
}

-(BTDownloadModel*)modelWithTask:(NSURLSessionDownloadTask*)task{
    for (BTDownloadModel * model in self.dataModel) {
        if (model.task==task) {
            return model;
        }
    }
    return nil;
}

- (BTDownloadModel*)modelWithUrl:(NSString*)url{
    for (BTDownloadModel * model in self.dataModel) {
        if ([model.downloadUrl isEqualToString:url]) {
            return model;
        }
    }
    return nil;
}


- (void)setMaxDownLoadNum:(NSInteger)maxDownLoadNum{
    _maxDownLoadNum=maxDownLoadNum;
}

- (void)addDelegate:(id<BTDownloadDelegate> )delegate{
    [self.delegates addObject:delegate];
}

- (void)removeDelegate:(id<BTDownloadDelegate> )delegate{
    [self.delegates removeObject:delegate];
}

- (BOOL)isDownloading:(NSString*)url{
    for (BTDownloadModel * model in self.dataModel) {
        if ([model.downloadUrl isEqualToString:url]) {
            return YES;
        }
    }
    
    return NO;
}


#pragma mark NSURLSessionDownloadDelegate
// 每次写入调用(会调用多次)
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    BTDownloadModel * model=[self modelWithTask:downloadTask];
    
    NSString * totalSize=[NSString stringWithFormat:@"%lld",totalBytesExpectedToWrite];
    NSString * loadedfileSize=[NSString stringWithFormat:@"%lld",totalBytesWritten];
    if (model.isReplay) {
        totalSize=[NSString stringWithFormat:@"%lld",model.fileTotalSize];
        int64_t loadedTotalSize=model.hasSaveInLocation+loadedfileSize.longLongValue;
        loadedfileSize=[NSString stringWithFormat:@"%lld",loadedTotalSize];
    }
    
    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
    NSDictionary * dic=@{BTDownloadTotalSizeKey:totalSize,BTDownloadLoadedSizeKey:loadedfileSize};
    [[NSUserDefaults standardUserDefaults] setValue:dic forKey:model.downloadUrl];
    [defaults synchronize];
    
    // 可在这里通过已写入的长度和总长度算出下载进度
    CGFloat progress = 0.0;
    if (model.isReplay) {
        progress=1.0 * (totalBytesWritten+model.hasSaveInLocation) / model.fileTotalSize;
    }else{
        progress=1.0 * totalBytesWritten / totalBytesExpectedToWrite;

    }
    
//    NSLog(@"需要下载文件大小:%lld",totalBytesExpectedToWrite);
//    NSLog(@"已经下载文件大小:%lld",totalBytesWritten);
//    NSLog(@"已经存在手机上的大小:%lld",model.hasSaveInLocation);
    
//    model.progress=progress;
    [model setValue:[NSNumber numberWithFloat:progress] forKey:@"progress"];
    if (model.progress-model.lastProgress>0.0001) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // UI更新代码
            for (id<BTDownloadDelegate> delegate in self.delegates) {
                if (delegate&&[delegate respondsToSelector:@selector(downloadProgressChange:)]) {
                    [delegate downloadProgressChange:model];
                }
            }
        });
//        NSLog(@"%.3f",progress);
    }
//    model.lastProgress=progress;
    [model setValue:[NSNumber numberWithFloat:progress] forKey:@"lastProgress"];
    NSLog(@"%@-下载进度:%f",model.downloadUrl,progress);
}

// 下载完成调用
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    // location还是一个临时路径,需要自己挪到需要的路径(caches下面)
    BTDownloadModel * model=[self modelWithTask:downloadTask];
    NSData * data=[NSData dataWithContentsOfURL:location];
    NSString * path =[NSString stringWithFormat:@"%@/%@",BTFileHelp.documentPath,model.saveFolder];
    [BTFileHelp saveFileWithPath:path fileName:model.saveName data:data];
    [self changeModelStatus:model status:BTDownloadStatusFinish];
    NSLog(@"%@,下载完成",model.downloadUrl);
}

#pragma mark NSURLSessionTaskDelegate
//任务完成调用
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error{
    BTDownloadModel * model=[self modelWithTask:(NSURLSessionDownloadTask*)task];
    SEL selector = NSSelectorFromString(@"clearDownloadData");
    ((void (*)(id, SEL))[model methodForSelector:selector])(model, selector);
    [self.dataModel removeObject:model];
    if (error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // UI更新代码
            for (id<BTDownloadDelegate> delegate in self.delegates) {
                if (delegate&&[delegate respondsToSelector:@selector(downloadError:error:)]) {
                    [delegate downloadError:model error:error];
                }
            }
        });
    }
    if (self.waitModel.count!=0) {
        [self startDownLoad:self.waitModel[0]];
        [self.waitModel removeObjectAtIndex:0];
    }
}





@end
