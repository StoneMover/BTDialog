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

- (instancetype)initBTViewWithSubView:(UIView*)subView;
- (instancetype)initBTViewWithSize:(CGSize)size;
- (instancetype)initBTViewWithEqualSize:(CGFloat)size;


#pragma mark 位置坐标相关方法

- (void)setBTWidth:(CGFloat)width;
- (CGFloat)BTWidth;

- (void)setBTHeight:(CGFloat)height;
- (CGFloat)BTHeight;

- (void)setBTLeft:(CGFloat)left;
- (CGFloat)BTLeft;

- (void)setBTRight:(CGFloat)right;
- (CGFloat)BTRight;

- (void)setBTTop:(CGFloat)top;
- (CGFloat)BTTop;

- (void)setBTBottom:(CGFloat)bottom;
- (CGFloat)BTBottom;

- (void)setBTCenterY:(CGFloat)centerY;
- (CGFloat)BTCenterY;

- (void)setBTCenterX:(CGFloat)centerX;
- (CGFloat)BTCenterX;

- (void)setBTSize:(CGSize)size;
- (CGSize)BTSize;

- (void)setBTOrigin:(CGPoint)point;
- (CGPoint)BTOrigin;

- (void)setBTCenterParentX;
- (void)setBTCenterParentY;
- (void)setBTCenterParent;

#pragma mark 圆角相关处理
@property (nonatomic, assign) CGFloat BTCorner;
    
@property (nonatomic, assign) CGFloat BTBorderWidth;
    
@property (nonatomic, strong) UIColor * BTBorderColor;
    
- (void)setBTCorner:(CGFloat)corner borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor;
    
- (void)setBTCornerRadiusBottom:(CGFloat)corner;
- (void)setBTCornerRadiusTop:(CGFloat)corner;
- (void)setBTCornerRadiusLeft:(CGFloat)corner;
- (void)setBTCornerRadiusRight:(CGFloat)corner;
    


#pragma mark 其它
//获取当前的VC
- (nullable UIViewController*)bt_viewController;

//移除子view
- (void)bt_removeChild:(UIView*)childView;

//移除所有子view
- (void)bt_removeAllChildView;

//设置默认的阴影效果
- (void)setBTDefaultShade;

//设置阴影效果
- (void)setBTShade:(CGFloat)opacity radius:(CGFloat)radius;
- (void)setBTShade:(CGFloat)opacity color:(UIColor*)color radius:(CGFloat)radius offset:(CGSize)size;

//从xib中加载对象
+ (instancetype)BTLoadInstanceFromNib;

//添加view
- (void)bt_addSubViewArray:(NSArray<UIView*>*)subviews;

//生成当前view的图片
- (UIImage*)bt_selfImg;

@end

NS_ASSUME_NONNULL_END
