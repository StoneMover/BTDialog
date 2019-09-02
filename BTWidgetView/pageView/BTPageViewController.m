//
//  BTPageViewController.m
//  BTWidgetViewExample
//
//  Created by zanyu on 2019/8/26.
//  Copyright © 2019 stone. All rights reserved.
//

#import "BTPageViewController.h"

@interface BTPageViewController ()<BTPageViewDelegate,BTPageViewDataSource>

@property (nonatomic, strong) NSMutableArray * childVc;

@property (nonatomic, strong) BTPageView * pageView;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, assign) NSInteger initIndex;

@end

@implementation BTPageViewController

- (instancetype)initWithIndex:(NSInteger)index{
    self=[super init];
    self.initIndex=index;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPageView];
}

- (void)initPageView{
    self.pageView=[[BTPageView alloc] initWithFrame:self.view.bounds];
    self.pageView.delegate=self;
    self.pageView.dataSource=self;
    self.pageView.initSelectIndex=self.initIndex;
    self.pageView.isNeedLoadNextAndLast=self.isNeedLoadNextAndLast;
    self.view=self.pageView;
}

- (void)reloadData{
    self.childVc=[NSMutableArray new];
    if (!self.dataSource||![self.dataSource respondsToSelector:@selector(pageNumOfVc:)]) {
        return;
    }
    self.total=[self.dataSource pageNumOfVc:self];
    for (int i=0; i<self.total; i++) {
        BTPageViewModel * model =[[BTPageViewModel alloc] init];
        model.index=i;
        [self.childVc addObject:model];
    }
    [self.pageView reloadData];
    
}

- (void)selectIndex:(NSInteger)index animated:(BOOL)animated{
    [self.pageView selectIndex:index animated:animated];
}

#pragma mark BTPageViewDataSource
- (NSInteger)pageNumOfView:(BTPageView*)pageView{
    return self.total;
}

- (UIView*)pageView:(BTPageView*)pageView contentViewForIndex:(NSInteger)index{
    BTPageViewModel * model =self.childVc[index];
    if (model.vc) {
        return model.vc.view;
    }
    
    if (self.dataSource&&[self.dataSource respondsToSelector:@selector(pageVc:vcForIndex:)]) {
        model.vc = [self.dataSource pageVc:self vcForIndex:index];
        return model.vc.view;
    }
    
    return nil;
}

- (BTPageHeadView*)pageViewHeadView:(BTPageView*)pageView{
    if (self.dataSource&&[self.dataSource respondsToSelector:@selector(pageVcHeadView:)]) {
        return [self.dataSource pageVcHeadView:self];
    }
    
    return nil;
}


- (CGPoint)pageViewHeadFrame:(BTPageView*)pageView{
    if (self.dataSource&&[self.dataSource respondsToSelector:@selector(pageVcHeadOrigin:)]) {
        return [self.dataSource pageVcHeadOrigin:self];
    }
    
    return CGPointZero;
}

- (CGRect)pageViewContentFrame:(BTPageView*)pageView{
    if (self.dataSource&&[self.dataSource respondsToSelector:@selector(pageVcContentFrame:)]) {
        return [self.dataSource pageVcContentFrame:self];
    }
    
    return CGRectZero;
}


#pragma mark BTPageViewDelegate
- (void)pageView:(BTPageView*)pageView didShow:(NSInteger)index{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(pageVc:didShow:)]) {
        [self.delegate pageVc:self didShow:index];
    }
    BTPageViewModel * model =self.childVc[index];
    [model.vc viewDidAppear:YES];
}

- (void)pageView:(BTPageView*)pageView didDismiss:(NSInteger)index{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(pageVc:didDismiss:)]) {
        [self.delegate pageVc:self didDismiss:index];
    }
    
    BTPageViewModel * model =self.childVc[index];
    [model.vc viewDidDisappear:YES];
}


- (void)setIsCanScroll:(BOOL)isCanScroll{
    self.pageView.isCanScroll=isCanScroll;
}

@end
