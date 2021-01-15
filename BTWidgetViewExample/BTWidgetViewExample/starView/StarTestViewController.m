//
//  StarTestViewController.m
//  BTWidgetViewExample
//
//  Created by apple on 2020/12/7.
//  Copyright © 2020 stone. All rights reserved.
//

#import "StarTestViewController.h"
#import "BTStarView.h"
#import "UIView+BTConstraint.h"
#import "BTNumAnimView.h"
#import "UIView+BTViewTool.h"

@interface StarTestViewController ()

@property (nonatomic, strong) BTStarView * starDrawView;

@end

@implementation StarTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"StarView";
    self.starDrawView = [[BTStarView alloc] initDrawStarWithNum:5 size:50 selectColor:UIColor.redColor normalColor:nil];
    self.starDrawView.isCanTouchSelect = YES;
    self.starDrawView.frame = CGRectMake(0, 100, self.starDrawView.calculateWidth, 50);
    [self.view addSubview:self.starDrawView];
    self.starDrawView.selectIndex = 1.75;
    
    
//    UIView * viewBg = [UIView new];
//    viewBg.backgroundColor = UIColor.redColor;
//    viewBg.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    [self.view addSubview:viewBg];
//    [viewBg bt_addTopToParent];
//    [viewBg bt_addLeftToParent];
//    [viewBg bt_addWidth:100];
//    [viewBg bt_addHeight:100];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [viewBg removeConstraints:viewBg.constraints];
//        [viewBg bt_addToParentWithPadding:BTPaddingMake(10, -30, 100, -200)];
//    });
    
//    UIStackView * stackView = [[UIStackView alloc] initWithArrangedSubviews:<#(nonnull NSArray<__kindof UIView *> *)#>]
    
    BTNumAnimView * animView = [[BTNumAnimView alloc] initWithFrame:CGRectMake(0, 150, 50, 50) color:UIColor.redColor font:[UIFont systemFontOfSize:34]];
    animView.BTBorderColor = UIColor.redColor;
    animView.BTBorderWidth = 1;
    animView.BTCorner = 4;
    [self.view addSubview:animView];
    [animView startAnimTo:1 time:3];
    
}



@end
