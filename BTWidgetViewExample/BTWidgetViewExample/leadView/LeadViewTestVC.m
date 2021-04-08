//
//  LeadViewTestVC.m
//  BTWidgetViewExample
//
//  Created by apple on 2021/4/8.
//  Copyright © 2021 stone. All rights reserved.
//

#import "LeadViewTestVC.h"
#import "BTLeadView.h"
#import <BTHelp/BTUtils.h>

@interface LeadViewTestVC ()

@property (nonatomic, strong) BTLeadView * leadView;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UIButton *testBtn;



@end

@implementation LeadViewTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imgView.layer.cornerRadius = 10;
    self.testBtn.layer.cornerRadius = 5;
    
    
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self showFirstView];
}

- (void)showFirstView{
    NSArray * array = @[
        [BTLeadModel modelWithView:self.imgView type:BTLeadEmptyTypeRectangle padding:BTPaddingMake(5, 5, 5, 5)]
    ];
    self.leadView = [[BTLeadView alloc] initWithShowView:array];
    [self.leadView show];
    __weak LeadViewTestVC * weakSelf=self;
    self.leadView.dataArray[0].blockClick = ^{
        NSLog(@"点击了按钮");
        [weakSelf.leadView dismiss];
        [weakSelf showSecView];
    };
}

- (void)showSecView{
    
    NSArray * array = @[
        [BTLeadModel modelWithView:self.testBtn type:BTLeadEmptyTypeOval padding:BTPaddingMake(15, 15, 35, 35)]
    ];
    self.leadView = [[BTLeadView alloc] initWithShowView:array];
    [self.leadView show];
    __weak LeadViewTestVC * weakSelf=self;
    self.leadView.dataArray[0].blockClick = ^{
        NSLog(@"点击了按钮");
        [weakSelf.leadView dismiss];
    };
}

@end
