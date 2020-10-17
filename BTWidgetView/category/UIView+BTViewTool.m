//
//  UIView+BTViewTool.m
//  help
//
//  Created by stonemover on 2019/1/7.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "UIView+BTViewTool.h"

@implementation UIView (BTViewTool)

- (instancetype)initBTViewWithSubView:(UIView*)subView{
    self=[self initWithFrame:subView.bounds];
    [self addSubview:subView];
    return self;
}

- (instancetype)initBTViewWithSize:(CGSize)size{
   return [self initWithFrame:CGRectMake(0, 0, size.width, size.height)];
}

- (instancetype)initBTViewWithEqualSize:(CGFloat)size{
    return [self initWithFrame:CGRectMake(0, 0, size, size)];
}


- (void)setBTWidth:(CGFloat)width{
    self.frame=CGRectMake(self.BTLeft, self.BTTop, width, self.BTHeight);
}

- (CGFloat)BTWidth{
    return self.frame.size.width;
}

- (void)setBTHeight:(CGFloat)height{
    self.frame=CGRectMake(self.BTLeft, self.BTTop, self.BTWidth, height);
}

- (CGFloat)BTHeight{
    return self.frame.size.height;
}

- (void)setBTLeft:(CGFloat)left{
    self.frame=CGRectMake(left, self.BTTop, self.BTWidth, self.BTHeight);
}

- (CGFloat)BTLeft{
    return self.frame.origin.x;
}

- (void)setBTRight:(CGFloat)right{
    self.frame=CGRectMake(right-self.BTWidth, self.BTTop, self.BTWidth, self.BTHeight);
}

- (CGFloat)BTRight{
    return self.frame.origin.x+self.frame.size.width;
}

- (void)setBTTop:(CGFloat)top{
    self.frame=CGRectMake(self.BTLeft, top, self.BTWidth, self.BTHeight);
}

- (CGFloat)BTTop{
    return self.frame.origin.y;
}

- (void)setBTBottom:(CGFloat)bottom{
    self.frame=CGRectMake(self.BTLeft, bottom-self.BTHeight, self.BTWidth, self.BTHeight);
}

- (CGFloat)BTBottom{
    return self.frame.origin.y+self.frame.size.height;
}



- (void)setBTCenterY:(CGFloat)centerY{
    self.center=CGPointMake(self.BTCenterX, centerY);
}
- (CGFloat)BTCenterY{
    return self.center.y;
}

- (void)setBTCenterX:(CGFloat)centerX{
    self.center=CGPointMake(centerX, self.BTCenterY);
}
- (CGFloat)BTCenterX{
    return self.center.x;
}

- (void)setBTSize:(CGSize)size{
    self.frame = CGRectMake(self.BTOrigin.x, self.BTOrigin.y, size.width, size.height);
}

- (CGSize)BTSize{
    return self.frame.size;
}

- (void)setBTOrigin:(CGPoint)point{
    self.frame = CGRectMake(point.x, point.y, self.BTSize.width, self.BTSize.height);
}

- (CGPoint)BTOrigin{
    return self.frame.origin;
}

- (void)setBTCenterParentX{
    self.BTCenterX = self.superview.BTWidth / 2.0;
}
- (void)setBTCenterParentY{
    self.BTCenterY = self.superview.BTHeight / 2.0;
}
- (void)setBTCenterParent{
    [self setBTCenterParentY];
    [self setBTCenterParentX];
}

- (void)setBTCorner:(CGFloat)corner{
    self.layer.cornerRadius=corner;
    self.clipsToBounds=YES;
}

- (CGFloat)BTCorner{
    return self.layer.cornerRadius;
}
    
- (void)setBTBorderColor:(UIColor *)borderColor{
    self.layer.borderColor=borderColor.CGColor;
}
    
- (UIColor*)BTBorderColor{
    //不知道怎么用CGColor转Color
    return [UIColor whiteColor];
}
    
- (void)setBTBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth=borderWidth;
}
    
- (CGFloat)BTBorderWidth{
    return self.layer.borderWidth;
}

- (void)setBTCorner:(CGFloat)corner borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor{
    self.layer.cornerRadius=corner;
    self.layer.borderColor=borderColor.CGColor;
    self.layer.borderWidth=borderWidth;
    self.clipsToBounds=YES;
}

- (void)setBTCornerRadiusBottom:(CGFloat)corner{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(corner, corner)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
    
- (void)setBTCornerRadiusTop:(CGFloat)corner{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(corner, corner)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
    
- (void)setBTCornerRadiusLeft:(CGFloat)corner{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(corner, corner)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
    
- (void)setBTCornerRadiusRight:(CGFloat)corner{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(corner, corner)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
    
- (void)bt_removeChild:(UIView*)childView{
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
- (void)bt_removeAllChildView{
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
}

- (nullable UIViewController *)bt_viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)setBTDefaultShade{
    [self setBTShade:.08 color:[UIColor blackColor] radius:2 offset:CGSizeZero];
}
    
- (void)setBTShade:(CGFloat)opacity radius:(CGFloat)radius{
    [self setBTShade:opacity color:[UIColor blackColor] radius:radius offset:CGSizeZero];
}
    
- (void)setBTShade:(CGFloat)opacity color:(UIColor*)color radius:(CGFloat)radius offset:(CGSize)size{
    self.layer.shadowOpacity=opacity;
    self.layer.shadowColor=color.CGColor;
    self.layer.shadowRadius=radius;
    self.layer.shadowOffset=size;
}



+(instancetype)BTLoadInstanceFromNib
{
    UIView *result = nil;
    NSString * name = NSStringFromClass([self class]);
    if ([name containsString:@"."]) {
        name = [name componentsSeparatedByString:@"."].lastObject;
    }
    NSArray* elements = [[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil];
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

- (void)bt_addSubViewArray:(NSArray<UIView*>*)subviews{
    for (UIView * v in subviews) {
        [self addSubview:v];
    }
}

- (UIImage*)bt_selfImg{
    CGFloat scale =[UIScreen mainScreen].scale;
    UIImage *imageRet = [[UIImage alloc]init];
    //UIGraphicsBeginImageContextWithOptions(区域大小, 是否是非透明的, 屏幕密度);
    UIGraphicsBeginImageContextWithOptions(self.frame.size, YES, scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return imageRet;
}
@end
