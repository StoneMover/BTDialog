//
//  BTContentAutoView.h
//  word
//
//  Created by stonemover on 2018/1/10.
//  Copyright © 2018年 stonemover. All rights reserved.
//  类似搜索历史记录界面的宽度自适应计算

#import <UIKit/UIKit.h>

typedef void(^BTContentAutoBlock)(CGFloat resultH);

typedef void(^BTContentClickBlock)(NSInteger index);

@interface BTContentAutoView : UIView

//文字的高度
@property (nonatomic, assign) CGFloat contentH;

//文字的左右间隙
@property (nonatomic, assign) CGFloat contentHSpace;

//文字的上下间距
@property (nonatomic, assign) CGFloat contentVSpace;

//文字颜色
@property (nonatomic, assign) UIColor * textColor;

//文字字体
@property (nonatomic, strong) UIFont * textFont;

//文字背景颜色
@property (nonatomic, strong) UIColor * textBgColor;

- (void)clearData;
- (void)setData:(NSArray*)strs;

@property (nonatomic, copy) BTContentAutoBlock block;

@property (nonatomic, copy) BTContentClickBlock blockClick;

@end
