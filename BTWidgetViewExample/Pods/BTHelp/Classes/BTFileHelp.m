//
//  BTFileHelp.m
//  BTHelpExample
//
//  Created by apple on 2020/6/28.
//  Copyright © 2020 stonemover. All rights reserved.
//

#import "BTFileHelp.h"

@implementation BTFileHelp

+ (NSString*)homePath{
    return NSHomeDirectory();
}



+ (NSString*)documentPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return path;
}


+ (NSString*)cachePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return path;
}


+ (NSString*)libraryPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return path;
}


+ (NSString*)tmpPath{
    NSString *path = NSTemporaryDirectory();
    return path;
}

+ (NSString*)cachePicturePath{
    NSString * pic=[NSString stringWithFormat:@"%@/pic",[self cachePath]];
    if (![self isFileExit:pic]) {
        [self createPath:pic];
    }
    
    return pic;
}
+ (NSString*)cacheVideoPath{
    
    NSString * video =[NSString stringWithFormat:@"%@/video",[self cachePath]];
    if (![self isFileExit:video]) {
        [self createPath:video];
    }
    
    return video;
}

+ (NSString*)cacheVoicePath{
    NSString * voice=[NSString stringWithFormat:@"%@/voice",[self cachePath]];
    if (![self isFileExit:voice]) {
        [self createPath:voice];
    }
    return voice;
}


+ (BOOL)isFileExit:(NSString*)path{
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}


+ (void)deleteFile:(NSString*)path{
    if ([self isFileExit:path]) {
        NSError *error;
        [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        if (error) {
            NSLog(@"删除%@出错:%@",path,error.domain);
        }
    }
}


+ (void)copyFile:(NSString*)filePath toPath:(NSString*)path isOverride:(BOOL)overrid{
    NSFileManager * mananger=[NSFileManager defaultManager];
    if (overrid) {
        [self deleteFile:filePath];
    }else{
        if ([self isFileExit:path]) {
            return;
        }
    }
    [self deleteFile:path];
    
    NSString * parentPath=[path stringByDeletingLastPathComponent];
    if (![self isFileExit:parentPath]) {
        [self createPath:parentPath];
    }
    
    NSError * error;
    [mananger copyItemAtPath:filePath toPath:path error:&error];
    if (error) {
        NSLog(@"复制%@出错:%@",path,error.domain);
    }
}


+ (void)createPath:(NSString*)path{
    if (![self isFileExit:path]) {
        NSFileManager * fileManager=[NSFileManager defaultManager];
        NSString * parentPath=[path stringByDeletingLastPathComponent];
        if ([self isFileExit:parentPath]) {
            NSError * error;
            [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        }else{
            [self createPath:parentPath];
            [self createPath:path];
        }
        
    }
}

+ (void)createDocumentPath:(NSString*)path{
    NSString *pathRestul=[NSString stringWithFormat:@"%@/%@",[self documentPath],path];
    [self createPath:pathRestul];
}

+ (NSString*)saveFileWithPath:(NSString*)path fileName:(NSString*)fileName data:(NSData*)data{
    return [self saveFileWithPath:path fileName:fileName data:data isAppend:NO];
}

+ (NSString*)saveFileWithPath:(NSString*)path fileName:(NSString*)fileName data:(NSData*)data isAppend:(BOOL)isAppend{
    [self createPath:path];
    NSData * resultData=nil;
    NSString * resultPath=[NSString stringWithFormat:@"%@/%@",path,fileName];
    if ([self isFileExit:resultPath]&&isAppend) {
        NSMutableData * dataOri=[NSMutableData dataWithContentsOfFile:resultPath];
        [dataOri appendData:data];
        resultData=dataOri;
    }else{
        resultData=data;
    }
    
    [[NSFileManager defaultManager] createFileAtPath:resultPath contents:resultData attributes:nil];
    
    return [NSString stringWithFormat:@"%@/%@",path,fileName];
}



+ (NSArray*)getFolderAllFileName:(NSString*)folderPath fileType:(NSString*)fileType{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *myDirectoryEnumerator = [fileManager enumeratorAtPath:folderPath];  //baseSavePath 为文件夹的路径
    NSMutableArray *filePathArray = [[NSMutableArray alloc]init];   //用来存目录名字的数组
    NSString *file;
    while((file=[myDirectoryEnumerator nextObject]))     //遍历当前目录
    {
        if (fileType) {
            if([[file pathExtension] isEqualToString:fileType])  //取得后缀名为.xml的文件名
            {
                [filePathArray addObject:file];
            }
        }else{
            [filePathArray addObject:file];
        }
        
    }
    return filePathArray;
}

@end
