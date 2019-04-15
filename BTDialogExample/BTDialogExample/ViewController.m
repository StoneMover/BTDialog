//
//  ViewController.m
//  BTDialogExample
//
//  Created by stonemover on 2019/4/2.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "ViewController.h"
#import "BTDialogView.h"
#import "BTDialogTableView.h"

@interface ViewController ()

@property (nonatomic, strong) UIView * viewCustomer;


@property (nonatomic, strong) BTDialogView * dialogView;

@property (nonatomic, strong) BTDialogTableView * dialogTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

- (IBAction)click:(id)sender {
//    if (self.viewCustomer) {
//        [self.dialogView show:self.view withAnimStyle:BTDialogAnimStyleAndroid];
//        return;
//    }
//    self.viewCustomer=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-100, 300)];
//    self.viewCustomer.backgroundColor=[UIColor redColor];
//
//    self.dialogView=[[BTDialogView alloc] init:self.viewCustomer withLocation:BTDialogLocationCenter];
//    self.dialogView.clickEmptyAreaDismiss=YES;
//    [self.dialogView show:self.view withAnimStyle:BTDialogAnimStyleAndroid];
    
    
    if (!self.dialogTableView) {
        self.dialogTableView=[[BTDialogTableView alloc] initDialogTableView:BTDialogLocationBottom];
        self.dialogTableView.data=[self.dialogTableView createDataWithStr:@[@"Jack",@"Lily",@"Sam",@"James"]];
        self.dialogTableView.headView.labelTitle.text=@"选择你的朋友";
        self.dialogTableView.headView.lineView.color=[UIColor redColor];
        self.dialogTableView.blockTable = ^BOOL(NSInteger index) {
            return YES;
        };
        self.dialogTableView.isNeedHead=YES;
    }
    [self.dialogTableView show:self.view];
}

@end
