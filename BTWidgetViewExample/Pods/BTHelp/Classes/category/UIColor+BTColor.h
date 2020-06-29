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

+ (UIColor*)R:(CGFloat)R G:(CGFloat)G B:(CGFloat)B;

+ (UIColor*)RGBSame:(CGFloat)value;

+ (UIColor*)R:(CGFloat)R G:(CGFloat)G B:(CGFloat)B A:(CGFloat)A;

+ (UIColor*)RGBASame:(CGFloat)value A:(CGFloat)A;

+ (UIColor*)RANDOM_COLOR;

@end

NS_ASSUME_NONNULL_END
