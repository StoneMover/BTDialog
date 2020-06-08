//
//  BTRecordVoice.h
//  road
//
//  Created by stonemover on 2017/6/17.
//  Copyright © 2017年 stonemover. All rights reserved.
//

#import <UIKit/UIKit.h>

//录制声音完成后回调
typedef void(^BTRecordVoiceFinishBlock)(NSString* path,int recordTime);

//转换声音完成后回调
typedef void (^BTRecordConvertBlock)(NSString*errorInfo);

@interface BTRecordVoiceView : UIView

//文件存储的路径,需要带文件名和文件后缀,如果没有会这是默认值
@property (nonatomic, strong) NSString * savePath;

//录音最大的时间范围,没有默认30秒
@property (nonatomic, assign) int maxRecordTime;

//录音配置字典,如果不设置将会默认值
@property (nonatomic, strong) NSDictionary * recordConfigDic;

//将wav格式转化为mp3
@property (nonatomic, copy) BTRecordVoiceFinishBlock block;

@property (weak, nonatomic) IBOutlet UILabel *label;


+(void)convertWavToMp3:(NSString*)wavFilePath withSavePath:(NSString*)savePath withBlock:(BTRecordConvertBlock)block;




-(void)startRecordVoice;

-(void)stopRecordVoice;

@end
