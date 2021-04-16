//
//  BTStickyPageView.m
//  BTWidgetViewExample
//
//  Created by apple on 2021/4/6.
//  Copyright © 2021 stone. All rights reserved.
//

#import "BTStickyPageView.h"
#import "UIView+BTViewTool.h"

@interface BTStickyPageView()<UIScrollViewDelegate>

@property (nonatomic, assign) CGFloat headViewHeight;

@property (nonatomic, assign) CGFloat segmentViewHeight;

@property (nonatomic, strong) BTPageView * pageView;

@property (nonatomic, strong) NSMutableArray<UIView *> * allViews;

@end



@implementation BTStickyPageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self initSelf];
    return self;
}

- (void)initSelf{
    self.allViews = [NSMutableArray new];
    self.delegate = self;
    
    self.showsVerticalScrollIndicator = NO;
    self.directionalLockEnabled = YES;
    self.bounces = YES;
    
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    self.panGestureRecognizer.cancelsTouchesInView = NO;
}

- (void)reloadStickyData{
    for (UIView * view in self.allViews) {
        [view removeFromSuperview];
    }
    self.headViewHeight = 0;
    self.segmentViewHeight = 0;
    self.pageView = nil;

    if (!self.stickyDataSource) {
        return;
    }

    if ([self.stickyDataSource respondsToSelector:@selector(BTStickyHeadView)]) {
        UIView * headView = [self.stickyDataSource BTStickyHeadView];
        self.headViewHeight = headView.BTHeight;
        [self.allViews addObject:headView];
        [self addSubview:headView];
        headView.BTTop = 0;
        headView.BTLeft = 0;
    }

    if ([self.stickyDataSource respondsToSelector:@selector(BTStickySegmentView)]) {
        UIView * segmentView = [self.stickyDataSource BTStickySegmentView];
        self.segmentViewHeight = segmentView.BTHeight;
        [self.allViews addObject:segmentView];
        [self addSubview:segmentView];
        segmentView.BTTop = self.headViewHeight;
        segmentView.BTLeft = 0;
    }

    if ([self.stickyDataSource respondsToSelector:@selector(BTStickyPageView)]) {
        self.pageView = [self.stickyDataSource BTStickyPageView];
        [self.allViews addObject:self.pageView];
        [self addSubview:self.pageView];
        self.pageView.BTLeft = 0;
        self.pageView.BTTop = self.headViewHeight + self.segmentViewHeight;
    }
    CGSize size = CGSizeMake(self.BTWidth, self.pageView.BTBottom);
    [self setContentSize:size];
}


#pragma mark 手势回调
//返回YES则表明两个scrollView可以一起滑动
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"%f",self.allViews[1].BTTop);
    NSLog(@"%f",scrollView.contentOffset.y);
    if (self.contentOffset.y < self.segmentViewHeight) {
        
    }
}

@end
