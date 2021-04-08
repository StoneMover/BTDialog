//
//  BTStickyPageView.m
//  BTWidgetViewExample
//
//  Created by apple on 2021/4/6.
//  Copyright © 2021 stone. All rights reserved.
//

#import "BTStickyPageView.h"
#import "UIView+BTViewTool.h"

@interface BTStickyPageView()

@property (nonatomic, assign) CGFloat headViewHeight;

@property (nonatomic, assign) CGFloat segmentViewHeight;

@property (nonatomic, strong) BTPageView * pageView;

@property (nonatomic, strong) NSMutableArray<UIView *> * allViews;

@end



@implementation BTStickyPageView

- (void)initSelf{
    self.allViews = [NSMutableArray new];
}

- (void)reloadData{
    for (UIView * view in self.allViews) {
        [view removeFromSuperview];
    }
    self.headViewHeight = 0;
    self.segmentViewHeight = 0;
    self.pageView = nil;
    
    if (!self.delegate) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(BTStickyHeadView)]) {
        UIView * headView = [self.dataSource BTStickyHeadView];
        self.headViewHeight = headView.BTHeight;
        [self.allViews addObject:headView];
        [self addSubview:headView];
        headView.BTTop = 0;
        headView.BTLeft = 0;
    }
    
    if ([self.delegate respondsToSelector:@selector(BTStickySegmentView)]) {
        UIView * segmentView = [self.dataSource BTStickySegmentView];
        self.segmentViewHeight = segmentView.BTHeight;
        [self.allViews addObject:segmentView];
        [self addSubview:segmentView];
        segmentView.BTTop = self.headViewHeight;
        segmentView.BTLeft = 0;
    }
    
    if ([self.delegate respondsToSelector:@selector(BTStickyPageView)]) {
        self.pageView = [self.dataSource BTStickyPageView];
        [self.allViews addObject:self.pageView];
        [self addSubview:self.pageView];
        self.pageView.BTLeft = 0;
        self.pageView.BTTop = self.headViewHeight + self.segmentViewHeight;
    }
    
    [self setContentSize:CGSizeMake(self.BTWidth, self.pageView.BTBottom)];
}



@end
