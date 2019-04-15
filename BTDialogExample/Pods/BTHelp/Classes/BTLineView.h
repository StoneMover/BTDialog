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

IB_DESIGNABLE

@interface BTLineView : UIView

@property(nonatomic,assign) IBInspectable CGFloat lineWidth;//线的粗细,默认0.2,没有特殊要求不需要设置

@property(nonatomic,strong) IBInspectable UIColor * color;//线的颜色

@property(nonatomic,assign) IBInspectable NSInteger oriention;//方向,默认水平

@property(nonatomic,assign) IBInspectable NSInteger aligntMent;//方位,垂直情况默认是居左,水平情况默认是居上

@end
