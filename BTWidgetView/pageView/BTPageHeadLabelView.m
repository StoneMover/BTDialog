//
//  BTPageHeadLabelView.m
//  live
//
//  Created by stonemover on 2019/7/30.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "BTPageHeadLabelView.h"
#import "BTPageView.h"
#import "UIView+BTViewTool.h"

@interface BTPageHeadLabelView()<BTPageHeadViewDataSource>

@property (nonatomic, strong) NSArray * titles;

@property (nonatomic, assign) BTPageHeadViewStyle labelStyle;

@property (nonatomic, strong) NSMutableArray<UILabel*> * labels;

@end

@implementation BTPageHeadLabelView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles style:(BTPageHeadViewStyle)style{
    self=[super initWithFrame:frame];
    self.titles=titles;
    self.labelStyle=style;
    self.dataSource=self;
    self.labels = [NSMutableArray new];
    return self;
}

- (void)initDefaultData{
    
    if (!self.selectColor) {
        self.selectColor=UIColor.systemBlueColor;
    }
    
    if (!self.normalColor) {
        self.normalColor=UIColor.systemGrayColor;
    }
    
    if (self.selectFontSize==0) {
        self.selectFontSize=16;
    }
    
    if (self.normalFontSize==0) {
        self.normalFontSize=16;
    }
}

- (NSInteger)pageHeadViewNumOfItem:(BTPageHeadView*)headView{
    return self.titles.count;
}

- (UIView*)pageHeadView:(BTPageHeadView*)headView contentViewForIndex:(NSInteger)index{
    UILabel * label = [[UILabel alloc] init];
    label.font=[UIFont systemFontOfSize:self.normalFontSize weight:UIFontWeightMedium];
    label.textColor=self.normalColor;
    label.text=self.titles[index];
    label.textAlignment=NSTextAlignmentCenter;
    label.numberOfLines = 1;
    if (self.labelStyle == BTPageHeadViewStyleDefault) {
        [label sizeToFit];
        label.BTHeight = self.BTHeight;
    }else{
        label.frame = CGRectMake(0, 0, self.BTWidth / self.titles.count, self.BTHeight);
    }
    
    
    [self.labels addObject:label];
    return label;
}

- (BTPageHeadViewStyle)pageHeadViewStyle:(BTPageHeadView*)headView{
    return self.labelStyle;
}

- (void)reloadData{
    [self.labels removeAllObjects];
    [self initDefaultData];
    [super reloadData];
    for (UILabel * label in self.labels) {
        if (label == self.labels[0]) {
            label.textColor = self.selectColor;
            if (self.selectFontSize != self.normalFontSize) {
                CGFloat size = fabs((self.selectFontSize/self.normalFontSize-1))+1;
                label.transform = CGAffineTransformMakeScale(size,size);
            }else{
                label.transform = CGAffineTransformMakeScale(1,1);
            }
        }else{
            label.textColor = self.normalColor;
            label.transform = CGAffineTransformMakeScale(1, 1);
        }
    }
}

- (void)scrollViewIndicator:(CGFloat)percent{
    [super scrollViewIndicator:percent];
    //防止数组越界
    if (self.labels.count == 0)
        return;
    
    CGFloat one = 1.0;
    CGFloat percentOne = one / (self.titles.count - 1);
    //这里放大10000倍进行计算，否则会出现精度问题
    NSInteger indexNow = (int)(percent * 10000) / (int)(percentOne * 10000);
    if (indexNow + 1 >= self.labels.count) {
        //解决直接滑动到最后一个item颜色不会重置到normal的问题
        for (UILabel * label in self.labels) {
            if (label == self.labels.lastObject) {
                label.textColor = [self nowLabelColorLeft:abs(0)];
                [self nowLabelScale:abs(0) label:label];
            }else{
                label.textColor = self.normalColor;
                label.transform = CGAffineTransformMakeScale(1, 1);
            }
        }
        return;
    }
    
    UILabel * labelNow = self.labels[indexNow];
    UILabel * labelWillSelect = nil;
    CGFloat resultPercent = ((int)(indexNow * percentOne *10000) - (int)(percent*10000))/10000.0;
    if (resultPercent == 0) {
        for (UILabel * label in self.labels) {
            if (label == labelNow) {
                labelNow.textColor = [self nowLabelColorLeft:fabs(resultPercent)];
                [self nowLabelScale:fabs(resultPercent) label:labelNow];
            }else{
                label.textColor = self.normalColor;
                label.transform = CGAffineTransformMakeScale(1, 1);
            }
        }
        
        return;
    }
    

    labelWillSelect = self.labels[indexNow+1];
    
    labelNow.textColor = [self nowLabelColorLeft:fabs(resultPercent)];
    labelWillSelect.textColor = [self willSelectLabelColorRight:fabs(resultPercent)];
    
    
    [self nowLabelScale:fabs(resultPercent) label:labelNow];
    [self willSelectLabelScale:fabs(resultPercent) label:labelWillSelect];
    
}

- (UIColor*)nowLabelColorLeft:(CGFloat)percent{
    CGFloat one = 1.0;
    CGFloat percentOne = one / (self.titles.count - 1);
    
    CGFloat r_start = 0.0;
    CGFloat g_start = 0.0;
    CGFloat b_start = 0.0;
    
    CGFloat r_end = 0.0;
    CGFloat g_end = 0.0;
    CGFloat b_end = 0.0;
    
    [self.selectColor getRed:&r_start green:&g_start blue:&b_start alpha:nil];
    [self.normalColor getRed:&r_end green:&g_end blue:&b_end alpha:nil];
    
    CGFloat r = r_start - r_end;
    CGFloat g = g_start - g_end;
    CGFloat b = b_start - b_end;
    
    
    
    CGFloat percentResult = percent / percentOne;
    return [UIColor colorWithRed:r_start - r * percentResult
                           green:g_start - g * percentResult
                            blue:b_start - b * percentResult
                           alpha:1];
}



- (UIColor*)willSelectLabelColorRight:(CGFloat)percent{
    CGFloat one = 1.0;
    CGFloat percentOne = one / (self.titles.count - 1);
    
    CGFloat r_start = 0.0;
    CGFloat g_start = 0.0;
    CGFloat b_start = 0.0;
    
    CGFloat r_end = 0.0;
    CGFloat g_end = 0.0;
    CGFloat b_end = 0.0;
    
    [self.normalColor getRed:&r_start green:&g_start blue:&b_start alpha:nil];
    [self.selectColor getRed:&r_end green:&g_end blue:&b_end alpha:nil];
    
    CGFloat r = r_start - r_end;
    CGFloat g = g_start - g_end;
    CGFloat b = b_start - b_end;
    
    
    
    CGFloat percentResult = percent / percentOne;
    return [UIColor colorWithRed:r_start - r * percentResult
                           green:g_start - g * percentResult
                            blue:b_start - b * percentResult
                           alpha:1];
}

- (void)willSelectLabelScale:(CGFloat)percent label:(UILabel*)label{
    CGFloat one = 1.0;
    CGFloat percentOne = one / (self.titles.count - 1);
    CGFloat percentResult = percent / percentOne;
    CGFloat size = fabs((self.selectFontSize/self.normalFontSize-1) * percentResult);
    label.transform = CGAffineTransformMakeScale(1+size, 1+size);
}

- (void)nowLabelScale:(CGFloat)percent label:(UILabel*)label{
    CGFloat one = 1.0;
    CGFloat percentOne = one / (self.titles.count - 1);
    CGFloat percentResult =  1-percent / percentOne;
    CGFloat size = fabs((self.selectFontSize/self.normalFontSize-1) * percentResult);
    label.transform = CGAffineTransformMakeScale(1+size, 1+size);
}

- (void)unSelectLabel:(NSInteger)index{
    self.labels[index].textColor = self.normalColor;
}


- (void)selectIndex:(NSInteger)index{
    [super selectIndex:index];
    
    for (int i=0; i<self.labels.count; i++) {
        UILabel * label = self.labels[i];
        if (i == index) {
            label.transform = CGAffineTransformMakeScale(self.selectFontSize / self.normalFontSize, self.selectFontSize / self.normalFontSize);
            label.textColor = self.selectColor;
            [UIView animateWithDuration:0.2 animations:^{
                self.viewIndicator.BTCenterX = label.superview.BTCenterX;
            }];
        }else{
            label.transform = CGAffineTransformMakeScale(1, 1);
            label.textColor = self.normalColor;
        }
    }
}
@end
