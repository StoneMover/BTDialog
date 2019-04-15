//
//  UIView+BTViewTool.m
//  help
//
//  Created by stonemover on 2019/1/7.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "UIView+BTViewTool.h"

@implementation UIView (BTViewTool)

- (instancetype)initWithSubView:(UIView*)subView{
    self=[self initWithFrame:subView.bounds];
    [self addSubview:subView];
    return self;
}

- (instancetype)initWithSize:(CGSize)size{
   return [self initWithFrame:CGRectMake(0, 0, size.width, size.height)];
}


- (void)setWidth:(CGFloat)width{
    self.frame=CGRectMake(self.left, self.top, width, self.height);
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    self.frame=CGRectMake(self.left, self.top, self.width, height);
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setLeft:(CGFloat)left{
    self.frame=CGRectMake(left, self.top, self.width, self.height);
}

- (CGFloat)left{
    return self.frame.origin.x;
}

- (void)setRight:(CGFloat)right{
    self.frame=CGRectMake(right-self.width, self.top, self.width, self.height);
}

- (CGFloat)right{
    return self.frame.origin.x+self.frame.size.width;
}

- (void)setTop:(CGFloat)top{
    self.frame=CGRectMake(self.left, top, self.width, self.height);
}

- (CGFloat)top{
    return self.frame.origin.y;
}

- (void)setBottom:(CGFloat)bottom{
    self.frame=CGRectMake(self.left, bottom-self.height, self.width, self.height);
}

- (CGFloat)bottom{
    return self.frame.origin.y+self.frame.size.height;
}



- (void)setCenterY:(CGFloat)centerY{
    self.center=CGPointMake(self.centerX, centerY);
}
- (CGFloat)centerY{
    return self.center.y;
}

- (void)setCenterX:(CGFloat)centerX{
    self.center=CGPointMake(centerX, self.centerY);
}
- (CGFloat)centerX{
    return self.center.x;
}


- (void)setCorner:(CGFloat)corner{
    self.layer.cornerRadius=corner;
    self.clipsToBounds=YES;
}

- (CGFloat)corner{
    return self.layer.cornerRadius;
}
    
- (void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor=borderColor.CGColor;
}
    
- (UIColor*)borderColor{
    //不知道怎么用CGColor转Color
    return [UIColor whiteColor];
}
    
- (void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth=borderWidth;
}
    
- (CGFloat)borderWidth{
    return self.layer.borderWidth;
}

- (void)setCorner:(CGFloat)corner borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor{
    self.layer.cornerRadius=corner;
    self.layer.borderColor=borderColor.CGColor;
    self.layer.borderWidth=borderWidth;
    self.clipsToBounds=YES;
}

- (void)setCornerRadiusBottom:(CGFloat)corner{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(corner, corner)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
    
- (void)setCornerRadiusTop:(CGFloat)corner{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(corner, corner)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
    
- (void)setCornerRadiusLeft:(CGFloat)corner{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(corner, corner)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
    
- (void)setCornerRadiusRight:(CGFloat)corner{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(corner, corner)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
    
- (void)removeChild:(UIView*)childView{
    if (!childView) {
        return;
    }
    for (UIView * view in self.subviews) {
        if (childView==view) {
            [view removeFromSuperview];
            return;
        }
    }
}
- (void)removeAllChildView{
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
}

- (UIViewController *)viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)setDefaultShade{
    [self setShade:.35 color:[UIColor blackColor] radius:6 offset:CGSizeZero];
}
    
- (void)setShade:(CGFloat)opacity radius:(CGFloat)radius{
    [self setShade:opacity color:[UIColor blackColor] radius:radius offset:CGSizeZero];
}
    
- (void)setShade:(CGFloat)opacity color:(UIColor*)color radius:(CGFloat)radius offset:(CGSize)size{
    self.layer.shadowOpacity=opacity;
    self.layer.shadowColor=color.CGColor;
    self.layer.shadowRadius=radius;
    self.layer.shadowOffset=size;
}



+(instancetype)loadInstanceFromNib
{
    UIView *result = nil;
    NSArray* elements = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    for (id object in elements)
    {
        if ([object isKindOfClass:[self class]])
        {
            result = object;
            break;
        }
    }
    return result;
}

@end
