//
//  BTLeadView.m
//  BTWidgetViewExample
//
//  Created by apple on 2021/4/8.
//  Copyright © 2021 stone. All rights reserved.
//

#import "BTLeadView.h"

@implementation BTLeadModel

- (instancetype)initWithView:(UIView*)view type:(BTLeadEmptyType)type padding:(BTPadding)padding{
    self = [super init];
    self.view = view;
    self.type = type;
    self.padding = padding;
    self.rect = [view convertRect:view.bounds toView:BTUtils.APP_WINDOW];
    self.arcMovePoint = CGPointMake(0, 0);
    return self;
}

- (instancetype)initWithView:(UIView*)view type:(BTLeadEmptyType)type{
    return [self initWithView:view type:type padding:BTPaddingMake(0, 0, 0, 0)];
}

+ (instancetype)modelWithView:(UIView*)view type:(BTLeadEmptyType)type padding:(BTPadding)padding{
    return [[BTLeadModel alloc] initWithView:view type:type padding:padding];
}

+ (instancetype)modelWithView:(UIView*)view type:(BTLeadEmptyType)type{
    return [[BTLeadModel alloc] initWithView:view type:type padding:BTPaddingMake(0, 0, 0, 0)];
}

@end


@interface BTLeadView()

@property (nonatomic, assign) NSTimeInterval beginTime;

@end



@implementation BTLeadView

#pragma mark 生命周期
- (void)dealloc{
    
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    UIBezierPath * rootPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:0];
    
    for (BTLeadModel * model in self.dataArray) {
        switch (model.type) {
            case BTLeadEmptyTypeRectangle:
            {
                //矩形效果
                CGRect rect = CGRectMake(model.rect.origin.x - model.padding.left,
                                         model.rect.origin.y - model.padding.top,
                                         model.rect.size.width + model.padding.left + model.padding.right,
                                         model.rect.size.height + model.padding.top + model.padding.bottom);
                UIBezierPath * path = [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:model.view.layer.cornerRadius] bezierPathByReversingPath];
                [rootPath appendPath:path];
            }
                break;
            case BTLeadEmptyTypeOval:
            {
                CGRect rect = CGRectMake(model.rect.origin.x - model.padding.left,
                                         model.rect.origin.y - model.padding.top,
                                         model.rect.size.width + model.padding.left + model.padding.right,
                                         model.rect.size.height + model.padding.top + model.padding.bottom);
                UIBezierPath * path = [[UIBezierPath bezierPathWithOvalInRect:rect] bezierPathByReversingPath];
                [rootPath appendPath:path];
            }
                break;
            case BTLeadEmptyTypeArc:
            {
                CGFloat radius = 0;
                if (model.rect.size.width > model.rect.size.height) {
                    radius = (model.rect.size.height - model.padding.top - model.padding.bottom) / 2.0;
                }else{
                    radius = (model.rect.size.width - model.padding.left - model.padding.right) / 2.0;
                }
                CGPoint point = CGPointMake(model.rect.origin.x + model.rect.size.width / 2.0 + model.arcMovePoint.x, model.rect.origin.y + model.rect.size.height / 2.0 + model.arcMovePoint.y);
                UIBezierPath * path = [[UIBezierPath bezierPathWithArcCenter:point radius:radius startAngle:-0.5 * M_PI endAngle:1 * M_PI * 2 - 0.5 * M_PI clockwise:YES] bezierPathByReversingPath];
                [rootPath appendPath:path];
            }
                break;
        }
        
        
    }
    
    CAShapeLayer * slayer = [CAShapeLayer layer];
    slayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    slayer.path = rootPath.CGPath;
    
    self.layer.mask = slayer;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    self.beginTime = NSDate.date.timeIntervalSince1970;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    CGPoint point = [touches.anyObject locationInView:self];
    NSTimeInterval time = NSDate.date.timeIntervalSince1970;
    if (time - self.beginTime > 0.35) {
        return;
    }
    
    if (self.blockClick) {
        self.blockClick();
    }
    
    for (BTLeadModel * model in self.dataArray) {
        CGFloat starX = model.rect.origin.x;
        CGFloat endX = model.rect.origin.x + model.rect.size.width;
        CGFloat starY = model.rect.origin.y;
        CGFloat endY = model.rect.origin.y + model.rect.size.height;
        if (point.x > starX && point.x < endX && point.y > starY && point.y < endY && model.blockClick){
            model.blockClick();
            return;
        }
        
    }
    
    
}

#pragma mark 初始化
- (instancetype)initWithShowView:(NSArray<BTLeadModel*>*)dataArray{
    self = [super initWithFrame:UIScreen.mainScreen.bounds];
    _dataArray = dataArray;
    self.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.65];
    return self;
}


#pragma mark 点击事件

#pragma mark 相关方法
- (void)show{
    self.alpha = 0;
    [BTUtils.APP_WINDOW addSubview:self];
    [UIView animateWithDuration:0.6 animations:^{
        self.alpha = 1;
    }];
}

- (void)showWithOutAnim{
    [BTUtils.APP_WINDOW addSubview:self];
}

- (void)dismiss{
    [self removeFromSuperview];
}




@end


