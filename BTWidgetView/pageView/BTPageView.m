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
    self.isCanScroll = YES;
}

- (void)initScrollView{
    self.scrollView=[[UIScrollView alloc] init];
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.scrollView.bounces=NO;
    self.scrollView.showsHorizontalScrollIndicator=NO;
    self.scrollView.showsVerticalScrollIndicator=NO;
    self.scrollView.delegate=self;
    self.scrollView.pagingEnabled=YES;
    [self addSubview:self.scrollView];
    
}

- (void)layoutSubviews{
    //这里是不是要循环下子view让其重新layout一遍？
    if (self.headView) {
        self.scrollView.frame=CGRectMake(0, self.headView.BTBottom, self.BTWidth, self.BTHeight-self.headView.BTHeight);
        [self.scrollView setContentSize:CGSizeMake(self.scrollView.contentSize.width, self.BTHeight-self.headView.BTHeight)];
    }else{
        self.scrollView.frame=self.bounds;
        self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, self.scrollView.BTHeight);
    }
    
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentSize.width-scrollView.BTWidth!=0) {
        CGFloat percent = (scrollView.contentOffset.x)/(scrollView.contentSize.width-scrollView.BTWidth);
        if (self.headView) {
            [self.headView scrollViewIndicator:percent];
        }
        
        if (self.headViewOut) {
            [self.headViewOut scrollViewIndicator:percent];
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(pageViewScroll:percent:)]) {
            [self.delegate pageViewScroll:self percent:percent];
        }
    }
    
    if (self.headView) {
        [self.headView scrollViewItemPercent:(scrollView.contentOffset.x - self.nowIndex * self.BTWidth)/self.BTWidth];
    }
    
    if (self.headViewOut) {
        [self.headViewOut scrollViewItemPercent:(scrollView.contentOffset.x - self.nowIndex * self.BTWidth)/self.BTWidth];
    }
    
    //这里在横竖屏切换的时候可能会出现数组越界的情况
    if (self.scrollView.contentOffset.x-self.lastContentOffsetX>0) {
        //向右左滑动，加载下一个
        if (self.scrollView.scrollEnabled && ![self isIndexOut:self.nowIndex + 1]) {
            //不是点击滑动的情况
            [self autoLoadSubView:self.nowIndex + 1];
        }
//        NSLog(@"hhhh:%ld",self.nowIndex);
        
    }else if (self.scrollView.contentOffset.x-self.lastContentOffsetX<0){
        //向右边滑动，加载上一个
        if (self.scrollView.scrollEnabled && ![self isIndexOut:self.nowIndex - 1]) {
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
    self.scrollView.scrollEnabled = self.isCanScroll;
    
//    NSLog(@"scrollViewDidEndScrollingAnimation");
}

- (void)didSelectIndex{
    self.lastContentOffsetX=self.scrollView.contentOffset.x;
    NSInteger index = self.scrollView.contentOffset.x/self.scrollView.BTWidth;
    if (self.nowIndex == index || [self isIndexOut:index]) {
        return;
    }
    
    //防止在连续滑动的情况下index没有改变导致无法加载的问题
    [self autoLoadSubView:index];
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(pageView:didDismiss:)]) {
        [self.delegate pageView:self didDismiss:self.nowIndex];
    }
    
    self.nowIndex = index;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(pageView:didShow:)]) {
        [self.delegate pageView:self didShow:self.nowIndex];
    }
    
    if (self.headView) {
        [self.headView selectIndex:self.nowIndex];
    }
    
    if (self.headViewOut) {
        [self.headViewOut selectIndex:self.nowIndex];
    }
}

#pragma mark 相关方法
- (void)reloadData{
    if (self.BTWidth==0||self.BTHeight==0) {
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
    if (total == 0) {
        return;
    }
    self.childView=[[NSMutableArray alloc] init];
    for (int i=0; i<total; i++) {
        BTPageViewModel * model =[[BTPageViewModel alloc] init:nil index:i];
        [self.childView addObject:model];
    }
    
    _headView =[self.dataSource pageViewHeadView:self];
    [self.headView setValue:self forKey:@"pageView"];
    [self.headView reloadData];
    [self.headViewOut setValue:self forKey:@"pageView"];
    [self.headViewOut reloadData];
    if (self.headView) {
        [self addSubview:self.headView];
        if (self.dataSource&&[self.dataSource respondsToSelector:@selector(pageViewHeadOrigin:)]) {
            CGPoint point =[self.dataSource pageViewHeadOrigin:self];
            self.headView.BTLeft=point.x;
            self.headView.BTTop=point.y;
        }else{
            self.headView.BTLeft=0;
            self.headView.BTTop=0;
        }
        if (self.dataSource&&[self.dataSource respondsToSelector:@selector(pageViewContentFrame:)]) {
            self.scrollView.frame=[self.dataSource pageViewContentFrame:self];
        }else{
            self.scrollView.frame=CGRectMake(0, self.headView.BTBottom, self.BTWidth, self.BTHeight-self.headView.BTHeight);
        }
        
    }else{
        if (self.dataSource&&[self.dataSource respondsToSelector:@selector(pageViewContentFrame:)]) {
            self.scrollView.frame=[self.dataSource pageViewContentFrame:self];
        }else{
            self.scrollView.frame=self.bounds;
        }
    }
    
    if (self.headView) {
        [self.scrollView setContentSize:CGSizeMake(self.BTWidth*total, self.BTHeight-self.headView.BTHeight)];
    }else{
        [self.scrollView setContentSize:CGSizeMake(self.BTWidth*total, self.BTHeight)];
    }
    
    self.lastContentOffsetX=self.BTWidth*self.initSelectIndex;
    self.nowIndex=self.initSelectIndex;
    [self selectIndex:self.initSelectIndex animated:NO];
    if (self.initSelectIndex != 0 && self.headView) {
        [self.headView selectIndex:self.nowIndex];
    }
    
    if (self.initSelectIndex != 0 && self.headViewOut) {
        [self.headViewOut selectIndex:self.nowIndex];
    }
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(pageView:didShow:)]) {
        [self.delegate pageView:self didShow:self.nowIndex];
    }
}

//是否已经加装过view
- (BOOL)isHasLoadView:(NSInteger)index{
    if ([self isIndexOut:index]) {
        return NO;
    }
    BTPageViewModel * model =self.childView[index];
    if (model.childView) {
        return YES;
    }
    return NO;
}

//获取当前下标的view,不会判断是否已经加装过
- (UIView*)getChildView:(NSInteger)index{
    if (self.dataSource&&[self.dataSource respondsToSelector:@selector(pageView:contentViewForIndex:)]) {
//        NSLog(@"获取%ld的view",index);
        UIView * view =[self.dataSource pageView:self contentViewForIndex:index];
        return view;
    }
    
    return nil;
}

//自动加载当前的view，如果没有加载过就加载，加载过直接跳出
- (void)autoLoadSubView:(NSInteger)index{
    //加载当前下标的view
    
    if (![self isHasLoadView:index]&&![self isIndexOut:index]) {
        UIView * view=[self getChildView:index];
        view.frame=CGRectMake(index*self.scrollView.BTWidth, 0, self.scrollView.BTWidth, self.scrollView.BTHeight);
        self.childView[index].childView=view;
        [self.scrollView addSubview:view];
    }
    
    if (!self.isNeedLoadNextAndLast) {
        return;
    }
    
    if (index!=0 && ![self isHasLoadView:index-1] && ![self isIndexOut:index -1]) {
        UIView * view=[self getChildView:index-1];
        view.frame=CGRectMake((index-1)*self.scrollView.BTWidth, 0, self.scrollView.BTWidth, self.scrollView.BTHeight);
        self.childView[index-1].childView=view;
        [self.scrollView addSubview:view];
    }
    
    if (index!=self.childView.count-1&&![self isHasLoadView:index+1]&& ![self isIndexOut:index +1]) {
        UIView * view=[self getChildView:index+1];
        view.frame=CGRectMake((index+1)*self.scrollView.BTWidth, 0, self.scrollView.BTWidth, self.scrollView.BTHeight);
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
    [self.scrollView bt_removeAllChildView];
}


- (void)selectIndex:(NSInteger)index animated:(BOOL)animated{
    //如果index相同不会触发滚动结束回调，这里不能设置为NO
    if (animated&&self.nowIndex!=index) {
        self.scrollView.scrollEnabled=NO;
    }
    [self autoLoadSubView:index];
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.BTWidth*index, 0) animated:animated];
    //没有动画滑动不会触发scrollView的滑动代理，无法更新index
    if (!animated) {
        self.nowIndex = index;
    }
}


- (void)removeChildView:(NSInteger)index{
    [self.childView[index].childView removeFromSuperview];
    self.childView[index].childView=nil;
}


- (UIView*)viewForChild:(NSInteger)index{
    return self.childView[index].childView;
}

- (void)setIsCanScroll:(BOOL)isCanScroll{
    _isCanScroll = isCanScroll;
    self.scrollView.scrollEnabled=isCanScroll;
}

- (BOOL)isIndexOut:(NSInteger)index{
    if (index < 0 && index > self.childView.count - 1) {
//        NSLog(@"数组越界：%ld",index);
        return YES;
    }
    
    return NO;
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
