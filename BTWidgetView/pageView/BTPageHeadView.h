//
//  BTPageHeadView.h
//  live
//
//  Created by stonemover on 2019/7/29.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BTPageHeadViewStyle) {
    BTPageHeadViewStyleDefault=0,//从左到右依次排序，如果超过一屏可以滑动
    BTPageHeadViewStyleAverage//平分宽度，不可滑动
};

@class BTPageHeadView;

@protocol BTPageHeadViewDataSource <NSObject>

@required

- (NSInteger)pageHeadViewNumOfItem:(BTPageHeadView*)headView;

- (UIView*)pageHeadView:(BTPageHeadView*)headView contentViewForIndex:(NSInteger)index;

- (BTPageHeadViewStyle)pageHeadViewStyle:(BTPageHeadView*)headView;

@end


@protocol BTPageHeadViewDelegate <NSObject>

- (void)pageHeadViewItemClick:(NSInteger)index;

@end



@interface BTPageHeadView : UIView

@property (nonatomic, weak) id<BTPageHeadViewDataSource> dataSource;

@property (nonatomic, weak) id<BTPageHeadViewDelegate> delegate;

//左边距
@property (nonatomic, assign) CGFloat leftPadding;

//右边距
@property (nonatomic, assign) CGFloat rightPadding;

//下标指示器，没有为空，使用initViewIndicator初始化
@property (nonatomic, strong) UIView * viewIndicator;

//下标指示器距离底部的间距
@property (nonatomic, assign) CGFloat viewIndicatorBottomPadding;

//每个item之间的间距
@property (nonatomic, assign) CGFloat itemMarin;

//点击切换是否需要滑动动画
@property (nonatomic, assign) BOOL isNeedClickAnim;

- (void)reloadData;

- (void)initViewIndicator:(CGSize)size corner:(CGFloat)corner bgColor:(UIColor*)color;

//滑动下标的百分比
- (void)scrollViewIndicator:(CGFloat)percent;


@end


