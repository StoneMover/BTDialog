//
//  InputTestViewController.m
//  BTWidgetViewExample
//
//  Created by apple on 2020/6/8.
//  Copyright © 2020 stone. All rights reserved.
//

#import "InputTestViewController.h"
#import "BTTextInputView.h"
#import "AppDelegate.h"
#import "UIView+BTViewTool.h"
#import "BTRecordVoiceView.h"
#import "UIView+BTEasyDialog.h"
#import <BTHelp/BTPermission.h>

@interface InputTestViewController ()<BTTextInputToolViewDelegate>

@property (nonatomic, strong) BTTextInputView * inputView;

@property (nonatomic, strong) BTTextInputToolView * toolView;

@property (nonatomic, strong) BTRecordVoiceView * recoardView;

@end

@implementation InputTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.inputView = [[BTTextInputView alloc]initWithFrame:UIScreen.mainScreen.bounds];
    [self.view addSubview:self.inputView];
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 30)];
    [btn setTitle:@"显示" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showInput) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    self.toolView = [[BTTextInputToolView alloc] initWithFrame:CGRectMake(0, 500, self.view.width, 56) type:BTTextInputViewTypeAll];
    self.toolView.voiceImg = [UIImage imageNamed:@"voice"];
    self.toolView.delegate = self;
    self.toolView.keyboardImg = [UIImage imageNamed:@"keyboard"];
    [self.toolView setDefaultStatus];
    [self.view addSubview:self.toolView];
 
    
    self.recoardView = [BTRecordVoiceView loadInstanceFromNib];
}

- (void)showInput{
    [self.inputView show:((AppDelegate*)UIApplication.sharedApplication.delegate).window];
}

- (void)viewDidLayoutSubviews{
    
}

//MARK: BTTextInputToolViewDelegate
- (void)BTTextInputToolViewStart:(BTTextInputToolView *)view{
    self.recoardView.label.text = @"松开发送";
    [self.recoardView showCenter];
}

- (void)BTTextInputToolViewStatus:(BTTextInputToolView *)view isCancel:(BOOL)isCancel{
    if (isCancel) {
        self.recoardView.label.text = @"松开取消";
    }else{
        self.recoardView.label.text = @"松开发送";
    }
}

- (void)BTTextInputToolViewEnd:(BTTextInputToolView *)view{
    [self.recoardView.dialogView dismiss];
}

@end
