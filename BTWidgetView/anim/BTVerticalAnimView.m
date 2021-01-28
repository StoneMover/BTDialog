//
//  BTVerticalAnimView.m
//  live
//
//  Created by stonemover on 2019/5/10.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "BTVerticalAnimView.h"
#import "BTTimerHelp.h"
#import "UIView+BTViewTool.h"

@interface BTVerticalAnimView()<BTTimerHelpDelegate>

@property (nonatomic, assign) CGFloat w;

@property (nonatomic, assign) CGFloat h;

@property (nonatomic,assign) NSInteger totalNum;

@property (nonatomic,strong) NSMutableArray * cacheViews;

@property (nonatomic,strong) BTTimerHelp * timerHelp;

@property (nonatomic,assign) NSInteger nowIndex;

@property (nonatomic, assign) CGFloat padding;

@property (nonatomic, assign) CGFloat pauseTime;

@end


@implementation BTVerticalAnimView


- (instancetype)initWithFrame:(CGRect)frame padding:(CGFloat)padding pauseTime:(NSInteger)time{
    self=[super initWithFrame:frame];
    self.w=frame.size.width;
    self.h=frame.size.height;
    self.padding=padding;
    self.pauseTime=time;
    [self initSelf];
    return self;
}

-(void)initSelf{
    self.cacheViews=[[NSMutableArray alloc]init];
    self.clipsToBounds=YES;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    [self initSelf];
    return self;
}



-(void)BTTimeChanged:(BTTimerHelp*)smTimerHelp{
    UIView * viewNow=[self getViewNow];
    UIView * viewNext=[self getNextView];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (self.isHoz) {
            viewNow.frame=CGRectMake(-self.w-self.padding, 0, self.w, self.h);
            viewNext.frame=CGRectMake(0, 0, self.w, self.h);
        }else{
            viewNow.frame=CGRectMake(0, -self.h-self.padding, self.w, self.h);
            viewNext.frame=CGRectMake(0, 0, self.w, self.h);
        }
        
    } completion:^(BOOL finished) {
        self.nowIndex++;
        if (self.nowIndex>=self.totalNum) {
            self.nowIndex=0;
        }

        if (viewNow&&![self.cacheViews containsObject:viewNow]) {
            [self.cacheViews addObject:viewNow];
        }

        UIView * view=[self.delegate BTVerticalAnimView:self viewWithIndex:self.nowIndex];
        if ([self.cacheViews containsObject:view]) {
            [self.cacheViews removeObject:view];
        }
        if (self.isHoz) {
            view.frame=CGRectMake(self.w+self.padding, 0, self.w, self.h);
        }else{
            view.frame=CGRectMake(0, self.padding+self.h, self.w, self.h);
        }

        if ([view superview]!=self) {
            [self addSubview:view];
        }
    }];
}



-(void)updateTotalNum{
    self.totalNum=[self.delegate BTVerticalAnimViewNumOfRows:self];
}

-(void)reload{
    [self initTimer];
    [self.timerHelp pause];
    
    [self.cacheViews removeAllObjects];
    [self bt_removeAllChildView];
    [self updateTotalNum];
    self.nowIndex=0;
    UIView * viewNow=[self.delegate BTVerticalAnimView:self viewWithIndex:self.nowIndex];
    viewNow.frame=CGRectMake(0, 0, self.w, self.h);
    [self addSubview:viewNow];
    
    if (self.totalNum>1) {
        self.nowIndex++;
    }
    
    UIView * viewNext=[self.delegate BTVerticalAnimView:self viewWithIndex:self.nowIndex];
    if (self.isHoz) {
        viewNext.frame=CGRectMake(self.w+self.padding, 0, self.w, self.h);
    }else{
        viewNext.frame=CGRectMake(0, self.padding+self.h, self.w, self.h);
    }
    [self addSubview:viewNext];
    
    [self.timerHelp start];
    
}



#pragma mark 辅助方法
-(void)initTimer{
    if (self.timerHelp==nil) {
        self.timerHelp=[[BTTimerHelp alloc]init];
        self.timerHelp.delegate=self;
        self.timerHelp.changeTime=self.pauseTime;
    }
}

-(UIView*)getViewNow{
    for (UIView * view in self.subviews) {
        if (!self.isHoz&&view.frame.origin.y==0) {
            return view;
        }
        
        if (self.isHoz&&view.frame.origin.x==0) {
            return view;
        }
    }
    return nil;
}

-(UIView*)getNextView{
    for (UIView * view in self.subviews) {
        if (!self.isHoz&&view.frame.origin.y==self.h+self.padding) {
            return view;
        }
        
        if (self.isHoz&&view.frame.origin.x==self.w+self.padding) {
            return view;
        }
    }
    return nil;
}


-(UIView*)getCacheView{
    if (self.cacheViews.count!=0) {
        return self.cacheViews[0];
    }
    return nil;
}

-(void)dealloc{
    [self.timerHelp stop];
}

@end



