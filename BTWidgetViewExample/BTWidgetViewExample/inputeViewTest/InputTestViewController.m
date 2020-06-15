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
#import <BTHelp/BTUtils.h>
#import "UIView+BTViewTool.h"
#import "BTTextField.h"

@interface InputTestViewController ()<BTTextInputToolViewDelegate>

@property (nonatomic, strong) BTTextInputView * inputView;

@property (nonatomic, strong) BTTextInputToolView * toolView;

@property (nonatomic, strong) BTRecordVoiceView * recoardView;

@property (weak, nonatomic) IBOutlet BTTextField *textField;
@end

@implementation InputTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(self.textField.left, self.textField.bottom + 20, self.textField.width, 40)];
    btn.corner = 5;
    btn.borderColor = UIColor.redColor;
    btn.borderWidth = 0.5;
    [btn setTitle:@"显示简单的评论输入框" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showInput) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    self.toolView = [[BTTextInputToolView alloc] initWithFrame:CGRectMake(0, BTUtils.SCREEN_H - BTUtils.NAV_HEIGHT - 56, BTUtils.SCREEN_W, 56) type:BTTextInputViewTypeAll];
    self.toolView.voiceImg = [UIImage imageNamed:@"voice"];
    self.toolView.delegate = self;
    self.toolView.keyboardImg = [UIImage imageNamed:@"keyboard"];
    [self.toolView setDefaultStatus];
    [self.view addSubview:self.toolView];
 
    
    self.recoardView = [BTRecordVoiceView loadInstanceFromNib];
}

- (void)showInput{
    self.inputView = [[BTTextInputView alloc]initWithFrame:UIScreen.mainScreen.bounds];
    [self.view addSubview:self.inputView];
    [self.inputView show:((AppDelegate*)UIApplication.sharedApplication.delegate).window];
}

- (void)viewDidLayoutSubviews{
    
}

- (void)initTextField{
    self.textField = [[BTTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    self.textField.maxCursorH = 10;
    self.textField.maxContent = 11;
    self.textField.kern = 3;
    self.textField.placeHolderFontSize = 18;
    self.textField.maxContentBlock = ^{
        
    };
    self.textField.changeBlock = ^{
        
    };
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
