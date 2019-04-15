//
//  SMTimerHelp.h
//  Base
//
//  Created by whbt_mac on 15/12/5.
//  Copyright © 2015年 StoneMover. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BTTimerHelp;
@protocol BTTimerHelpDelegate <NSObject>

@required
-(void)BTTimeChanged:(BTTimerHelp*)smTimerHelp;

@end

typedef void(^SMTimerChnagedBlock)(void);

@interface BTTimerHelp : NSObject


@property(nonatomic,weak)id<BTTimerHelpDelegate> delegate;

@property(nonatomic,assign)float changeTime;//间隔时间,必须设置,且只能设置一次

@property(nonatomic,strong,readonly)NSTimer * timer;//

@property(nonatomic,assign,readonly)BOOL isStart;//是否已经开始

@property(nonatomic,assign,readonly)int totalTime;//计时器目前跑的总的时间

@property (nonatomic, copy) SMTimerChnagedBlock block;//时间变化后的block回调

/**
 *  @author StoneMover, 15-12-05 17:12:39
 *
 *  @brief 开始,暂停后重新开始,调用相同的方法
 */
-(void)start;
/**
 *  @author StoneMover, 15-12-05 17:12:34
 *
 *  @brief 暂停
 */
-(void)pause;
/**
 *  @author StoneMover, 15-12-05 17:12:20
 *
 *  @brief 不使用的调用,销毁
 */
-(void)stop;


-(void)resetTotalTime;

@end
