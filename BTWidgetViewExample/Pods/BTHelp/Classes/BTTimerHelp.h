//
//  SMTimerHelp.h
//  Base
//
//  Created by whbt_mac on 15/12/5.
//  Copyright © 2015年 StoneMover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BTTimerHelp;
@protocol BTTimerHelpDelegate <NSObject>

@required
-(void)BTTimeChanged:(BTTimerHelp*)timer;

@end

typedef void(^BTTimerChangeBlock)(void);

@interface BTTimerHelp : NSObject

//间隔时间,必须设置,且只能设置一次
@property(nonatomic,assign)CGFloat changeTime;

//计时器目前跑的总的时间
@property(nonatomic,assign,readonly)CGFloat totalTime;


@property(nonatomic,weak)id<BTTimerHelpDelegate> delegate;

//时间变化后的block回调
@property (nonatomic, copy) BTTimerChangeBlock block;

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
