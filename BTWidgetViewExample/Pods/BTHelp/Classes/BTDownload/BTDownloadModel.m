//
//  BTDownloadModel.m
//  huashi
//
//  Created by stonemover on 16/8/13.
//  Copyright © 2016年 StoneMover. All rights reserved.
//

#import "BTDownloadModel.h"
#import "BTDownloadMananger.h"
#import "BTFileHelp.h"

@interface BTDownloadModel()


@end



@implementation BTDownloadModel


- (instancetype)initWithUrl:(NSString*)url savePath:(NSString*)savePath saveName:(NSString*)saveName{
    self=[super init];
    _downloadUrl=url;
    _saveFolder=savePath;
    _saveName=saveName;
    [self initSelf];
    return self;
}

- (void)initSelf{
    if ([BTUtils isEmpty:self.saveFolder]) {
        _saveFolder=@"bt_download";
    }
    
    if ([BTUtils isEmpty:self.saveName]) {
        NSArray * array=[self.downloadUrl componentsSeparatedByString:@"/"];
        if (array.count!=0) {
            _saveName=[array lastObject];
        }else{
            _saveName=self.downloadUrl;
        }
    }
    
    _path=[NSString stringWithFormat:@"%@/%@",self.saveFolder,self.saveName];
    
    if ([self checkIsHasDownFinish]) {
        _status=BTDownloadStatusFinish;
    }
}



-(void)clearDownloadData{
    _progress=0;
    _lastProgress=0;
    _isReplay=NO;
    _hasSaveInLocation=0;
    _fileTotalSize=0;
    _loadedProgress=0;
    _task=nil;
}


-(BOOL)checkIsHasDownFinish{
    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
    NSDictionary * dic=[defaults objectForKey:self.downloadUrl];
    if (!dic) {
        return NO;
    }
    NSString * totalSize=[dic objectForKey:BTDownloadTotalSizeKey];
    NSString * loadedSize=[dic objectForKey:BTDownloadLoadedSizeKey];
    //文件存在校验,如果需要更精准需要做文件大小的校验

    NSLog(@"%@相关信息:",self.downloadUrl);
    NSLog(@"plist中总大小:%@;已经下载大小%@",totalSize,loadedSize);
    NSString * path =[NSString stringWithFormat:@"%@/%@",BTFileHelp.documentPath,self.path];
    if ([totalSize isEqualToString:loadedSize]) {
        //文件已经下载完成
        if ([BTFileHelp isFileExit:path]) {
            //检验文件长度
            NSData * data=[NSData dataWithContentsOfFile:path];
            NSLog(@"实际本地文件大小%lu",(unsigned long)data.length);
            if (data.length==totalSize.longLongValue) {
                _progress=1.0;
                return YES;
            }else{
                NSLog(@"下载存储信息显示已下载,但文件长度大小不对");
                _isReplay=NO;
                [self deleteFileDownloadInfo];
            }
        }else{
            //本地文件不存在,但下载记录中显示该文件已经下载完成,故需要删除掉下载记录
            NSLog(@"下载存储信息显示已下载,但文件不存在");
            _isReplay=NO;
            [self deleteFileDownloadInfo];
        }
    }else{
        NSData * data=[NSData dataWithContentsOfFile:path];
        NSLog(@"实际本地文件大小%lu",(unsigned long)data.length);
        if (data.length==loadedSize.longLongValue) {
            _isReplay=YES;
            _hasSaveInLocation=loadedSize.longLongValue;
            _fileTotalSize=totalSize.longLongValue;
            _loadedProgress=1.0*self.hasSaveInLocation/self.fileTotalSize;
            _progress=self.loadedProgress;
        }else{
            NSLog(@"下载存储信息与文件长度大小不对,将plist大小改为实际大小");
            _isReplay=YES;
            _hasSaveInLocation=data.length;
            _fileTotalSize=totalSize.longLongValue;
            _loadedProgress=1.0*self.hasSaveInLocation/self.fileTotalSize;
            _progress=self.loadedProgress;
            [self saveFileDownloadedSize:[NSString stringWithFormat:@"%lu",(unsigned long)data.length] totalSize:totalSize];
        }
    }
    return NO;
}

-(void)deleteFileDownloadInfo{
    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
    if (self.saveName.length!=0) {
        NSString * filePath=@"";
        filePath=[NSString stringWithFormat:@"%@/%@",self.saveFolder,self.saveName];
        [BTFileHelp deleteFile:filePath];
    }
    
    [defaults removeObjectForKey:self.downloadUrl];
}

-(void)saveFileDownloadedSize:(NSString*)loadedfileSize totalSize:(NSString*)totalSize{
    if (self.isReplay) {
        totalSize=[NSString stringWithFormat:@"%lld",self.fileTotalSize];
        int64_t loadedTotalSize=self.hasSaveInLocation+loadedfileSize.longLongValue;
        loadedfileSize=[NSString stringWithFormat:@"%lld",loadedTotalSize];
    }
    
    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
    NSDictionary * dic=@{BTDownloadTotalSizeKey:totalSize,BTDownloadLoadedSizeKey:loadedfileSize};
    [defaults setValue:dic forKey:self.downloadUrl];
}


@end
