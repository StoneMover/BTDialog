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

+ (UIColor*)bt_R:(CGFloat)R G:(CGFloat)G B:(CGFloat)B;

+ (UIColor*)bt_RGBSame:(CGFloat)value;

+ (UIColor*)bt_R:(CGFloat)R G:(CGFloat)G B:(CGFloat)B A:(CGFloat)A;

+ (UIColor*)bt_RGBASame:(CGFloat)value A:(CGFloat)A;

+ (UIColor*)bt_RANDOM_COLOR;

+ (UIColor *)bt_colorWithHexString: (NSString *)color;

+ (UIColor*)bt_51Color;

+ (UIColor*)bt_235Color;

+ (UIColor*)bt_83Color;

@end

NS_ASSUME_NONNULL_END
