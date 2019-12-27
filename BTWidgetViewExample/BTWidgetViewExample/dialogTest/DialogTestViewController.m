//
//  DialogTestViewController.m
//  BTWidgetViewExample
//
//  Created by liao on 2019/12/27.
//  Copyright © 2019 stone. All rights reserved.
//

#import "DialogTestViewController.h"
#import "BTAlertView.h"
#import "UIView+BTEasyDialog.h"
#import "BTAlertLabelView.h"
#import "BTAlertTextFieldView.h"

@interface DialogTestViewController ()

@end

@implementation DialogTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"BTDialogView&BTAlertView";
}

- (IBAction)alertViewClick:(id)sender {
    
    UIView * viewShow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    UILabel * label = [[UILabel alloc] init];
    label.text = @"我是一个自定义的View";
    [label sizeToFit];
    [viewShow addSubview:label];
    
    BTAlertView * alertView = [[BTAlertView alloc] initWithcontentView:viewShow];
    [alertView showCenter];
    
}

- (IBAction)alertLabelViewClick:(id)sender {
    BTAlertLabelView * labelView = [[BTAlertLabelView alloc] initWithTitle:@"关张马黄赵传第六" msg:@"因战乱逃亡到涿郡。刘备在家乡招集兵马，关羽和张飞担任他的护卫。刘备任平原国国相后，任关羽、张飞为别部司马，分管所辖军队。刘备与关、张二人连睡觉都同一张床 ，亲如同胞兄弟。关、张二人在大庭广众之中，整日侍立在刘备身旁，跟随刘备对敌作战，从不惧避艰险。刘备袭击徐州杀死刺史车胄后，即让关羽镇守下邳城，代行太守职务，自己则率军回驻小沛。"];
    [labelView showCenter];
}
- (IBAction)alertFieldClick:(id)sender {
    BTAlertTextFieldView * fieldView = [[BTAlertTextFieldView alloc] initWithContent:@"刘备任平原国国相后，任关羽" placeholder:@"来看三国呗"];
    [fieldView showCenter].isNeedMoveFollowKeyboard = YES;
    
}

@end
