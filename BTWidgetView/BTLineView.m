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



-(void)drawRect:(CGRect)rect{
    
    CGFloat lineWidth=self.lineWidth==0?0.5:self.lineWidth;
    CGColorRef strokeColor=self.color?self.color.CGColor:[UIColor lightGrayColor].CGColor;
    
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ctx, strokeColor);
    
    if (self.oriention==BTLineViewHoz) {
        //水平情况
        if(self.aligntMent==BTLineViewAlignmentTop){
            //居上的情况
            CGContextMoveToPoint(ctx, 0, self.lineWidth/2);
            CGContextAddLineToPoint(ctx, self.width, self.lineWidth/2);
        }else if (self.aligntMent==BTLineViewAlignmentCenter){
            CGContextMoveToPoint(ctx, 0, self.height/2.0);
            CGContextAddLineToPoint(ctx, self.width, self.height/2.0);
        }else if (self.aligntMent==BTLineViewAlignmentBottom){
            CGContextMoveToPoint(ctx, 0, self.height-self.lineWidth/2);
            CGContextAddLineToPoint(ctx, self.width, self.height-self.lineWidth/2);
        }
        
    }else{
        
        if (self.aligntMent==BTLineViewAlignmentLeft) {
            CGContextMoveToPoint(ctx, self.lineWidth/2, 0);
            CGContextAddLineToPoint(ctx, self.lineWidth/2,self.height);
        }else if (self.aligntMent==BTLineViewAlignmentCenter){
            CGContextMoveToPoint(ctx, self.width/2.0, 0);
            CGContextAddLineToPoint(ctx, self.width/2.0,self.height);
        }else if (self.aligntMent==BTLineViewAlignmentRight){
            CGContextMoveToPoint(ctx, self.width-self.lineWidth/2, 0);
            CGContextAddLineToPoint(ctx, self.width-self.lineWidth/2,self.height);
        }
        
        
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

@end
