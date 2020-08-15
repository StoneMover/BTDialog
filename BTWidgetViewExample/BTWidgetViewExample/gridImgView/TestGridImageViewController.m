//
//  TestGridImageViewController.m
//  BTWidgetViewExample
//
//  Created by apple on 2020/6/19.
//  Copyright © 2020 stone. All rights reserved.
//

#import "TestGridImageViewController.h"
#import "BTGridImgView.h"
#import <BTHelp/BTUtils.h>
#import "UIView+BTViewTool.h"
#import <BTHelp/BTIconHelp.h>
#import "BTAlertLabelView.h"
#import "UIView+BTEasyDialog.h"

@interface TestGridImageViewController ()<BTGridImgViewDelegate>

@property (nonatomic, strong) BTGridImgView * gridImgView;

@property (nonatomic, strong) BTIconHelp * iconHelp;

@end

@implementation TestGridImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self initGridView];
    
}

- (void)initGridView{
    self.gridImgView = [[BTGridImgView alloc] initWithFrame:CGRectMake(20, 20, BTUtils.SCREEN_W - 40, 0)];
    self.gridImgView.line = 3;
    self.gridImgView.maxNumber = 9;
    self.gridImgView.space = 10;
    self.gridImgView.addImg = [UIImage imageNamed:@"add"];
    
    self.gridImgView.dataArray = [NSMutableArray new];
    self.gridImgView.BTHeight = self.gridImgView.contentHeight;
    self.gridImgView.delegate = self;
    
    [self.view addSubview:self.gridImgView];
    [self.gridImgView reloadData];
}

//点击照片，你可以做一些自己的交互，比如进入详情展示
- (void)BTGridImgViewClick:(NSInteger)index{
    
}

//进行你自己的照片添加逻辑
- (void)BTGridImgAddClick{
    __weak TestGridImageViewController * weakSelf=self;
    if (!self.iconHelp) {
        self.iconHelp = [[BTIconHelp alloc] init:self];
        self.iconHelp.block = ^(UIImage *image) {
            [weakSelf.gridImgView.dataArray addObject:image];
            weakSelf.gridImgView.BTHeight = weakSelf.gridImgView.contentHeight;
            [weakSelf.gridImgView reloadData];
        };
    }
    
    [self.iconHelp go];
}

//长按照片，你可以做一些自己的交互，比如提示是否删除
- (void)BTGridImgLongPress:(NSInteger)index{
    BTAlertLabelView * alert = [[BTAlertLabelView alloc] initWithTitle:@"提示" msg:@"是否删除?"];
    [alert showCenter];
    alert.okBlock = ^BOOL{
        [self.gridImgView removeDataAtIndex:index];
        self.gridImgView.BTHeight = self.gridImgView.contentHeight;
        [self.gridImgView reloadData];
        return YES;
    };
}

//如果你的dataArray数组中的对象不全是UIImage对戏，那么在这里进行imageView的赋值
- (void)BTGridLoadImg:(NSInteger)index imgView:(UIImageView*)imgView{
    
}

@end
