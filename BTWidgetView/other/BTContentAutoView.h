//
//  BTContentAutoView.h
//  word
//
//  Created by stonemover on 2018/1/10.
//  Copyright © 2018年 stonemover. All rights reserved.
//  类似搜索历史记录界面的宽度自适应计算

#import <UIKit/UIKit.h>

@interface BTContentAutoView : UIView

//文字的高度
@property (nonatomic, assign) CGFloat contentH;

//文字的左右间隙
@property (nonatomic, assign) CGFloat contentHSpace;

//文字的上下间距
@property (nonatomic, assign) CGFloat contentVSpace;

//文字颜色
@property (nonatomic, strong) UIColor * textColor;

//文字颜色，选中状态
@property (nonatomic, strong) UIColor * textColorSel;

//文字字体
@property (nonatomic, strong) UIFont * textFont;

//文字背景颜色
@property (nonatomic, strong) UIColor * textBgColor;

//文字背景颜色，选中状态
@property (nonatomic, strong) UIColor * textBgColorSel;

//文字左右内边距
@property (nonatomic, assign) CGFloat paddingLeftRight;

//完成布局后使用的高度回调
@property (nonatomic, copy) void(^block)(CGFloat resultH);

//点击回调
@property (nonatomic, copy) void(^blockClick)(NSInteger index);

//清除数据
- (void)clearData;

//设置数据
- (void)setData:(NSArray*)strs;

//选中某一个按钮
- (void)selectIndex:(NSInteger)index;
- (void)deSelectIndex:(NSInteger)index;

//取消所有的选中状态
- (void)deselectAll;

+ (CGFloat)calculateHeightWithStrs:(NSArray<NSString*>*)strs
                             width:(CGFloat)width
                          contentH:(CGFloat)contentH
                     contentHSpace:(CGFloat)contentHSpace
                     contentVSpace:(CGFloat)contentVSpace
                          textFont:(UIFont*)textFont
                  paddingLeftRight:(CGFloat)paddingLeftRight;

@end
