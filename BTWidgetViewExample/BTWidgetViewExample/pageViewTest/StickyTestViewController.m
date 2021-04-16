//
//  StickyTestViewController.m
//  BTWidgetViewExample
//
//  Created by apple on 2021/4/12.
//  Copyright © 2021 stone. All rights reserved.
//

#import "StickyTestViewController.h"
#import "BTStickyPageView.h"
#import <BTHelp/BTUtils.h>
#import "BTPageView.h"
#import "BTPageHeadLabelView.h"
#import "UIView+BTViewTool.h"
#import "StickyTestView.h"

@interface StickyTestViewController ()<BTStickyPageViewDataSourse,BTPageViewDelegate,BTPageViewDataSource>

@property (nonatomic, strong) BTStickyPageView * stickyView;

@property (nonatomic, strong) BTPageHeadLabelView * segmentView;

@property (nonatomic, strong) BTPageView * pageView;

@property (nonatomic, strong) UIView * headView;

@end

@implementation StickyTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.segmentView = [[BTPageHeadLabelView alloc] initWithFrame:CGRectMake(0, 0, BTUtils.SCREEN_W, 45) titles:@[@"推荐",@"热门",@"精选"] style:BTPageHeadViewStyleAverage];
    
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BTUtils.SCREEN_W, 140)];
    self.headView.backgroundColor = UIColor.redColor;
    
    self.pageView = [[BTPageView alloc] initWithFrame:CGRectMake(0, 0, BTUtils.SCREEN_W, BTUtils.SCREEN_H - BTUtils.NAV_HEIGHT - self.segmentView.BTHeight)];
    self.pageView.delegate = self;
    self.pageView.dataSource = self;
    self.pageView.headViewOut = self.segmentView;
    
    self.stickyView = [[BTStickyPageView alloc] initWithFrame:CGRectMake(0, 0, BTUtils.SCREEN_W, BTUtils.SCREEN_H - BTUtils.NAV_HEIGHT)];
    self.stickyView.stickyDataSource = self;
    [self.view addSubview:self.stickyView];
    
    [self.stickyView reloadStickyData];
    [self.pageView reloadData];
}

#pragma mark BTStickyPageViewDataSourse


- (nonnull UIView *)BTStickyHeadView {
    return self.headView;
}

- (nonnull BTPageView *)BTStickyPageView {
    return self.pageView;
}

- (nonnull UIView *)BTStickySegmentView {
    return self.segmentView;
}

#pragma mark BTPageViewDelegate,BTPageViewDataSource
- (void)pageView:(BTPageView*)pageView didShow:(NSInteger)index{
    
}

- (void)pageView:(BTPageView*)pageView didDismiss:(NSInteger)index{
    
}

//滑动百分比回调
- (void)pageViewScroll:(BTPageView*)pageView percent:(CGFloat)percent{
    
}


- (NSInteger)pageNumOfView:(BTPageView*)pageView{
    return 3;
}

- (UIView*)pageView:(BTPageView*)pageView contentViewForIndex:(NSInteger)index{
    StickyTestView * view = [[StickyTestView alloc] initWithFrame:pageView.bounds];
    view.backgroundColor = UIColor.blueColor;
    if (index == 1) {
        view.backgroundColor = UIColor.grayColor;
    }
    
    if (index == 2) {
        view.backgroundColor = UIColor.yellowColor;
    }
    view.type = index;
    return view;
}

//为空则不显示headView
- (BTPageHeadView*)pageViewHeadView:(BTPageView*)pageView{
    return nil;
}

@end
