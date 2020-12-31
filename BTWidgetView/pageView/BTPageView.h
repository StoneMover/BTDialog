//
//  BTPageView.h
//  live
//
//  Created by stonemover on 2019/7/29.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTPageHeadLabelView.h"

@class BTPageView;

@protocol BTPageViewDataSource <NSObject>

@required

- (NSInteger)pageNumOfView:(BTPageView*)pageView;

- (UIView*)pageView:(BTPageView*)pageView contentViewForIndex:(NSInteger)index;

//为空则不显示headView
- (BTPageHeadView*)pageViewHeadView:(BTPageView*)pageView;


@optional
//内容的大小
- (CGRect)pageViewContentFrame:(BTPageView*)pageView;

//头部的坐标位置，如果BTPageHeadView为空可不实现
- (CGPoint)pageViewHeadOrigin:(BTPageView*)pageView;

@end


@protocol BTPageViewDelegate <NSObject>

@optional

- (void)pageView:(BTPageView*)pageView didShow:(NSInteger)index;

- (void)pageView:(BTPageView*)pageView didDismiss:(NSInteger)index;

//- (void)pageView:(BTPageView*)pageView willShow:(NSInteger)index;
//
//- (void)pageView:(BTPageView*)pageView willDismiss:(NSInteger)index;

//滑动百分比回调
- (void)pageViewScroll:(BTPageView*)pageView percent:(CGFloat)percent;

@end




@interface BTPageView : UIView

@property (nonatomic, weak) id<BTPageViewDataSource>  dataSource;

@property (nonatomic, weak) id<BTPageViewDelegate> delegate;

//初始化选中的page
@property (nonatomic, assign) NSInteger initSelectIndex;

//是否需要自动加载当前页面的上一页和下一页，默认为YES
@property (nonatomic, assign) BOOL isNeedLoadNextAndLast;

//是否可以滑动切换
@property (nonatomic, assign) BOOL isCanScroll;

//外部自由摆放位置的head
@property (nonatomic, strong) BTPageHeadView * headViewOut;


- (void)reloadData;

//滑动到某一个下标
- (void)selectIndex:(NSInteger)index animated:(BOOL)animated;

//移除某一个view下次会重新加载
- (void)removeChildView:(NSInteger)index;

//获取某一个view
- (UIView*)viewForChild:(NSInteger)index;

@end



@interface BTPageViewModel : NSObject

- (instancetype)init:(UIView*)view index:(NSInteger)index;

@property (nonatomic, strong) UIView * childView;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) UIViewController * vc;

@end


