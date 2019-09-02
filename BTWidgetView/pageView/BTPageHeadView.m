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

@property (nonatomic, assign) CGFloat viewIndicatorStartCenterX;

@property (nonatomic, assign) CGFloat viewIndicatorEndCenterX;

@property (nonatomic, weak) BTPageView * pageView;


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
            self.viewIndicatorStartCenterX=rootView.centerX;
            self.viewIndicator.centerX=self.viewIndicatorStartCenterX;
            self.viewIndicator.top=self.height-self.viewIndicator.height-self.viewIndicatorBottomPadding;
        }
        
        if (i==total-1) {
            self.viewIndicatorEndCenterX=rootView.centerX;
        }
        [self.childViews addObject:rootView];
        [self.scrollView addSubview:rootView];
        startX+=rootView.width;
    }
    
    [self.scrollView setContentSize:CGSizeMake(startX, self.scrollView.height)];
    
}

- (void)itemClick:(UIButton*)btn{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(pageHeadViewItemClick:)]) {
        [self.delegate pageHeadViewItemClick:btn.tag];
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
    CGFloat resultCenterX=(self.viewIndicatorEndCenterX-self.viewIndicatorStartCenterX)*percent+self.viewIndicatorStartCenterX;
    self.viewIndicator.centerX=resultCenterX;
}


@end
