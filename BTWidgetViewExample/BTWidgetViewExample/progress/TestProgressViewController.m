//
//  TestProgressViewController.m
//  BTWidgetViewExample
//
//  Created by apple on 2020/11/23.
//  Copyright © 2020 stone. All rights reserved.
//

#import "TestProgressViewController.h"
#import "BTProgressView.h"
#import <BTHelp/UIImage+BTImage.h>
#import "UIView+BTViewTool.h"
#import "BTStarView.h"

@interface TestProgressViewController ()
@property (weak, nonatomic) IBOutlet BTProgressView *hozProgressView;

@property (weak, nonatomic) IBOutlet BTProgressView *verProgressView;

@property (weak, nonatomic) IBOutlet BTProgressView *fullProgressView;

@property (weak, nonatomic) IBOutlet BTProgressView *borderProgressView;

@property (nonatomic, strong) BTStarDrawView * drawView;

@end

@implementation TestProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ProgressView";
    self.hozProgressView.slideImgView.image = [UIImage bt_imageWithColor:UIColor.lightGrayColor size:CGSizeMake(20, 20)];
    self.hozProgressView.clipsToBounds = NO;
    self.hozProgressView.slideImgView.BTCorner = 10;
    
    self.drawView = [[BTStarDrawView alloc] initWithFrame:CGRectMake(0, 250, 150, 40)];
    self.drawView.starNumber = 3.5;
    [self.view addSubview:self.drawView];
    
}

- (IBAction)testClick:(id)sender {
    self.hozProgressView.percent += 0.1;
    self.verProgressView.percent += 0.1;
    self.fullProgressView.percent += 0.1;
    self.borderProgressView.percent += 0.1;
}

- (IBAction)testClickLess:(id)sender {
    self.hozProgressView.percent -= 0.1;
    self.verProgressView.percent -= 0.1;
    self.fullProgressView.percent -= 0.1;
    self.borderProgressView.percent -= 0.1;
}

@end
