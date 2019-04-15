//
//  UIView+BTViewTool.h
//  help
//
//  Created by stonemover on 2019/1/7.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (BTViewTool)

- (instancetype)initWithSubView:(UIView*)subView;
- (instancetype)initWithSize:(CGSize)size;


#pragma mark 位置坐标相关方法

- (void)setWidth:(CGFloat)width;
- (CGFloat)width;

- (void)setHeight:(CGFloat)height;
- (CGFloat)height;

- (void)setLeft:(CGFloat)left;
- (CGFloat)left;

- (void)setRight:(CGFloat)right;
- (CGFloat)right;

- (void)setTop:(CGFloat)top;
- (CGFloat)top;

- (void)setBottom:(CGFloat)bottom;
- (CGFloat)bottom;

- (void)setCenterY:(CGFloat)centerY;
- (CGFloat)centerY;

- (void)setCenterX:(CGFloat)centerX;
- (CGFloat)centerX;

#pragma mark 圆角相关处理
@property (nonatomic, assign) CGFloat corner;
    
@property (nonatomic, assign) CGFloat borderWidth;
    
@property (nonatomic, strong) UIColor * borderColor;
    
- (void)setCorner:(CGFloat)corner borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor;
    
- (void)setCornerRadiusBottom:(CGFloat)corner;
- (void)setCornerRadiusTop:(CGFloat)corner;
- (void)setCornerRadiusLeft:(CGFloat)corner;
- (void)setCornerRadiusRight:(CGFloat)corner;
    


#pragma mark 其它
- (UIViewController*)viewController;
- (void)removeChild:(UIView*)childView;
- (void)removeAllChildView;
- (void)setDefaultShade;
- (void)setShade:(CGFloat)opacity radius:(CGFloat)radius;
- (void)setShade:(CGFloat)opacity color:(UIColor*)color radius:(CGFloat)radius offset:(CGSize)size;
+ (instancetype)loadInstanceFromNib;
@end

NS_ASSUME_NONNULL_END
