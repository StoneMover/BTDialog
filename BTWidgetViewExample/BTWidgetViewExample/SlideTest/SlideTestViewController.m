//
//  SlideTestViewController.m
//  BTWidgetViewExample
//
//  Created by apple on 2020/5/8.
//  Copyright © 2020 stone. All rights reserved.
//

#import "SlideTestViewController.h"
#import "BTSlideView.h"
#import <BTHelp/BTUtils.h>

@interface SlideTestViewController ()

@end

@implementation SlideTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    UIButton * btn =[[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = UIColor.redColor;
    [btn setTitle:@"点我" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


- (void)click{
    UIView * viewBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BTUtils.SCREEN_W - 150, BTUtils.SCREEN_H)];
    viewBg.backgroundColor = UIColor.redColor;
    
    BTSlideView * slideView = [[BTSlideView alloc] initWithSlideView:viewBg style:BTSlideStyleRight];
    [slideView show:BTUtils.APP_WINDOW];
}


@end
