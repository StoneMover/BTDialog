//
//  BTRecordVoice.m
//  road
//
//  Created by stonemover on 2017/6/17.
//  Copyright © 2017年 stonemover. All rights reserved.
//

#import "BTRecordVoiceView.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import <AudioToolbox/AudioToolbox.h>
#import <BTHelp/BTTimerHelp.h>
#import "BTUtils.h"
#include "lame.h"
#import <BTHelp/NSDate+BTDate.h>
#import <BTHelp/BTFileHelp.h>


const int moveCancelDistance=20;//取消移动的距离

@interface BTRecordVoiceView()<BTTimerHelpDelegate>

@property (nonatomic, strong) AVAudioRecorder * recorder;

@property (weak, nonatomic) IBOutlet UILabel *labelTime;

@property (nonatomic, strong) BTTimerHelp * timerHelp;//计时器对象

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *soundViewArray;


@property (nonatomic, assign) BOOL isRecord;//是否在录音中

@property (nonatomic, assign) int  startY;//按下的y坐标

@property (nonatomic, assign) int  endY;//结束的y坐标

@end

@implementation BTRecordVoiceView

-(instancetype)init:(NSString*)savePath config:(NSDictionary*)config maxRecordTime:(int)time{
    self=[super init];
    self.savePath=savePath;
    self.recordConfigDic=config;
    self.maxRecordTime=time;
    return self;
}

-(void)initSelf{
    self.frame=CGRectMake(0, 0, 303, 202);
    self.multipleTouchEnabled=NO;
    
    UIView * soundView=[self viewWithTag:11];
    self.soundViewArray=soundView.subviews;
    [self autoShowView:0];
    
    self.label=[self viewWithTag:2];
    self.labelTime=[self viewWithTag:10];
    
    self.timerHelp =[[BTTimerHelp alloc]init];
    self.timerHelp.changeTime=0.005;
    self.timerHelp.delegate=self;
    
    if (self.maxRecordTime==0) {
        self.maxRecordTime=30;
    }
}

#pragma mark 录音触摸事件控制
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
////    self.label.text=@"松开结束录音";
////    self.startY=0;
////    self.endY=0;
////    UITouch * touch=[touches anyObject];
////    CGPoint point = [touch  locationInView:self];
////    self.startY=point.y;
////    [self startRecordVoice];
//}
//
//-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
////    UITouch * touch=[touches anyObject];
////    CGPoint point = [touch  locationInView:self];
////    if (self.startY-point.y>moveCancelDistance) {
////        self.label.text=@"松开取消录音";
////    }else{
////        self.label.text=@"松开结束录音";
////    }
//}
//
//-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
////    self.label.text=@"按下开始录音";
////    UITouch * touch=[touches anyObject];
////    CGPoint point = [touch  locationInView:self];
////    self.endY=point.y;
////
////    if (self.startY-self.endY>moveCancelDistance) {
////        //上滑取消录音
////        [self stopRecordVoice];
////        [BTUtils deleteFile:self.savePath];
////    }else{
////        [self stopRecordVoice];
////    }
//
//}

//开始录音
-(void)startRecordVoice{
    //初始化默认参数
    if (!self.savePath) {
        NSString * time = [[NSDate bt_initLocalDate] bt_dateStr:@"YYYYMMddHHmmss"];
        self.savePath=[NSString stringWithFormat:@"%@/%@.wav",BTFileHelp.cacheVoicePath,time];
    }
    
    if (!self.recordConfigDic) {
        self.recordConfigDic=[self getConfig];
    }
    
    if (self.maxRecordTime==0) {
        self.maxRecordTime=30;
    }
    
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    NSError *error = nil;
    NSURL * url=[NSURL URLWithString:self.savePath];
    self.recorder = [[ AVAudioRecorder alloc] initWithURL:url settings:self.recordConfigDic error:&error];
    self.recorder.meteringEnabled = YES;
    if ([self.recorder prepareToRecord] == YES){
        self.recorder.meteringEnabled = YES;
        [self.recorder record];
        [self.timerHelp start];
    }else {
        NSLog(@"FlyElephant--初始化录音失败");
    }
}

//停止录音
-(void)stopRecordVoice{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [self.timerHelp pause];
    if ([self.recorder isRecording]) {
        [self.recorder stop];
    }
    if (self.block) {
        self.block(self.savePath,self.timerHelp.totalTime);
    }
}

//获取录音参数配置
- (NSDictionary *)getConfig{
    
    NSDictionary *result = nil;
    
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init];
    //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:44100] forKey:AVSampleRateKey];
    
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
        
    //录音通道数  1 或 2
    [recordSetting setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
   
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityMedium] forKey:AVEncoderAudioQualityKey];
    
    result = [NSDictionary dictionaryWithDictionary:recordSetting];
    return result;
}

#pragma mark 计时器回调
-(void)BTTimeChanged:(BTTimerHelp*)timer{
    self.labelTime.text=[BTUtils convertSecToTime:self.maxRecordTime-timer.totalTime];
    [self refreshSound];
    if (timer.totalTime>=self.maxRecordTime) {
        [self stopRecordVoice];
        return;
    }
}

//设置最大的录音时间
-(void)setMaxRecordTime:(int)maxRecordTime{
    _maxRecordTime=maxRecordTime;
    self.labelTime.text=[BTUtils convertSecToTime:_maxRecordTime];
}


-(void)dealloc{
    [self.timerHelp stop];
}


+(void)convertWavToMp3:(NSString*)wavFilePath withSavePath:(NSString*)savePath withBlock:(BTRecordConvertBlock)block
{
    @try {
        int read, write;
        
        FILE *pcm = fopen([wavFilePath cStringUsingEncoding:1], "rb");  //source 被转换的音频文件位置
        fseek(pcm, 4*1024,SEEK_CUR);                                   //skip file header
        FILE *mp3 = fopen([savePath cStringUsingEncoding:1], "wb");  //output 输出生成的Mp3文件位置
        
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        lame_set_in_samplerate(lame, 44100);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do {
            read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            fwrite(mp3_buffer, write, 1, mp3);
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
    }
    @catch (NSException *exception) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //更新UI操作
            block(exception.reason);
        });
        
    }
    @finally {
        dispatch_async(dispatch_get_main_queue(), ^{
            //更新UI操作
            NSLog(@"MP3生成成功: %@",savePath);
            block(nil);
        });
        
    }
    
}



-(void)refreshSound{
    
    [self.recorder updateMeters];
    double lowPassResults = pow(10, (0.05 * [self.recorder peakPowerForChannel:0]));
    if (0<lowPassResults<=0.27) {
//        NSLog(@"音量小");
        [self autoShowView:0];
    }else if (0.27<lowPassResults<=0.34) {
//        NSLog(@"音量较小");
        [self autoShowView:0];
    }else if (0.34<lowPassResults<=0.41) {
//        NSLog(@"音量中等");
        [self autoShowView:1];
    }else if (0.41<lowPassResults<=0.48) {
        [self autoShowView:2];
    }else if (0.48<lowPassResults<=0.55) {
//        NSLog(@"音量较大");
        [self autoShowView:3];
    }else if (0.55<lowPassResults) {
        [self autoShowView:4];
//        NSLog(@"音量很大");
    }
}

-(void)autoShowView:(int)index{
    for (int i=0; i<self.soundViewArray.count; i++) {
        UIView * view =self.soundViewArray[i];
        if (i<index) {
            view.hidden=NO;
        }else{
            view.hidden=YES;
        }
    }
}

@end
