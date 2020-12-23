//
//  SMBtnAutoLayout.h
//  Base
//  用来控制view不被键盘遮挡,该界面必须无导航器
//  Created by whbt_mac on 15/11/6.
//  Copyright © 2015年 StoneMover. All rights reserved.
//  初始化之前保证移动的view坐标确定，在vc的viewDidload中view的大小和位置不一定确定，需要在viewDidLayoutSubview中初始化
//  目前的一种情况是在导航栏透明并且有safeArea的情况下少44的移动距离，直接新增一个方法在该情况下调用

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BTKeyboardDelegate<NSObject>

@optional

- (void)keyboardWillShow:(CGFloat)keyboardH;

- (void)keyboardWillHide;

- (void)keyboardMove:(CGFloat)moveY;

- (void)keyboardDidHide;

@end

@interface BTKeyboardHelp : NSObject


/**
 初始化方法
 
 @param showView 不希望被键盘遮挡的view
 @param moveView 当键盘出现而且会遮挡住showView将会被移动的view
 @param margin showView 与键盘的间距
 @return BTKeyboardHelp
 */
- (instancetype)initWithShowView:(UIView*)showView moveView:(UIView*)moveView margin:(NSInteger)margin;

- (instancetype)initWithShowView:(UIView*)showView moveView:(UIView*)moveView;

- (instancetype)initWithShowView:(UIView*)showView;

- (instancetype)initWithShowView:(UIView*)showView margin:(NSInteger)margin;

//键盘是否打开
@property(nonatomic,assign,readonly)BOOL isKeyBoardOpen;

//代理
@property(nonatomic,weak)id<BTKeyboardDelegate> delegate;

//在界面消失的时候设置为YES,出现的时候设置为NO,以免影响其它界面的弹出
@property (nonatomic, assign) BOOL isPause;

//是否不自动移动view的坐标，只返回计算的值,默认YES
@property (nonatomic, assign) BOOL isKeyboardMoveAuto;

//需要抬高的view的约束,这个值不为空的时候则会以改变约束的值为标准执行
@property (nonatomic, strong) NSLayoutConstraint * contraintTop;

//contraintTop约束所属于的view，用于contraintTop执行动画时候的动画效果显示,如果为空则执行displayView和moveView的layoutIfNeeded方法
@property (nonatomic, strong) UIView * contraintTopView;

- (void)replaceDisplayView:(UIView*)displayView withDistance:(NSInteger)distance;

- (void)setNavTransSafeAreaStyle;

@end
