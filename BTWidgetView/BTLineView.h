//
//  BTLineView.h
//  huashi
//
//  Created by stonemover on 16/8/20.
//  Copyright © 2016年 StoneMover. All rights reserved.
//  绘制细线

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BTLineViewOrientation) {
        BTLineViewHoz=0,
        BTLineViewVer
};

typedef NS_ENUM(NSInteger,BTLineViewAlignment) {
    BTLineViewAlignmentTop=0,
    BTLineViewAlignmentCenter,
    BTLineViewAlignmentBottom,
    BTLineViewAlignmentLeft,
    BTLineViewAlignmentRight
};



@interface BTLineView : UIView

//线的粗细,默认0.5,没有特殊要求不需要设置
@property(nonatomic,assign) IBInspectable CGFloat lineWidth;

//线的颜色,默认[UIColor colorWithRed:0.235294 green:0.235294 blue:0.262745 alpha:0.29];
@property(nonatomic,strong) IBInspectable UIColor * color;

//方向,默认水平
@property(nonatomic,assign) IBInspectable NSInteger oriention;

//方位,垂直情况默认是居左,水平情况默认是居上
@property(nonatomic,assign) IBInspectable NSInteger aligntMent;

//虚线的宽度以及虚线两个点之间的间隔，默认为0，不为0则会绘制虚线
@property (nonatomic, assign) IBInspectable NSInteger dashedLineWidthAndMargin;

@end
