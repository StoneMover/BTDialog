//
//  StarTestViewController.m
//  BTWidgetViewExample
//
//  Created by apple on 2020/12/7.
//  Copyright © 2020 stone. All rights reserved.
//

#import "StarTestViewController.h"
#import "BTStarView.h"

@interface StarTestViewController ()

@property (nonatomic, strong) BTStarView * starDrawView;

@end

@implementation StarTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"StarView";
    self.starDrawView = [[BTStarView alloc] initDrawStarWithNum:5 size:50 selectColor:UIColor.redColor normalColor:nil];
    self.starDrawView.frame = CGRectMake(0, 100, self.starDrawView.calculateWidth, 50);
    [self.view addSubview:self.starDrawView];
    self.starDrawView.selectIndex = 1.75;
    
}



@end
