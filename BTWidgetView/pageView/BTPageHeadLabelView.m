//
//  BTPageHeadLabelView.m
//  live
//
//  Created by stonemover on 2019/7/30.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "BTPageHeadLabelView.h"

@interface BTPageHeadLabelView()<BTPageHeadViewDataSource>

@property (nonatomic, strong) NSArray * titles;

@property (nonatomic, assign) BTPageHeadViewStyle labelStyle;

@end

@implementation BTPageHeadLabelView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles style:(BTPageHeadViewStyle)style{
    self=[super initWithFrame:frame];
    self.titles=titles;
    self.labelStyle=style;
    self.dataSource=self;
    return self;
}

- (void)initDefaultData{
    if (!self.font) {
        self.font=[UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    }
    
    if (!self.selectColor) {
        self.selectColor=UIColor.redColor;
    }
    
    if (!self.normalColor) {
        self.normalColor=UIColor.blackColor;
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
    UILabel * label=[[UILabel alloc]init];
    label.font=self.font;
    label.textColor=self.normalColor;
    label.text=self.titles[index];
    label.textAlignment=NSTextAlignmentCenter;
    [label sizeToFit];
    return label;
}

- (BTPageHeadViewStyle)pageHeadViewStyle:(BTPageHeadView*)headView{
    return self.labelStyle;
}

- (void)reloadData{
    [self initDefaultData];
    [super reloadData];
}

@end
