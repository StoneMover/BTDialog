//
//  UIColor+BTColor.m
//  BTHelpExample
//
//  Created by apple on 2020/6/28.
//  Copyright © 2020 stonemover. All rights reserved.
//

#import "UIColor+BTColor.h"

@implementation UIColor (BTColor)

+ (UIColor*)R:(CGFloat)R G:(CGFloat)G B:(CGFloat)B{
    return [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:1];
}

+ (UIColor*)RGBSame:(CGFloat)value{
    return [UIColor colorWithRed:(value)/255.0 green:(value)/255.0 blue:(value)/255.0 alpha:1];
}

+ (UIColor*)R:(CGFloat)R G:(CGFloat)G B:(CGFloat)B A:(CGFloat)A{
    return [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:A];
}

+ (UIColor*)RGBASame:(CGFloat)value A:(CGFloat)A{
    return [UIColor colorWithRed:(value)/255.0 green:(value)/255.0 blue:(value)/255.0 alpha:A];
}

+ (UIColor*)RANDOM_COLOR{
    return [UIColor R:arc4random_uniform(256) G:arc4random_uniform(256) B:arc4random_uniform(256)];
}


@end
