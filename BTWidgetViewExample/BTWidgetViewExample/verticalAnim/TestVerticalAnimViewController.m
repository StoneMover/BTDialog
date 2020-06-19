//
//  TestVerticalAnimViewController.m
//  BTWidgetViewExample
//
//  Created by apple on 2020/6/19.
//  Copyright © 2020 stone. All rights reserved.
//

#import "TestVerticalAnimViewController.h"
#import "BTVerticalAnimView.h"
#import "BTScrollLabelView.h"

@interface TestVerticalAnimViewController ()<BTVerticalAnimViewDelegate>

@end

@implementation TestVerticalAnimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    BTVerticalAnimView * verticalView = [[BTVerticalAnimView alloc]initWithFrame:CGRectMake(40, 40, 200, 40) padding:5 pauseTime:2];
    verticalView.delegate = self;
    verticalView.isHoz = NO;
    [verticalView reload];
    [self.view addSubview:verticalView];
    
    
    BTScrollLabelView * labelView = [[BTScrollLabelView alloc] initWithFrame:CGRectMake(40, 100, 200, 40)];
    
    labelView.type = BTScrollLabelTypeBy;
    labelView.color = UIColor.redColor;
    labelView.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    labelView.margin = 10;
    labelView.animTime = 3;
    //设置上面的属性要在设置strData之前进行
    labelView.strData = @"我是一个快乐的跑马灯，不知疲倦的漫天跑，到底是累";
    [self.view addSubview:labelView];
    //给一些延时，让界面完成布局后再开启动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [labelView start];
    });
}

- (UIView*)BTVerticalAnimView:(BTVerticalAnimView*)view viewWithIndex:(NSInteger)index{
    UILabel * label =(UILabel*) [view getCacheView];
    if (label == nil) {
        label = [[UILabel alloc] init];
        label.backgroundColor = UIColor.redColor;
    }
    label.text = [NSString stringWithFormat:@"%ld",index];
    return label;
}

- (NSInteger)BTVerticalAnimViewNumOfRows:(BTVerticalAnimView*)view{
    return 10;
}

@end
