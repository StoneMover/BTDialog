//
//  PageChildVcViewController.m
//  BTWidgetViewExample
//
//  Created by zanyu on 2019/8/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import "PageChildVcViewController.h"
#import <BTHelp/BTUtils.h>
#import <BTHelp/UIColor+BTColor.h>

@interface PageChildVcViewController ()

@end

@implementation PageChildVcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad:%ld",self.index);
    self.view.backgroundColor=UIColor.whiteColor;
    UILabel * label =[[UILabel alloc] initWithFrame:self.view.bounds];
    label.font=[UIFont systemFontOfSize:146 weight:UIFontWeightBold];
    label.text=[NSString stringWithFormat:@"%ld",self.index];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=UIColor.bt_RANDOM_COLOR;
    label.backgroundColor=UIColor.bt_RANDOM_COLOR;
    label.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:label];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear:%ld",self.index);
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear:%ld",self.index);
}

@end
