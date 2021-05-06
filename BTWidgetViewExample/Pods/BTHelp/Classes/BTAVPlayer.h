//
//  BTAVPlayer.h
//  Converse
//
//  Created by liao on 2020/12/5.
//  Copyright © 2020 baiPeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,BTAVPlayerStatus) {
    BTAVPlayerStatusDefault = 0,
    BTAVPlayerStatusPlaying,
    BTAVPlayerStatusPause,
    BTAVPlayerStatusFinish,
    BTAVPlayerStatusError
};


@protocol BTAVPlayerDelegate <NSObject>

@optional

- (void)BTAVPlayerStatusChange:(NSURL*)url status:(BTAVPlayerStatus)status;

- (void)BTAVPlayerInitItemError:(NSString*)url;

- (void)BTAVPlayerProgress:(NSURL*)url totalTime:(CGFloat)totalTime nowTime:(CGFloat)nowTime;

@end

@interface BTAVPlayer : NSObject

+ (instancetype)share;

- (void)addDelegate:(id<BTAVPlayerDelegate> )delegate;

- (void)removeDelegate:(id<BTAVPlayerDelegate> )delegate;

- (void)play:(NSString *)url;

- (void)stop;

- (void)pause;

- (void)resume;

- (BOOL)isPlaying:(NSString*)url;

- (void)seekToTime:(CGFloat)time;

- (void)seekToPersent:(CGFloat)persent;

@end

NS_ASSUME_NONNULL_END
