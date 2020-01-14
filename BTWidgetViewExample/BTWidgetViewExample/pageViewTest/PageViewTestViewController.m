//
//  PageViewTestViewController.m
//  BTWidgetViewExample
//
//  Created by zanyu on 2019/8/28.
//  Copyright © 2019 stone. All rights reserved.
//

#import "PageViewTestViewController.h"
#import "BTPageView.h"
#import "UIView+BTViewTool.h"
#import <BTHelp/BTUtils.h>

@interface PageViewTestViewController ()<BTPageViewDataSource,BTPageViewDelegate>

@property (nonatomic, strong) BTPageView * pageView;

@property (nonatomic, strong) BTPageHeadLabelView * headView;


@end

@implementation PageViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=UIColor.whiteColor;
    self.pageView=[[BTPageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.pageView];
    self.pageView.dataSource=self;
    self.pageView.delegate=self;
    self.pageView.initSelectIndex=3;
    self.pageView.isNeedLoadNextAndLast=NO;
    self.headView=[[BTPageHeadLabelView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40) titles:@[@"第0项",@"第1项",@"第2项",@"第3项",@"第3项",@"第3项",@"第3项",@"第3项",@"第3项"] style:BTPageHeadViewStyleDefault];
    self.headView.itemMarin = 20;
    self.headView.rightPadding = 20;
    self.headView.leftPadding = 20;
    [self.headView initViewIndicator:CGSizeMake(15, 2) corner:0 bgColor:UIColor.redColor];
    
    
    [self.pageView reloadData];
}

- (NSInteger)pageNumOfView:(BTPageView*)pageView{
    return 9;
}

- (UIView*)pageView:(BTPageView*)pageView contentViewForIndex:(NSInteger)index{
    UILabel * label =[[UILabel alloc] init];
    label.font=[UIFont systemFontOfSize:146 weight:UIFontWeightBold];
    label.text=[NSString stringWithFormat:@"%ld",index];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=BTUtils.RANDOM_COLOR;
    label.backgroundColor=BTUtils.RANDOM_COLOR;
    return label;
}

//为空则不显示headView
- (BTPageHeadView*)pageViewHeadView:(BTPageView*)pageView{
    return self.headView;
}

- (CGRect)pageViewContentFrame:(BTPageView*)pageView{
    return CGRectMake(0, 40, self.view.width, self.view.height-40);
}

- (CGPoint)pageViewHeadOrigin:(BTPageView *)pageView{
    return CGPointMake(0, 0);
}

- (void)pageView:(BTPageView*)pageView didShow:(NSInteger)index{
    NSLog(@"didShow:%ld",index);
}

- (void)pageView:(BTPageView*)pageView didDismiss:(NSInteger)index{
    NSLog(@"didDismiss:%ld",index);
}

@end
