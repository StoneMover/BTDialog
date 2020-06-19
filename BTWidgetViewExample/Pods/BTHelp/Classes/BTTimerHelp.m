//
//  SMTimerHelp.m
//  Base
//
//  Created by whbt_mac on 15/12/5.
//  Copyright © 2015年 StoneMover. All rights reserved.
//

#import "BTTimerHelp.h"

@interface BTTimerHelp()

@property(nonatomic,assign)BOOL isHasFire;

@property(nonatomic,strong)NSTimer * timer;

//是否已经开始
@property(nonatomic,assign,readonly)BOOL isStart;


@end

@implementation BTTimerHelp

- (instancetype)initTimerWithChangeTime:(CGFloat)changeTime{
    self=[super init];
    return self;
}

- (void)setChangeTime:(CGFloat)changeTime{
    _changeTime=changeTime;
    if (self.timer) {
        [self stop];
        self.timer=nil;
    }
    self.timer=[NSTimer timerWithTimeInterval:changeTime target:self selector:@selector(timeChanged) userInfo:nil repeats:YES];
    self.isHasFire = NO;
}

-(void)timeChanged{
    _totalTime+=_changeTime;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(BTTimeChanged:)]) {
        [self.delegate BTTimeChanged:self];
    }
    
    if (self.block) {
        self.block();
    }
}

-(void)start{
    if (!self.isHasFire) {
        self.isHasFire=YES;
        _isStart=YES;
        [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
    }else{
        if (_isStart) {
            return;
        }
        _isStart=YES;
        [self.timer setFireDate:[[NSDate alloc]initWithTimeIntervalSinceNow:_changeTime]];//重新开始的时间设置为间隔播放时间几秒后开始
    }
}
-(void)pause{
    if (!self.isHasFire||!_isStart) {
        return;
    }
    
     [self.timer setFireDate:[NSDate distantFuture]];//暂停
    _isStart=NO;
}

-(void)stop{
    [self.timer invalidate];
}

-(void)resetTotalTime{
    _totalTime=0;
}

@end
