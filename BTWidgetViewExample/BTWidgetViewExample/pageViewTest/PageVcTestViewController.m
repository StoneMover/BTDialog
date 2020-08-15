//
//  PageVcTestViewController.m
//  BTWidgetViewExample
//
//  Created by zanyu on 2019/8/28.
//  Copyright © 2019 stone. All rights reserved.
//

#import "PageVcTestViewController.h"
#import "PageChildVcViewController.h"
#import "UIView+BTViewTool.h"

@interface PageVcTestViewController ()<BTPageViewControllerDelegate,BTPageViewControllerDataSource>

@property (nonatomic, strong) BTPageHeadView * headView;

@end

@implementation PageVcTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=UIColor.whiteColor;
    self.dataSource=self;
    self.delegate=self;
    self.headView=[[BTPageHeadLabelView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40) titles:@[@"第0项",@"第1项",@"第2项",@"第3项"] style:BTPageHeadViewStyleAverage];
    [self.headView initViewIndicator:CGSizeMake(15, 2) corner:0 bgColor:UIColor.redColor];
    self.headView.isNeedClickAnim=NO;
    self.isCanScroll=YES;
    [self reloadData];
}

- (NSInteger)pageNumOfVc:(BTPageViewController*)pageView{
    return 4;
}

- (UIViewController*)pageVc:(BTPageViewController*)pageVc vcForIndex:(NSInteger)index{
    PageChildVcViewController * vc =[PageChildVcViewController new];
    vc.index=index;
    return vc;
}

//为空则不显示headView
- (BTPageHeadView*)pageVcHeadView:(BTPageViewController*)pageVc{
    return self.headView;
}

- (CGPoint)pageVcHeadOrigin:(BTPageViewController *)pageVc{
    return CGPointMake(0, 0);
}

- (CGRect)pageVcContentFrame:(BTPageViewController*)pageVc{
    return CGRectMake(0, 50, self.view.BTWidth, self.view.BTHeight-50);
}

- (void)pageVc:(BTPageViewController*)pageView didShow:(NSInteger)index{
    
}

- (void)pageVc:(BTPageViewController *)pageView didDismiss:(NSInteger)index{
    
}

@end
