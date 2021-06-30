//
//  UIColor+BTColor.h
//  BTHelpExample
//
//  Created by apple on 2020/6/28.
//  Copyright © 2020 stonemover. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (BTColor)


/// 传入对应的RGB值获取颜色对象
/// @param R 值，0~255
/// @param G 值，0~255
/// @param B 值，0~255
+ (UIColor*)bt_R:(CGFloat)R G:(CGFloat)G B:(CGFloat)B;


/// 获取相同RGB值的颜色
/// @param value RGB值，0~255
+ (UIColor*)bt_RGBSame:(CGFloat)value;


/// 传入对应的RGBA值获取颜色对象
/// @param R 值，0~255
/// @param G 值，0~255
/// @param B 值，0~255
/// @param A 值，0~255
+ (UIColor*)bt_R:(CGFloat)R G:(CGFloat)G B:(CGFloat)B A:(CGFloat)A;


/// 获取相同RGB值的颜色
/// @param value RGB值，0~255
/// @param A 值，0~1
+ (UIColor*)bt_RGBASame:(CGFloat)value A:(CGFloat)A;


/// 随机颜色
+ (UIColor*)bt_RANDOM_COLOR;


/// 根据16进制获取颜色
/// @param color 例如#FFFFFFF
+ (UIColor *)bt_colorWithHexString: (NSString *)color;


+ (UIColor*)bt_34Color;

+ (UIColor*)bt_51Color;

+ (UIColor*)bt_83Color;

+ (UIColor*)bt_96Color;

+ (UIColor*)bt_136Color;

+ (UIColor*)bt_153Color;

+ (UIColor*)bt_204Color;

+ (UIColor*)bt_229Color;

+ (UIColor*)bt_235Color;

+ (UIColor*)bt_245Color;

+ (UIColor*)bt_248Color;

@end

NS_ASSUME_NONNULL_END
