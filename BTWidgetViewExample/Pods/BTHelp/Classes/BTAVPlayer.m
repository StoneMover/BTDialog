//
//  BTAVPlayer.m
//  Converse
//
//  Created by liao on 2020/12/5.
//  Copyright © 2020 baiPeng. All rights reserved.
//

#import "BTAVPlayer.h"

static BTAVPlayer * player = nil;

@interface BTAVPlayer()

@property (nonatomic, strong) NSMutableArray<id<BTAVPlayerDelegate>> * delegates;

@property (nonatomic, strong) AVPlayer * player;

@property (nonatomic, strong) NSURL * nowUrl;

@property (nonatomic, assign) BTAVPlayerStatus status;

@property (nonatomic, strong) id timeObserver;

@end


@implementation BTAVPlayer

+ (instancetype)share{
    if (player == nil) {
        player = [BTAVPlayer new];
    }
    return player;
}

- (instancetype)init{
    self = [super init];
    self.delegates = [NSMutableArray new];
    return self;
}

- (void)addDelegate:(id<BTAVPlayerDelegate> )delegate{
    [self.delegates addObject:delegate];
}

- (void)removeDelegate:(id<BTAVPlayerDelegate> )delegate{
    [self.delegates removeObject:delegate];
}

- (void)play:(NSString *)url{
    NSURL * urlResult  = nil;
    if ([url hasPrefix:@"http"]) {
        urlResult = [NSURL URLWithString:url];
    }else{
        urlResult = [NSURL fileURLWithPath:url];
    }
    if (urlResult == nil) {
        for (id<BTAVPlayerDelegate> delegate in self.delegates) {
            if (delegate&&[delegate respondsToSelector:@selector(BTAVPlayerInitItemError:)]) {
                [delegate BTAVPlayerInitItemError:url];
            }
        }
        return;
    }
    
    [self stop];
    
    self.nowUrl = urlResult;
    AVPlayerItem * songItem = [AVPlayerItem playerItemWithURL:urlResult];
    
    if (!self.player) {
        self.player = [AVPlayer playerWithPlayerItem:songItem];
        self.player.volume=1;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playFinishNotify:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }else{
        [self.player replaceCurrentItemWithPlayerItem:songItem];
    }
    [self addObserver:songItem];
    self.status = BTAVPlayerStatusPlaying;
    for (id<BTAVPlayerDelegate> delegate in self.delegates) {
        if (delegate&&[delegate respondsToSelector:@selector(BTAVPlayerStatusChange:status:)]) {
            [delegate BTAVPlayerStatusChange:self.nowUrl status:BTAVPlayerStatusPlaying];
        }
    }
    [self.player play];
}


- (void)stop{
    if (self.status == BTAVPlayerStatusDefault) {
        return;
    }
    for (id<BTAVPlayerDelegate> delegate in self.delegates) {
        if (delegate&&[delegate respondsToSelector:@selector(BTAVPlayerStatusChange:status:)]) {
            [delegate BTAVPlayerStatusChange:self.nowUrl status:BTAVPlayerStatusFinish];
        }
    }
    self.status = BTAVPlayerStatusDefault;
    [self removeCurrentItemObserve];
    self.nowUrl = nil;
    [self.player replaceCurrentItemWithPlayerItem:nil];
}

- (void)pause{
    if (self.status != BTAVPlayerStatusPlaying) {
        return;
    }
    self.status = BTAVPlayerStatusPause;
    for (id<BTAVPlayerDelegate> delegate in self.delegates) {
        if (delegate&&[delegate respondsToSelector:@selector(BTAVPlayerStatusChange:status:)]) {
            [delegate BTAVPlayerStatusChange:self.nowUrl status:BTAVPlayerStatusPause];
        }
    }
    [self.player pause];
}

- (void)resume{
    if (self.status != BTAVPlayerStatusPause) {
        return;
    }
    
    self.status = BTAVPlayerStatusPlaying;
    for (id<BTAVPlayerDelegate> delegate in self.delegates) {
        if (delegate&&[delegate respondsToSelector:@selector(BTAVPlayerStatusChange:status:)]) {
            [delegate BTAVPlayerStatusChange:self.nowUrl status:BTAVPlayerStatusPlaying];
        }
    }
    [self.player play];
}


- (BOOL)isPlaying:(NSString*)url{
    if (!self.nowUrl) {
        return  NO;
    }
    
    return [self.nowUrl.absoluteString isEqualToString:url];
}

- (void)seekToTime:(CGFloat)time{
    NSTimeInterval nowTime = time;
    [self.player seekToTime:CMTimeMake(nowTime, 1) completionHandler:^(BOOL finished) {
        
    }];
}

- (void)seekToPersent:(CGFloat)percent{
    [self seekToTime:percent * CMTimeGetSeconds(self.player.currentItem.duration)];
}

#pragma mark AVPlayerItem相关
- (void)removeCurrentItemObserve{
    if (self.player && self.player.currentItem) {
        if (self.timeObserver) {
            [self.player removeTimeObserver:self.timeObserver];
            self.timeObserver = nil;
        }
        
        [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    }
}

- (void)playFinishNotify:(NSNotification*)obj{
    if (obj.object && [obj.object isKindOfClass:[AVPlayerItem class]] && obj.object==self.player.currentItem) {
        [self stop];
    }
    
}

-(void)addObserver:(AVPlayerItem *)item{
    [item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    __weak BTAVPlayer * weakSelf=self;
    self.timeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        float current = CMTimeGetSeconds(time);
        float total = CMTimeGetSeconds(item.duration);
        NSLog(@"BTAVPlayer progres current/total : %f/%f",current,total);
        if (isnan(total) || isnan(current)) {
            return;
        }
        for (id<BTAVPlayerDelegate> delegate in weakSelf.delegates) {
            if (delegate&&[delegate respondsToSelector:@selector(BTAVPlayerProgress:totalTime:nowTime:)]) {
                [delegate BTAVPlayerProgress:weakSelf.nowUrl totalTime:total nowTime:current];
            }
        }
    }];
}


#pragma mark KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status = [[change objectForKey:@"new"] intValue];
        if (status == AVPlayerStatusFailed || status == AVPlayerStatusUnknown){
            //第一次播放错误后无法再次监听此回调，需要重置player对象为nil再次初始化
            for (id<BTAVPlayerDelegate> delegate in self.delegates) {
                if (delegate&&[delegate respondsToSelector:@selector(BTAVPlayerStatusChange:status:)]) {
                    [delegate BTAVPlayerStatusChange:self.nowUrl status:BTAVPlayerStatusError];
                }
            }
            [self stop];
            [[NSNotificationCenter defaultCenter]removeObserver:self];
            self.player=nil;
        }
    }
}

@end
