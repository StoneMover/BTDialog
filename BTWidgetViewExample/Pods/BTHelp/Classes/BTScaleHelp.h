//
//  BTScaleHelp.h
//  BTHelpExample
//
//  Created by apple on 2021/1/15.
//  Copyright © 2021 stonemover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BTScaleHelp : NSObject

+ (instancetype)share;

+ (CGFloat)scaleViewSize:(CGFloat)value;
+ (CGFloat)scaleViewSize:(CGFloat)value uiDesignWidth:(CGFloat)uiDesignWidth;

+ (CGFloat)scaleFontSize:(CGFloat)fontSize;
+ (CGFloat)scaleFontSize:(CGFloat)fontSize uiDesignWidth:(CGFloat)uiDesignWidth;

//UI设计图的宽度，默认375
@property (nonatomic, assign) CGFloat uiDesignWidth;

//根据宽度的缩放计算高度
@property (nonatomic, copy) CGFloat (^scaleViewBlock) (CGFloat value) ;

@property (nonatomic, copy) CGFloat (^scaleViewFullBlock) (CGFloat value, CGFloat uiDesignWidth);


//根据宽度的缩放计算字体
@property (nonatomic, copy) CGFloat (^scaleFontSizeBlock) (CGFloat fontSize) ;

@property (nonatomic, copy) CGFloat (^scaleFontSizeFullBlock) (CGFloat fontSize, CGFloat uiDesignWidth);



@end

NS_ASSUME_NONNULL_END
