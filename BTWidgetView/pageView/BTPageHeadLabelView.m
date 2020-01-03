//
//  BTPageHeadLabelView.m
//  live
//
//  Created by stonemover on 2019/7/30.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "BTPageHeadLabelView.h"
#import "BTPageView.h"

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
        self.selectColor=UIColor.redColor;
    }
    
    if (!self.normalColor) {
        self.normalColor=UIColor.blackColor;
    }
    
    if (self.selectFontSize==0) {
        self.selectFontSize=18;
    }
    
    if (self.normalFontSize==0) {
        self.normalFontSize=16;
    }
}

- (NSInteger)pageHeadViewNumOfItem:(BTPageHeadView*)headView{
    return self.titles.count;
}

- (UIView*)pageHeadView:(BTPageHeadView*)headView contentViewForIndex:(NSInteger)index{
    UILabel * label=[[UILabel alloc]init];
    label.font=[UIFont systemFontOfSize:self.normalFontSize weight:UIFontWeightMedium];
    label.textColor=self.normalColor;
    label.text=self.titles[index];
    label.textAlignment=NSTextAlignmentCenter;
    [label sizeToFit];
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
}

- (void)scrollViewIndicator:(CGFloat)percent{
    [super scrollViewIndicator:percent];
    
    CGFloat one = 1.0;
    CGFloat percentOne = one / (self.titles.count - 1);
    NSNumber * indexNow = [self.superview valueForKey:@"nowIndex"];
    UILabel * labelNow = self.labels[indexNow.integerValue];
    UILabel * labelWillSelect = nil;
    CGFloat resultPercent = indexNow.integerValue * percentOne - percent;
//    NSLog(@"百分比:%f,当前下标:%ld",percent,(long)indexNow.integerValue);
    if (resultPercent == 0) {
        [self select:indexNow.integerValue];
        return;
    }
    
    
    
    if (resultPercent > 0) {
        //说明是在向左边滑动
        labelWillSelect = self.labels[indexNow.integerValue-1];
        labelWillSelect.textColor = [self willSelectLabelColorRight:resultPercent];
        labelNow.textColor = [self nowLabelColorLeft:resultPercent];
    }else{
        labelWillSelect = self.labels[indexNow.integerValue+1];
        labelWillSelect.textColor = [self nowLabelColorRight:-resultPercent];
        labelNow.textColor = [self nowLabelColorLeft:-resultPercent];
    }
    
    
    
    
    
}

- (void)select:(NSInteger)index{
    for (int i=0; i<self.labels.count; i++) {
        if (i == index) {
            self.labels[i].textColor = self.selectColor;
//            self.labels[i].font = [UIFont systemFontOfSize:self.selectFontSize weight:UIFontWeightMedium];
        }else{
            self.labels[i].textColor = self.normalColor;
//            self.labels[i].font = [UIFont systemFontOfSize:self.normalFontSize weight:UIFontWeightMedium];
        }
        [self.labels[i] sizeToFit];
    }
}

- (UIColor*)nowLabelColorLeft:(CGFloat)percent{
    const CGFloat * componentsSelect = CGColorGetComponents(self.selectColor.CGColor);
    const CGFloat * componentsNormal = CGColorGetComponents(self.normalColor.CGColor);
    CGFloat one = 1.0;
    CGFloat percentOne = one / (self.titles.count - 1);
    CGFloat r = componentsSelect[0] - componentsNormal[0];
    CGFloat g = componentsSelect[1] - componentsNormal[1];
    CGFloat b = componentsSelect[2] - componentsNormal[2];
    return [UIColor colorWithRed:componentsNormal[0] + r * (1-(percent / percentOne)) green:componentsNormal[1] + g * (1-(percent / percentOne)) blue:b + componentsNormal[2] +(1-(percent / percentOne)) alpha:1];
}

- (UIColor*)nowLabelColorRight:(CGFloat)percent{
    const CGFloat * componentsSelect = CGColorGetComponents(self.selectColor.CGColor);
    const CGFloat * componentsNormal = CGColorGetComponents(self.normalColor.CGColor);
    CGFloat one = 1.0;
    CGFloat percentOne = one / (self.titles.count - 1);
    CGFloat r = componentsSelect[0] - componentsNormal[0];
    CGFloat g = componentsSelect[1] - componentsNormal[1];
    CGFloat b = componentsSelect[2] - componentsNormal[2];
    return [UIColor colorWithRed:componentsNormal[0] + r * (percent / percentOne) green:componentsNormal[1] + g * (percent / percentOne) blue:b + componentsNormal[2] +(percent / percentOne) alpha:1];
}

- (UIColor*)willSelectLabelColorRight:(CGFloat)percent{
    const CGFloat * componentsSelect = CGColorGetComponents(self.selectColor.CGColor);
    const CGFloat * componentsNormal = CGColorGetComponents(self.normalColor.CGColor);
    CGFloat one = 1.0;
    CGFloat percentOne = one / (self.titles.count - 1);
    CGFloat r = componentsSelect[0] - componentsNormal[0];
    CGFloat g = componentsSelect[1] - componentsNormal[1];
    CGFloat b = componentsSelect[2] - componentsNormal[2];
    return [UIColor colorWithRed:componentsNormal[0] + r * (percent / percentOne) green:componentsNormal[1] + g * (percent / percentOne) blue:b + componentsNormal[2] +(percent / percentOne) alpha:1];
}

//- (UIColor*)willSelectLabelColorLeft:(CGFloat)percent{
//    const CGFloat * componentsSelect = CGColorGetComponents(self.selectColor.CGColor);
//    const CGFloat * componentsNormal = CGColorGetComponents(self.normalColor.CGColor);
//    CGFloat one = 1.0;
//    CGFloat percentOne = one / (self.titles.count - 1);
//    CGFloat r = componentsNormal[0] - componentsSelect[0];
//    CGFloat g = componentsNormal[1] - componentsSelect[1];
//    CGFloat b = componentsNormal[2] - componentsSelect[2];
//    return [UIColor colorWithRed:r - r * (percent / percentOne) green:g - g * (percent / percentOne) blue:b - b * (percent / percentOne) alpha:1];
//}

@end
