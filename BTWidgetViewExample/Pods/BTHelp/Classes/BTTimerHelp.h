//
//  SMTimerHelp.h
//  Base
//
//  Created by whbt_mac on 15/12/5.
//  Copyright © 2015年 StoneMover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BTTimerHelp;

@protocol BTTimerHelpDelegate <NSObject>

@optional

-(void)BTTimeChanged:(BTTimerHelp*)timer;

@end

typedef void(^BTTimerChangeBlock)(void);

@interface BTTimerHelp : NSObject

//间隔时间,必须调用设置
@property(nonatomic,assign)CGFloat changeTime;

//计时器目前跑的总的时间
@property(nonatomic,assign,readonly)CGFloat totalTime;


@property(nonatomic,weak,nullable)id<BTTimerHelpDelegate> delegate;

//时间变化后的block回调
@property (nonatomic, copy) BTTimerChangeBlock block;

//开始,暂停后重新开始,调用相同的方法
-(void)start;

//暂停
-(void)pause;

//不使用的调用,销毁
-(void)stop;

//设置totalTime为0
-(void)resetTotalTime;

@end


NS_ASSUME_NONNULL_END
