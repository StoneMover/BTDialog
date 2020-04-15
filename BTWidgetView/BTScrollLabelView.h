//
//  SMScrollLabelView.h
//  Base
//
//  Created by whbt_mac on 15/11/11.
//  Copyright © 2015年 StoneMover. All rights reserved.
//  跑马灯效果

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,BTScrollLabelType) {
    BTScrollLabelTypeRound = 0,
    BTScrollLabelTypeBy
};


@interface BTScrollLabelView : UIView

//要显示的文字
@property (nonatomic, strong) NSString * strData;

//滚动类型
@property (nonatomic, assign) BTScrollLabelType type;

//文字的颜色
@property (nonatomic, strong) UIColor * color;

//文字的字体
@property (nonatomic, strong) UIFont * font;

//两个label之间的间距
@property (nonatomic, assign) CGFloat margin;

//动画的时间
@property (nonatomic, assign) int animTime;

-(void)start;

-(void)stop;

@end
