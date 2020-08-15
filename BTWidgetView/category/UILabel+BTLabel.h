//
//  UILabel+BTLabel.h
//  BTWidgetViewExample
//
//  Created by apple on 2020/6/16.
//  Copyright © 2020 stone. All rights reserved.
//  复杂的富文本使用YYLabel或者NudeIn实现

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (BTLabel)

- (NSMutableAttributedString*)bt_AttributedString;

//设置文字字体
- (void)bt_AttributedFont:(UIFont*)font str:(NSString*)str;

- (void)bt_AttributedFont:(UIFont*)font range:(NSRange)range;

//设置文字颜色
- (void)bt_AttributedColor:(UIColor*)color str:(NSString*)str;

- (void)bt_AttributedColor:(UIColor*)color range:(NSRange)range;

//设置文字背景颜色
- (void)bt_AttributedBgColor:(UIColor*)color range:(NSRange)range;

- (void)bt_AttributedBgColor:(UIColor*)color str:(NSString*)str;

//设置字体文字间距
- (void)bt_AttributedKern:(NSNumber*)kern range:(NSRange)range;

- (void)bt_AttributedKern:(NSNumber*)kern str:(NSString*)str;


//设置删除线
- (void)bt_AttributedDelLine:(UIColor*)color range:(NSRange)range;

- (void)bt_AttributedDelLine:(UIColor*)color str:(NSString*)str;

//设置下划线
- (void)bt_AttributedUnderLine:(UIColor*)color range:(NSRange)range;

- (void)bt_AttributedUnderLine:(UIColor*)color str:(NSString*)str;

//设置超链接
- (void)bt_AttributedLink:(NSURL*)url range:(NSRange)range;

- (void)bt_AttributedLink:(NSURL*)url str:(NSString*)str;

//设置两端对齐,可能与下划线有冲突
- (void)bt_AttributedAlignStartEnd;

//设置所有文字的行间距
- (void)bt_setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;

//计算高度
- (CGFloat)bt_calculateLabelHeight;

//计算宽度
- (CGFloat)bt_calculateLabelWidth;

//字体和文字颜色初始化
- (instancetype)initBTLabelWithColor:(UIColor*)color font:(UIFont*)font;

@end

NS_ASSUME_NONNULL_END
