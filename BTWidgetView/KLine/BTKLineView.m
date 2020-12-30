//
//  BTKLineView.m
//  BTWidgetViewExample
//
//  Created by apple on 2020/12/30.
//  Copyright © 2020 stone. All rights reserved.
//

#import "BTKLineView.h"
#import "UIView+BTConstraint.h"
#import "UIView+BTViewTool.h"
#import <BTHelp/UIColor+BTColor.h>
#import <BTHelp/NSDate+BTDate.h>

@interface BTKLineView()

//虚线背景宽度
@property (nonatomic, assign) CGFloat bgDashLineWidth;

//虚线背景颜色
@property (nonatomic, strong) UIColor * bgDashLineColor;

//画布的整体边距
@property (nonatomic, assign) BTPadding bgDashLinePadding;

//Y轴分为5份后，每一份基于画布的大小
@property (nonatomic, assign) CGFloat unitY;

//X轴分为5份后，每一份基于画布的大小
@property (nonatomic, assign) CGFloat unitX;

//y轴最大值
@property (nonatomic, assign) CGFloat maxValueY;

//y轴最小值
@property (nonatomic, assign) CGFloat minValueY;

@end


@implementation BTKLineView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self initTestData];
    [self initDefaultConfig];
    return self;
}

- (void)initTestData{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"LineTestData" ofType:@"txt"];
    NSString *dataFile = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSDictionary * dict = [dataFile bt_toDict];
    NSArray * dataArray = dict[@"data"][@"timedata"];
    self.dataArray = [NSMutableArray new];
    
    NSArray * arrayResult = [[[KLineModel modelWithArray:dataArray]reverseObjectEnumerator]allObjects];
    
    for (int i=0; i<arrayResult.count; i++) {
//        if (i>30) {
//
//        }
        KLineModel * model = arrayResult[i];
        NSLog(@"BTKLine-time:%@",model.times);
        [self.dataArray addObject:arrayResult[i]];
    }
    
    [self reloadData];
}

- (void)initDefaultConfig{
    self.bgDashLineWidth = 1;
    self.bgDashLineColor = [UIColor bt_RGBSame:227];
    self.bgDashLinePadding = BTPaddingMake(15, 34, 40, 30);
    
    self.unitY = (self.BTHeight - self.bgDashLinePadding.top - self.bgDashLinePadding.bottom) / 4;
    self.unitX = (self.BTWidth - self.bgDashLinePadding.left - self.bgDashLinePadding.right) / 4;
}


- (void)drawRect:(CGRect)rect{
    [self drawBasicLine];
    [self drawYText];
    [self drawXText];
    [self drawStock];
    
}


- (void)drawBasicLine{
    CGFloat lineWidth = self.bgDashLineWidth;
    CGColorRef strokeColor = self.bgDashLineColor.CGColor;
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ctx, strokeColor);
    //画横线
    for (int i=0; i<5; i++) {
        CGContextMoveToPoint(ctx, self.bgDashLinePadding.left, self.bgDashLinePadding.top + self.unitY * i);
        CGContextAddLineToPoint(ctx, self.BTWidth - self.bgDashLinePadding.right, self.bgDashLinePadding.top + self.unitY * i);
        CGFloat arr[] = {5,5};
        CGContextSetLineDash(ctx, 0, arr, 2);
        CGContextSetLineWidth(ctx, lineWidth);
        CGContextStrokePath(ctx);
        
    }
    //画竖线
    for (int i=0; i<5; i++) {
        CGContextMoveToPoint(ctx, self.bgDashLinePadding.left + self.unitX * i, self.bgDashLinePadding.top);
        CGContextAddLineToPoint(ctx, self.bgDashLinePadding.left + self.unitX * i, self.BTHeight - self.bgDashLinePadding.bottom);
        CGFloat arr[] = {5,5};
        CGContextSetLineDash(ctx, 0, arr, 2);
        CGContextSetLineWidth(ctx, lineWidth);
        CGContextStrokePath(ctx);
        
    }
    
    CGFloat arr[] = {};
    CGContextSetLineDash(ctx, 0, arr, 0);
}

- (void)drawYText{
    CGFloat unit = (self.maxValueY - self.minValueY) / 4;
    for(int i=0;i<5;i++){
        CGFloat value = self.maxValueY - i * unit;
        value = value / 100;
        NSString * valueStr = [NSString stringWithFormat:@"%.2f",value];
        CGFloat width = [valueStr bt_calculateStrWidth:1000 font:[UIFont systemFontOfSize:9 weight:UIFontWeightRegular]];
        CGFloat height = [valueStr bt_calculateStrHeight:width font:[UIFont systemFontOfSize:9 weight:UIFontWeightRegular]];
         
        NSDictionary * attributed = @{
            NSFontAttributeName : [UIFont systemFontOfSize:9 weight:UIFontWeightRegular],
            NSForegroundColorAttributeName : [UIColor bt_RGBSame:115]
        };
        
        CGPoint point = CGPointMake(self.bgDashLinePadding.left - width - (self.bgDashLinePadding.left - width)/2.0,
                                    self.bgDashLinePadding.top - height / 2.0 + self.unitY * i);
        [valueStr drawAtPoint:point withAttributes:attributed];
    }
}

- (void)drawXText{
    NSInteger index = self.dataArray.count / 4;
    for (int i=0; i<5; i++) {
        KLineModel * model = nil;
        if (i == 0) {
            model = self.dataArray.firstObject;
        }else if(i == 4){
            model = self.dataArray.lastObject;
        }else{
            model = self.dataArray[index * i];
        }
        NSLog(@"BTKLine-time:%@",model.times);
        NSString * time = [model.times substringToIndex:8];
        NSDate * date = [NSDate bt_dateFromStr:time formatter:@"yyyyMMdd"];
        NSString * valueStr = [date bt_dateStr:@"yyyy/MM/dd"];
        
        CGFloat width = [valueStr bt_calculateStrWidth:1000 font:[UIFont systemFontOfSize:9 weight:UIFontWeightRegular]];
        CGFloat height = [valueStr bt_calculateStrHeight:width font:[UIFont systemFontOfSize:9 weight:UIFontWeightRegular]];
        NSDictionary * attributed = @{
            NSFontAttributeName : [UIFont systemFontOfSize:9 weight:UIFontWeightRegular],
            NSForegroundColorAttributeName : [UIColor bt_RGBSame:115]
        };
        CGPoint point = CGPointMake(self.bgDashLinePadding.left + i * self.unitX - width / 2.0,
                                    self.BTHeight - height - 3);
        [valueStr drawAtPoint:point withAttributes:attributed];
    }
}

- (void)drawStock{
    CGFloat width = self.BTWidth - self.bgDashLinePadding.left - self.bgDashLinePadding.right;
    //每2个股票之间的间距
    NSInteger margin = 1;
    
    //每一个蜡烛图的宽度
    CGFloat unitWidth = (width - (self.dataArray.count - 1) * margin) / self.dataArray.count;
    //蜡烛图线的宽度
    CGFloat lineWidth = unitWidth / 4;
    
    CGFloat fullYLenth = self.BTHeight - self.bgDashLinePadding.top - self.bgDashLinePadding.bottom;
    
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, lineWidth);
    BOOL isRedColor = YES;
    CGContextSetStrokeColorWithColor(ctx, UIColor.redColor.CGColor);
    
    for (int i=0; i<self.dataArray.count; i++) {
        KLineModel * model = self.dataArray[i];
        if (model.openp < model.nowv) {
            if (!isRedColor) {
                isRedColor = YES;
                CGContextSetStrokeColorWithColor(ctx, UIColor.redColor.CGColor);
            }
        }else{
            if (isRedColor) {
                isRedColor = NO;
                CGContextSetStrokeColorWithColor(ctx, UIColor.greenColor.CGColor);
            }
        }
        CGFloat startPoint = 0;
        CGFloat endPoint = 0;
        startPoint = self.BTHeight - self.bgDashLinePadding.bottom - (model.lowp - self.minValueY) / (self.maxValueY - self.minValueY) * fullYLenth;
        endPoint = self.BTHeight - self.bgDashLinePadding.bottom - (model.highp - self.minValueY) / (self.maxValueY - self.minValueY) * fullYLenth;
        
        CGFloat xPoint = self.bgDashLinePadding.left + unitWidth / 2 + i * (margin + unitWidth);
        
//        NSLog(@"BTKLine-xPoint:%f",xPoint);
        
        CGContextMoveToPoint(ctx, xPoint, startPoint);
        CGContextAddLineToPoint(ctx, xPoint, endPoint);
        CGContextStrokePath(ctx);
    }
    
    
    CGContextSetLineWidth(ctx, unitWidth);
    isRedColor = YES;
    CGContextSetStrokeColorWithColor(ctx, UIColor.redColor.CGColor);
    for (int i=0; i<self.dataArray.count; i++) {
        KLineModel * model = self.dataArray[i];
        if (model.openp < model.nowv) {
            if (!isRedColor) {
                isRedColor = YES;
                CGContextSetStrokeColorWithColor(ctx, UIColor.redColor.CGColor);
            }
        }else{
            if (isRedColor) {
                isRedColor = NO;
                CGContextSetStrokeColorWithColor(ctx, UIColor.greenColor.CGColor);
            }
        }
        CGFloat startPoint = 0;
        CGFloat endPoint = 0;
        startPoint = self.BTHeight - self.bgDashLinePadding.bottom - (model.openp - self.minValueY) / (self.maxValueY - self.minValueY) * fullYLenth;
        endPoint = self.BTHeight - self.bgDashLinePadding.bottom - (model.nowv - self.minValueY) / (self.maxValueY - self.minValueY) * fullYLenth;
        
        CGFloat xPoint = self.bgDashLinePadding.left + unitWidth / 2 + i * (margin + unitWidth);
        
//        NSLog(@"BTKLine-xPoint:%f",xPoint);
        
        CGContextMoveToPoint(ctx, xPoint, startPoint);
        CGContextAddLineToPoint(ctx, xPoint, endPoint);
        CGContextStrokePath(ctx);
    }
    NSLog(@"");
}


- (void)reloadData{
    self.minValueY = self.dataArray.firstObject.lowp;
    self.maxValueY = self.dataArray.firstObject.highp;
    for (KLineModel * model in self.dataArray) {
        if (model.lowp < self.minValueY) {
            self.minValueY = model.lowp;
        }
        
        if (model.highp > self.maxValueY) {
            self.maxValueY = model.highp;
        }
    }
//    NSLog(@"BTKLine最大值：%f",self.maxValueY);
//    NSLog(@"BTKLine最小值：%f",self.minValueY);
    CGFloat unit = (self.maxValueY - self.minValueY) / 4;
    self.minValueY -= unit * 0.75;
    self.maxValueY += unit * 0.75;
    
    
}




@end
