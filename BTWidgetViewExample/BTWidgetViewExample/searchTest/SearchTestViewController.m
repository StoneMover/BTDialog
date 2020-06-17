//
//  SearchTestViewController.m
//  BTWidgetViewExample
//
//  Created by liao on 2020/4/14.
//  Copyright © 2020 stone. All rights reserved.
//

#import "SearchTestViewController.h"
#import "BTSearchView.h"

@interface SearchTestViewController ()

@end

@implementation SearchTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIButton * btn =[[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    btn.backgroundColor = UIColor.redColor;
    [btn setTitle:@"search" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)btnClick{
    BTSearchView * view = [[BTSearchView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    view.viewHead.btnCancel.hidden = YES;
    view.searchResult = ^(NSString * _Nullable searchStr) {
        
    };
    [view show:UIApplication.sharedApplication.delegate.window];
}


@end
