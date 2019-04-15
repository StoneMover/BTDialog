//
//  SMListDialogView.h
//  Base
//
//  Created by whbt_mac on 16/1/5.
//  Copyright © 2016年 StoneMover. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+BTViewTool.h"


typedef NS_ENUM(NSInteger,BTDialogAnimStyle) {
    BTDialogAnimStyleStyleDefault=0,//类似系统对话框动画
    BTDialogAnimStyleAndroid//类似android系统对话框样式
};


typedef NS_ENUM(NSInteger,BTDialogLocation) {
    BTDialogLocationTop=0,//位置,顶部
    BTDialogLocationCenter,//中部
    BTDialogLocationBottom//底部
};


typedef void (^BTDialogDissmisFinishBlock)(void);


@interface BTDialogView : UIView

//圆角的数值,不需要则为0即可
@property (nonatomic, assign) CGFloat cornerNum;

//点击空白区域不消失
@property (nonatomic,assign) BOOL clickEmptyAreaDismiss;

//当view显示在中部的时候的偏移量
@property (nonatomic, assign) CGFloat centerOffset;

//dialog消失完成后的block回调
@property (nonatomic, copy) BTDialogDissmisFinishBlock blockDismiss;

//初始化
-(instancetype)init:(UIView*)showView withLocation:(BTDialogLocation)location;

-(instancetype)init:(UIView*)showView;

//显示弹框,当初始化的location不为center的时候,动画参数无用,为滑动出现
- (void)show:(UIView*)view;

- (void)show:(UIView*)view withAnimStyle:(BTDialogAnimStyle)style;

//消失
- (void)dismiss;



@end
