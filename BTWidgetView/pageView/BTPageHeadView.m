//
//  BTPageHeadView.m
//  live
//
//  Created by stonemover on 2019/7/29.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "BTPageHeadView.h"
#import "BTPageView.h"
#import "UIView+BTViewTool.h"

@interface BTPageHeadView()

@property (nonatomic, strong) NSMutableArray<UIView*> * childViews;

@property (nonatomic, assign) BTPageHeadViewStyle style;

@property (nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, weak) BTPageView * pageView;

@property (nonatomic, assign) CGFloat viewIndicatorOriWidth;


@end


@implementation BTPageHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    [self initSelf];
    return self;
}

- (void)initSelf{
    self.childViews=[NSMutableArray new];
    self.scrollView=[[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.showsVerticalScrollIndicator=NO;
    self.scrollView.showsHorizontalScrollIndicator=NO;
    [self addSubview:self.scrollView];
    self.isNeedClickAnim=YES;
}


- (void)initViewIndicator:(CGSize)size corner:(CGFloat)corner bgColor:(UIColor*)color{
    if (self.viewIndicator) {
        [self.viewIndicator removeFromSuperview];
        self.viewIndicator=nil;
    }
    self.viewIndicator=[[UIView alloc] initWithSize:size];
    self.viewIndicator.corner=corner;
    self.viewIndicatorOriWidth = size.width;
    self.viewIndicator.backgroundColor=color;
    [self.scrollView addSubview:self.viewIndicator];
}

- (void)reloadData{
    if (!self.dataSource) {
        return;
    }
    
    if (![self.dataSource respondsToSelector:@selector(pageHeadViewNumOfItem:)]) {
        return;
    }
    
    if (![self.dataSource respondsToSelector:@selector(pageHeadView:contentViewForIndex:)]) {
        return;
    }
    
    if (![self.dataSource respondsToSelector:@selector(pageHeadViewStyle:)]) {
        return;
    }
    
    [self clearData];
    
    NSInteger total=[self.dataSource pageHeadViewNumOfItem:self];
    
    self.style=[self.dataSource pageHeadViewStyle:self];
    
    [self.scrollView setContentInset:UIEdgeInsetsMake(0, self.leftPadding, 0, self.rightPadding)];
    
    CGFloat startX=0;
    
    for (int i=0; i<total; i++) {
        UIView * view =[self.dataSource pageHeadView:self contentViewForIndex:i];
        
        
        UIView * rootView =nil;
        
        switch (self.style) {
            case BTPageHeadViewStyleDefault:
            {
                rootView=[[UIView alloc] initWithSize:CGSizeMake(view.width, self.scrollView.height)];
                view.center=CGPointMake(rootView.width/2.0, rootView.height/2.0);
            }
                break;
            case BTPageHeadViewStyleAverage:
            {
                rootView=[[UIView alloc] initWithSize:CGSizeMake((self.scrollView.width-self.leftPadding-self.rightPadding)/total, self.scrollView.height)];
                view.center=CGPointMake(rootView.width/2.0, rootView.height/2.0);
            }
                break;
        }
        
        
        [rootView addSubview:view];
        UIButton * btn =[[UIButton alloc] initWithSize:rootView.size];
        btn.tag=i;
        [btn addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [rootView addSubview:btn];
        rootView.left=startX;
        if (i==0) {
            self.viewIndicator.centerX=rootView.centerX;
            self.viewIndicator.top=self.height-self.viewIndicator.height-self.viewIndicatorBottomPadding;
        }
        [self.childViews addObject:rootView];
        [self.scrollView addSubview:rootView];
        if(self.style == BTPageHeadViewStyleDefault && i < total - 1){
            startX+=rootView.width + self.itemMarin;
        }else{
            startX+=rootView.width;
        }
        
    }
    
    [self.scrollView setContentSize:CGSizeMake(startX, self.scrollView.height)];
    
}

- (void)itemClick:(UIButton*)btn{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(pageHeadViewItemClick:)]) {
        [self.delegate pageHeadViewItemClick:btn.tag];
    }
    NSNumber * number = [self.pageView valueForKey:@"nowIndex"];
    if (number.integerValue == btn.tag) {
        return;
    }
    [self.pageView selectIndex:btn.tag animated:self.isNeedClickAnim];
    
}

- (void)clearData{
    for (UIView * view in self.childViews) {
        [view removeFromSuperview];
    }
    
    [self.childViews removeAllObjects];
}

- (void)scrollViewIndicator:(CGFloat)percent{
    
}


- (void)scrollViewItemPercent:(CGFloat)percent{
    if (self.childViews.count < 2) {
        return;
    }
    
    NSNumber * number   = [self.pageView valueForKey:@"nowIndex"];
    NSInteger nowIndex = number.integerValue;
    
    NSInteger needAddIndex = 0;
    CGFloat percentAbs = fabs(percent);
    while (percentAbs > 1) {
        needAddIndex ++;
        percentAbs --;
    }
    
    if (percent > 0) {
        nowIndex += needAddIndex;
        percent = percent - needAddIndex;
    }else{
        nowIndex -= needAddIndex;
        percent = percent + needAddIndex;
    }
    
    CGFloat startX = 0;
    CGFloat endX = 0;
    if (percent > 0) {
        //往下一个滑动，加一层判断防止在全面屏，设置全屏的时候出现越界
        if (nowIndex<self.childViews.count && nowIndex >= 0) {
            startX = self.childViews[nowIndex].centerX;
        }
        if (nowIndex + 1 < self.childViews.count && nowIndex +1 >= 0) {
            endX = self.childViews[nowIndex + 1].centerX;
        }
        
    }else if(percent < 0){
        //往上一个滑动,加一层判断防止在全面屏，设置全屏的时候出现越界
        if (nowIndex<self.childViews.count && nowIndex >= 0) {
            startX = self.childViews[nowIndex].centerX;
        }
        if (nowIndex - 1 < self.childViews.count && nowIndex -1 >=0) {
            endX = self.childViews[nowIndex - 1].centerX;
        }
        
    }else{
        startX = 0;
        endX = 0;
    }
    if (self.isViewIndicatorBounce) {
        CGFloat maxWidth = fabs(endX - startX) + self.viewIndicatorOriWidth;
        
        if (percent > 0) {
            
            CGFloat maxRight = endX + self.viewIndicatorOriWidth / 2.0;
            if (percent < 0.5) {
                self.viewIndicator.width = maxWidth * (percent * 2 ) < self.viewIndicatorOriWidth? self.viewIndicatorOriWidth :  maxWidth * (percent * 2 );
                if (self.viewIndicator.right > maxRight) {
                    self.viewIndicator.width = maxWidth;
                    self.viewIndicator.right = maxRight;
                }
            }else{
                self.viewIndicator.width = maxWidth * ((1 - percent) * 2) < self.viewIndicatorOriWidth? self.viewIndicatorOriWidth : maxWidth * ((1 - percent) * 2);
                self.viewIndicator.right = maxRight;
                
            }
        }else if(percent < 0){
            CGFloat minLeft = endX - self.viewIndicatorOriWidth / 2.0;
            CGFloat maxRight = startX + self.viewIndicatorOriWidth / 2.0;
            if (fabs(percent) < 0.5) {
                self.viewIndicator.width = maxWidth * (fabs(percent) * 2 ) < self.viewIndicatorOriWidth? self.viewIndicatorOriWidth :  maxWidth * (fabs(percent) * 2 );
                self.viewIndicator.right = maxRight;
                if (self.viewIndicator.left < minLeft) {
                    self.viewIndicator.width = maxWidth;
                    self.viewIndicator.left = minLeft;
                }
            }else{
                self.viewIndicator.width = maxWidth * ((1 - fabs(percent)) * 2) < self.viewIndicatorOriWidth? self.viewIndicatorOriWidth : maxWidth * ((1 - fabs(percent)) * 2);
                self.viewIndicator.left = minLeft;
            }
        }
    }else{
        //reload 的时候如果停在最后一个选项卡会造成越界
        if (nowIndex < self.childViews.count) {
            self.viewIndicator.centerX = (endX - startX) * fabs(percent) +self.childViews[nowIndex].centerX;
        }
    }
    
    
}

- (void)selectIndex:(NSInteger)index{
    if (self.style == BTPageHeadViewStyleDefault && self.scrollView.contentSize.width > self.width) {
        CGFloat result = self.childViews[index].centerX - self.width /2.0;
        if (result > 0){
            if (self.width + result <= self.scrollView.contentSize.width) {
                [self.scrollView setContentOffset:CGPointMake(result, 0) animated:YES];
            }else{
                [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentSize.width + self.rightPadding - self.width, 0) animated:YES];
            }
            
        }else{
            [self.scrollView setContentOffset:CGPointMake(-self.leftPadding, 0) animated:YES];
        }
    }
}


@end
