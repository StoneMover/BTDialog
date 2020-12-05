//
//  BTProgressView.m
//  BTWidgetViewExample
//
//  Created by apple on 2020/4/28.
//  Copyright © 2020 stone. All rights reserved.
//

#import "BTProgressView.h"
#import "UIView+BTViewTool.h"
#import <BTHelp/BTHelp.h>

@implementation BTProgressView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self initSelf];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    [self initSelf];
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
}

- (void)initSelf{
    _progressLabel = [[UILabel alloc] init];
    self.progressLabel.textColor = [UIColor bt_RGBSame:51];
    self.progressLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    self.progressLabel.hidden = YES;
    [self addSubview:self.progressLabel];
    
    
    _slideImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    self.slideImgView.hidden = YES;
    self.slideImgView.userInteractionEnabled = NO;
    [self addSubview:self.slideImgView];
    
    if (self.progressBgColor == nil) {
        self.progressBgColor = UIColor.whiteColor;
    }
}

- (void)setType:(NSInteger)type{
    _type = type;
    [self setNeedsDisplay];
}

- (void)setPercent:(CGFloat)percent{
    if (percent < 0) {
        percent = 0;
    }
    
    if (percent > 1) {
        percent = 1;
    }
    _percent = percent;
    [self setNeedsDisplay];
}

- (void)setProgressColor:(UIColor *)progressColor{
    _progressColor = progressColor;
    [self setNeedsDisplay];
}

- (void)setProgressCorner:(CGFloat)progressCorner{
    _progressCorner = progressCorner;
    [self setNeedsDisplay];
}

- (void)setProgressWidth:(CGFloat)progressWidth{
    _progressWidth = progressWidth;
    [self setNeedsDisplay];
}

- (void)setIsShowProgressLabel:(BOOL)isShowProgressLabel{
    if (self.type != BTProgressStyleCircleBorder) {
        return;
    }
    _isShowProgressLabel = isShowProgressLabel;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    self.progressLabel.hidden = YES;
    self.slideImgView.hidden = YES;
    if (self.BTWidth == 0 || self.BTHeight == 0) {
        return;
    }
    
    switch (self.type) {
        case BTProgressStyleLineHoz:
        {
            CGFloat startX = 0;
            CGFloat width = self.BTWidth;
            if (self.progressSize == 0) {
                self.progressSize = self.BTHeight;
            }
            if (self.isCanSlide) {
                
                if (self.slideImgView.image) {
                    startX = self.slideImgView.BTWidth / 2;
                    width = self.BTWidth - self.slideImgView.BTWidth;
                }
                
                self.slideImgView.hidden = NO;
                self.slideImgView.BTCenterX = startX + self.percent * width;
                self.slideImgView.BTCenterY = self.BTHeight / 2.0;
                
                
            }
            
            [self.progressBgColor setFill];
            UIBezierPath * pathBg = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(startX, (self.BTHeight - self.progressSize) / 2.0, width, self.progressSize) cornerRadius:self.progressCorner];
            [pathBg fill];
            
            [self.progressColor setFill];
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(startX, (self.BTHeight - self.progressSize) / 2.0, self.percent * width, self.progressSize) cornerRadius:self.progressCorner];
            [path fill];
            
            
        }
            break;
        case BTProgressStyleLineVer:
        {
            CGFloat startY = 0;
            CGFloat height = self.BTHeight;
            if (self.progressSize == 0) {
                self.progressSize = self.BTHeight;
            }
            if (self.isCanSlide) {
                
                if (self.slideImgView.image) {
                    startY = self.slideImgView.BTHeight / 2;
                    height = self.BTHeight - self.slideImgView.BTHeight;
                }
                
                self.slideImgView.hidden = NO;
                self.slideImgView.BTCenterX = self.BTWidth / 2.0;
                self.slideImgView.BTCenterY = self.percent * self.BTHeight;
            }
            
            [self.progressBgColor setFill];
            UIBezierPath * pathBg = [UIBezierPath bezierPathWithRoundedRect:CGRectMake((self.BTWidth - self.progressSize)/2.0, startY, self.progressSize, height) cornerRadius:self.progressCorner];
            [pathBg fill];
            
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake((self.BTWidth - self.progressSize)/2.0, startY, self.progressSize, height * self.percent) cornerRadius:self.progressCorner];
            [self.progressColor setFill];
            [path fill];
            
        }
            break;
        case BTProgressStyleCircleFull:
        {
            CGFloat radius = self.BTWidth > self.BTHeight ? self.BTHeight / 2 : self.BTWidth / 2;
            CGPoint center = CGPointMake(self.BTWidth / 2.0, self.BTHeight / 2.0);
            
            [self.progressBgColor setFill];
            UIBezierPath * pathBg = [UIBezierPath bezierPathWithArcCenter:center
                                                                   radius:radius
                                                               startAngle:-0.5 * M_PI
                                                                 endAngle:1 * M_PI * 2 - 0.5 * M_PI
                                                                clockwise:YES];
            [pathBg fill];

            UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:center
                                                                 radius:radius
                                                             startAngle:-0.5 * M_PI
                                                               endAngle:self.percent * M_PI * 2 - 0.5 * M_PI
                                                              clockwise:YES];
            [path addLineToPoint:center];
            [self.progressColor setFill];
            [path fill];
        }
            break;
        case BTProgressStyleCircleBorder:
        {
            CGFloat radius = self.BTWidth > self.BTHeight ? self.BTHeight / 2 : self.BTWidth / 2;
            radius -= self.progressWidth / 2;
            CGPoint center = CGPointMake(self.BTWidth / 2.0, self.BTHeight / 2.0);
            
            
            [self.progressBgColor setStroke];
            UIBezierPath * pathBg = [UIBezierPath bezierPathWithArcCenter:center
                                                                   radius:radius
                                                               startAngle:-0.5 * M_PI
                                                                 endAngle: 1 * M_PI * 2 - 0.5 * M_PI
                                                                clockwise:YES];
            pathBg.lineWidth = self.progressWidth;
            pathBg.lineCapStyle = kCGLineCapRound;//线条拐角
            pathBg.lineJoinStyle = kCGLineCapRound;//终点处理
            [pathBg stroke];
            
            
            UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:center
                                                                 radius:radius
                                                             startAngle:-0.5 * M_PI
                                                               endAngle: self.percent * M_PI * 2 - 0.5 * M_PI
                                                              clockwise:YES];
            path.lineWidth = self.progressWidth;
            path.lineCapStyle = kCGLineCapRound;//线条拐角
            path.lineJoinStyle = kCGLineCapRound;//终点处理
            [self.progressColor setStroke];
            [path stroke];
            
            if (self.isShowProgressLabel) {
                self.progressLabel.hidden = NO;
                self.progressLabel.text = [NSString stringWithFormat:@"%.0f%@",self.percent * 100,@"%"];
                [self.progressLabel sizeToFit];
                [self.progressLabel setBTCenterParent];
                
            }
            
        }
            
        default:
            break;
    }
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!self.isCanSlide) {
        return;
    }
    self.isTouch = YES;
    UITouch * touch=[touches anyObject];
    CGPoint point=[touch locationInView:self];
    [self change:point];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!self.isCanSlide || !self.isCanClickChangePercent) {
        return;
    }
    UITouch * touch=[touches anyObject];
    CGPoint point=[touch locationInView:self];
    [self change:point];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.isTouch = NO;
}


- (void)change:(CGPoint)point{
    
    switch (self.type) {
        case BTProgressStyleLineHoz:
        {
            CGFloat percent = point.x / self.BTWidth;
            if (self.isCanSlide && self.slideImgView.image) {
                percent = (point.x - self.slideImgView.BTWidth / 2.0) / (self.BTWidth - self.slideImgView.BTWidth);
            }
            if (self.delegate && [self.delegate respondsToSelector:@selector(BTProgressSlideChange:)]) {
                [self.delegate BTProgressSlideChange:percent];
            }
            self.percent = percent;
        }
            break;
        case BTProgressStyleLineVer:
        {
            CGFloat percent = point.y / self.BTHeight;
            if (self.isCanSlide && self.slideImgView.image) {
                percent = (point.y - self.slideImgView.BTHeight / 2.0) / (self.BTHeight - self.slideImgView.BTHeight);
            }
            if (self.delegate && [self.delegate respondsToSelector:@selector(BTProgressSlideChange:)]) {
                [self.delegate BTProgressSlideChange:percent];
            }
            self.percent = percent;
        }
            break;
            
        default:
            break;
    }
}

@end
