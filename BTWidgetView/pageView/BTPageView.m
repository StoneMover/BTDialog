//
//  BTPageView.m
//  live
//
//  Created by stonemover on 2019/7/29.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "BTPageView.h"
#import "UIView+BTViewTool.h"


@interface BTPageView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, assign) BOOL isNeedLayoutReload;

//上次滑动
@property (nonatomic, assign) CGFloat lastContentOffsetX;

//当前下标
@property (nonatomic, assign) NSInteger nowIndex;

//子view的数组
@property (nonatomic, strong) NSMutableArray<BTPageViewModel*> * childView;

//page的头部view
@property (nonatomic, strong) BTPageHeadView * headView;


@end


@implementation BTPageView

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    [self initSelf];
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self initSelf];
}

- (void)initSelf{
    _childView=[NSMutableArray new];
    [self initScrollView];
    self.isNeedLoadNextAndLast=YES;
    self.nowIndex=-1;
}

- (void)initScrollView{
    self.scrollView=[[UIScrollView alloc] init];
    self.scrollView.bounces=NO;
    self.scrollView.showsHorizontalScrollIndicator=NO;
    self.scrollView.showsVerticalScrollIndicator=NO;
    self.scrollView.delegate=self;
    self.scrollView.pagingEnabled=YES;
    [self addSubview:self.scrollView];
    
}

- (void)layoutSubviews{
    if (self.headView) {
        self.scrollView.frame=CGRectMake(0, self.headView.bottom, self.width, self.height-self.headView.height);
    }else{
        self.scrollView.frame=self.bounds;
    }
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.headView) {
        [self.headView scrollViewIndicator:(scrollView.contentOffset.x)/(scrollView.contentSize.width-scrollView.width)];
    }
    
    if (self.scrollView.contentOffset.x-self.lastContentOffsetX>0) {
        //向右左滑动，加载下一个
        if (self.scrollView.scrollEnabled) {
            //不是点击滑动的情况
            [self autoLoadSubView:self.nowIndex+1];
        }
        
    }else if (self.scrollView.contentOffset.x-self.lastContentOffsetX<0){
        //向右边滑动，加载上一个
        if (self.scrollView.scrollEnabled) {
            //不是点击滑动的情况
            [self autoLoadSubView:self.nowIndex-1];
        }
        
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        [self didSelectIndex];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self didSelectIndex];
}

// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self didSelectIndex];
    self.scrollView.scrollEnabled=YES;
//    NSLog(@"scrollViewDidEndScrollingAnimation");
}

- (void)didSelectIndex{
    self.lastContentOffsetX=self.scrollView.contentOffset.x;
    NSInteger index = self.scrollView.contentOffset.x/self.scrollView.width;
    if (self.nowIndex==index) {
        return;
    }
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(pageView:didDismiss:)]) {
        [self.delegate pageView:self didDismiss:self.nowIndex];
    }
    
    self.nowIndex = index;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(pageView:didShow:)]) {
        [self.delegate pageView:self didShow:self.nowIndex];
    }
    
}

#pragma mark 相关方法
- (void)reloadData{
    if (self.width==0||self.height==0) {
        self.isNeedLayoutReload=YES;
        return;
    }
    
    if (!self.dataSource) {
        return;
    }
    
    if (![self.dataSource respondsToSelector:@selector(pageNumOfView:)]) {
        return;
    }
    
    if (![self.dataSource respondsToSelector:@selector(pageView:contentViewForIndex:)]) {
        return;
    }
    
    if (![self.dataSource respondsToSelector:@selector(pageViewHeadView:)]) {
        return;
    }
    
    [self clearData];
    
    NSInteger total=[self.dataSource pageNumOfView:self];
    self.childView=[[NSMutableArray alloc] init];
    for (int i=0; i<total; i++) {
        BTPageViewModel * model =[[BTPageViewModel alloc] init:nil index:i];
        [self.childView addObject:model];
    }
    
    _headView =[self.dataSource pageViewHeadView:self];
    [self.headView setValue:self forKey:@"pageView"];
    if (self.headView) {
        [self.headView reloadData];
        [self addSubview:self.headView];
        if (self.dataSource&&[self.dataSource respondsToSelector:@selector(pageViewHeadOrigin:)]) {
            CGPoint point =[self.dataSource pageViewHeadOrigin:self];
            self.headView.left=point.x;
            self.headView.top=point.y;
        }else{
            self.headView.left=0;
            self.headView.top=0;
        }
        if (self.dataSource&&[self.dataSource respondsToSelector:@selector(pageViewContentFrame:)]) {
            self.scrollView.frame=[self.dataSource pageViewContentFrame:self];
        }else{
            self.scrollView.frame=CGRectMake(0, self.headView.bottom, self.width, self.height-self.headView.height);
        }
        
    }else{
        if (self.dataSource&&[self.dataSource respondsToSelector:@selector(pageViewContentFrame:)]) {
            self.scrollView.frame=[self.dataSource pageViewContentFrame:self];
        }else{
            self.scrollView.frame=self.bounds;
        }
    }
    
    if (self.headView) {
        [self.scrollView setContentSize:CGSizeMake(self.width*total, self.height-self.headView.height)];
    }else{
        [self.scrollView setContentSize:CGSizeMake(self.width*total, self.height)];
    }
    
    self.lastContentOffsetX=self.width*self.initSelectIndex;
    self.nowIndex=self.initSelectIndex;
    [self selectIndex:self.initSelectIndex animated:NO];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(pageView:didShow:)]) {
        [self.delegate pageView:self didShow:self.nowIndex];
    }
}

//是否已经加装过view
- (BOOL)isHasLoadView:(NSInteger)index{
    BTPageViewModel * model =self.childView[index];
    if (model.childView) {
        return YES;
    }
    return NO;
}

//获取当前下标的view,不会判断是否已经加装过
- (UIView*)getChildView:(NSInteger)index{
    if (self.dataSource&&[self.dataSource respondsToSelector:@selector(pageView:contentViewForIndex:)]) {
        NSLog(@"获取%ld的view",index);
        UIView * view =[self.dataSource pageView:self contentViewForIndex:index];
        return view;
    }
    
    return nil;
}

//自动加载当前的view，如果没有加载过就加载，加载过直接跳出
- (void)autoLoadSubView:(NSInteger)index{
    //加载当前下标的view
    if (![self isHasLoadView:index]) {
        UIView * view=[self getChildView:index];
        view.frame=CGRectMake(index*self.scrollView.width, 0, self.scrollView.width, self.scrollView.height);
        self.childView[index].childView=view;
        [self.scrollView addSubview:view];
    }
    
    if (!self.isNeedLoadNextAndLast) {
        return;
    }
    
    if (index!=0&&![self isHasLoadView:index-1]) {
        UIView * view=[self getChildView:index-1];
        view.frame=CGRectMake((index-1)*self.scrollView.width, 0, self.scrollView.width, self.scrollView.height);
        self.childView[index-1].childView=view;
        [self.scrollView addSubview:view];
    }
    
    if (index!=self.childView.count-1&&![self isHasLoadView:index+1]) {
        UIView * view=[self getChildView:index+1];
        view.frame=CGRectMake((index+1)*self.scrollView.width, 0, self.scrollView.width, self.scrollView.height);
        self.childView[index+1].childView=view;
        [self.scrollView addSubview:view];
    }
    
}

//清除所有数据
- (void)clearData{
    [self.headView removeFromSuperview];
    _headView=nil;
    [self.childView removeAllObjects];
    self.childView=nil;
    [self.scrollView removeAllChildView];
}


- (void)selectIndex:(NSInteger)index animated:(BOOL)animated{
    if (animated) {
        self.scrollView.scrollEnabled=NO;
    }
    [self autoLoadSubView:index];
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.width*index, 0) animated:animated];
}


- (void)removeChildView:(NSInteger)index{
    [self.childView[index].childView removeFromSuperview];
    self.childView[index].childView=nil;
}


- (UIView*)viewForChild:(NSInteger)index{
    return self.childView[index].childView;
}

- (void)setIsCanScroll:(BOOL)isCanScroll{
    self.scrollView.scrollEnabled=isCanScroll;
}

@end


@implementation BTPageViewModel : NSObject

- (instancetype)init:(UIView*)view index:(NSInteger)index{
    self=[super init];
    self.childView=view;
    _index=index;
    return self;
}

@end
