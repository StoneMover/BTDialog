//
//  BTProgressView.h
//  BTWidgetViewExample
//
//  Created by apple on 2020/4/28.
//  Copyright © 2020 stone. All rights reserved.
//  进度条控件

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,BTProgressStyle) {
    BTProgressStyleLineHoz = 0,
    BTProgressStyleLineVer,
    BTProgressStyleCircleFull,
    BTProgressStyleCircleBorder
};

@protocol BTProgressDelegate <NSObject>

//进度值改变，BTProgressStyleLineHoz,BTProgressStyleLineVer下有效
- (void)BTProgressSlideChange:(CGFloat)percent;

@end

@interface BTProgressView : UIView

//0:横向；1:竖向；2:圆形填充铺满；3：圆形填充边缘
@property (nonatomic, assign) IBInspectable NSInteger type;

//百分比 0~1
@property (nonatomic, assign) IBInspectable CGFloat percent;

//进度条的颜色
@property (nonatomic, strong) IBInspectable UIColor * progressColor;

//进度条背景颜色
@property (nonatomic, strong) IBInspectable UIColor * progressBgColor;

//进度条的圆角
@property (nonatomic, assign) IBInspectable CGFloat progressCorner;

//进度条的宽度，在BTProgressStyleCircleBorder样式下有效
@property (nonatomic, assign) IBInspectable CGFloat progressWidth;


//进度条大小，在BTProgressStyleLineHoz、BTProgressStyleLineVer有效，当进度条的宽度或者高度不等于view本身的宽度或者高度，设置该值
@property (nonatomic, assign) IBInspectable CGFloat progressSize;

//是否显示文字进度，在BTProgressStyleCircleBorder样式下有效
@property (nonatomic, assign) IBInspectable BOOL isShowProgressLabel;

//文字进度
@property (nonatomic, strong,readonly) UILabel * progressLabel;

//是否可以滑动改变进度,BTProgressStyleLineHoz,BTProgressStyleLineVer下有效
@property (nonatomic, assign) IBInspectable BOOL isCanSlide;

//是否可以单击修改进度值,BTProgressStyleLineHoz,BTProgressStyleLineVer下有效
@property (nonatomic, assign) IBInspectable BOOL isCanClickChangePercent;

//滑动的指示器图片，可自行设置image以及圆角样式，纯色不要设置背景，会根据image的值来判断是否显示,BTProgressStyleLineHoz,BTProgressStyleLineVer下有效
@property (nonatomic, strong, readonly) UIImageView * slideImgView;

@property (nonatomic, weak) id<BTProgressDelegate> delegate;

//是否正在触摸
@property (nonatomic, assign) BOOL isTouch;

@end

NS_ASSUME_NONNULL_END
