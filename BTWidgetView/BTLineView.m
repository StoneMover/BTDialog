//
//  BTLineView.m
//  huashi
//
//  Created by stonemover on 16/8/20.
//  Copyright © 2016年 StoneMover. All rights reserved.
//

#import "BTLineView.h"
#import "UIView+BTViewTool.h"


@implementation BTLineView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.color = [UIColor colorWithRed:0.24 green:0.24 blue:0.26 alpha:0.29];
    self.lineWidth = .5;
    return self;
}

-(void)drawRect:(CGRect)rect{
    self.backgroundColor = UIColor.clearColor;
    CGFloat lineWidth=self.lineWidth;
    CGColorRef strokeColor=self.color.CGColor;
    
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ctx, strokeColor);
    
    if (self.oriention==BTLineViewHoz) {
        //水平情况
        if(self.aligntMent==BTLineViewAlignmentTop){
            //居上的情况
            CGContextMoveToPoint(ctx, 0, self.lineWidth/2);
            CGContextAddLineToPoint(ctx, self.BTWidth, self.lineWidth/2);
        }else if (self.aligntMent==BTLineViewAlignmentCenter){
            CGContextMoveToPoint(ctx, 0, self.BTHeight/2.0);
            CGContextAddLineToPoint(ctx, self.BTWidth, self.BTHeight/2.0);
        }else if (self.aligntMent==BTLineViewAlignmentBottom){
            CGContextMoveToPoint(ctx, 0, self.BTHeight-self.lineWidth/2);
            CGContextAddLineToPoint(ctx, self.BTWidth, self.BTHeight-self.lineWidth/2);
        }
        
    }else{
        
        if (self.aligntMent==BTLineViewAlignmentLeft) {
            CGContextMoveToPoint(ctx, self.lineWidth/2, 0);
            CGContextAddLineToPoint(ctx, self.lineWidth/2,self.BTHeight);
        }else if (self.aligntMent==BTLineViewAlignmentCenter){
            CGContextMoveToPoint(ctx, self.BTWidth/2.0, 0);
            CGContextAddLineToPoint(ctx, self.BTWidth/2.0,self.BTHeight);
        }else if (self.aligntMent==BTLineViewAlignmentRight){
            CGContextMoveToPoint(ctx, self.BTWidth-self.lineWidth/2, 0);
            CGContextAddLineToPoint(ctx, self.BTWidth-self.lineWidth/2,self.BTHeight);
        }
        
        
    }
    
    if (self.dashedLineWidthAndMargin != 0) {
        CGFloat arr[] = {self.dashedLineWidthAndMargin,self.dashedLineWidthAndMargin};
        CGContextSetLineDash(ctx, 0, arr, 2);
    }
    
    CGContextSetLineWidth(ctx, lineWidth);
    
    CGContextStrokePath(ctx);
}

- (void)setLineWidth:(CGFloat)lineWidth{
    _lineWidth=lineWidth;
    [self setNeedsDisplay];
}

- (void)setColor:(UIColor *)color{
    _color=color;
    [self setNeedsDisplay];
}

- (void)setOriention:(NSInteger)oriention{
    _oriention=oriention;
    [self setNeedsDisplay];
}

- (void)setAligntMent:(NSInteger)aligntMent{
    _aligntMent=aligntMent;
    [self setNeedsDisplay];
}

- (void)setDashedLineWidthAndMargin:(NSInteger)dashedLineWidthAndMargin{
    _dashedLineWidthAndMargin = dashedLineWidthAndMargin;
    if (dashedLineWidthAndMargin == 0) {
        return;
    }
    [self setNeedsDisplay];
}

@end
