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
- (instancetype)initWithEqualSize:(CGFloat)size;


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

- (CGSize)size;
- (CGPoint)origin;

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
//获取当前的VC
- (UIViewController*)viewController;

//移除子view
- (void)removeChild:(UIView*)childView;

//移除所有子view
- (void)removeAllChildView;

//设置默认的阴影效果
- (void)setDefaultShade;

//设置阴影效果
- (void)setShade:(CGFloat)opacity radius:(CGFloat)radius;
- (void)setShade:(CGFloat)opacity color:(UIColor*)color radius:(CGFloat)radius offset:(CGSize)size;

//从xib中加载对象
+ (instancetype)loadInstanceFromNib;

//添加view
- (void)addSubViewArray:(NSArray<UIView*>*)subviews;

//生成当前view的图片
- (UIImage*)selfImg;

@end

NS_ASSUME_NONNULL_END
