//
//  TestContentAutoViewController.m
//  BTWidgetViewExample
//
//  Created by apple on 2020/6/19.
//  Copyright © 2020 stone. All rights reserved.
//

#import "TestContentAutoViewController.h"
#import "BTSearchHeadView.h"
#import "BTContentAutoView.h"
#import "UIView+BTViewTool.h"
#import <BTHelp/BTUtils.h>

@interface TestContentAutoViewController ()

@property (nonatomic, strong) BTSearchHeadView * headView;

@property (nonatomic, strong) BTContentAutoView * contentView;

@end

@implementation TestContentAutoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self initHeadView];
    [self initHistoryView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)initHeadView{
    __weak TestContentAutoViewController * weakSelf=self;
    self.headView = [[BTSearchHeadView alloc] initSearchHead];
    self.headView.viewLine.backgroundColor = UIColor.lightTextColor;
    self.headView.cancelClickBlock = ^{
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    };
    [self.view addSubview:self.headView];
}


- (void)initHistoryView{
    
    
    
    __weak TestContentAutoViewController * weakSelf=self;
    NSArray * data = @[@"雪花飘飘",@"我是一只小小鸟",@"阿瓦大啃大瓜",@"君威GS",@"迈锐宝XL",@"蒙迪欧",@"标志内饰最好看",@"张翼德",@"关云长",@"我的马儿",@"曹孟德",@"许攸辱我"];
    
    self.contentView = [[BTContentAutoView alloc] initWithFrame:CGRectMake(10, self.headView.bottom + 20, BTUtils.SCREEN_W - 20, 400)];
    self.contentView.textColor = UIColor.whiteColor;
    self.contentView.textFont = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
    self.contentView.paddingLeftRight = 7;
    self.contentView.textBgColor = UIColor.redColor;
    self.contentView.contentHSpace = 15;
    self.contentView.blockClick = ^(NSInteger index) {
        weakSelf.headView.textFieldSearch.text = data[index];
    };
    
    self.contentView.block = ^(CGFloat resultH) {
        
    };
    
    
    [self.contentView setData:data];
    [self.view addSubview:self.contentView];
}


@end
