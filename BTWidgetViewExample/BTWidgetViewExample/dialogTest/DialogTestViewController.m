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
#import "BTDialogTableView.h"
#import <BTHelp/BTUtils.h>
#import "BTAlertTextView.h"

@interface DialogTestViewController ()

@end

@implementation DialogTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"BTDialogView&BTAlertView";
}


- (IBAction)dialogViewClick:(id)sender {
    UIView * viewShow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 400)];
    viewShow.backgroundColor = UIColor.redColor;
    UILabel * label = [[UILabel alloc] init];
    label.text = @"我是一个自定义的View";
    [label sizeToFit];
    [viewShow addSubview:label];
//    [viewShow showTop];
    [viewShow showCenter];
//    [viewShow showBottom];
}


- (IBAction)dialogTableViewClick:(id)sender {
    BTDialogTableView * tableView = [[BTDialogTableView alloc] initDialogTableView:BTDialogLocationCenter];
    tableView.headView.labelTitle.text = @"三国好看啊";
    tableView.miniRootHeight = 100;
    tableView.blockTable = ^BOOL(NSInteger index) {
        
        
        return YES;
    };
    [tableView createDataWithStr:@[@"刘备",@"诸葛亮",@"赵子龙",@"关羽",@"曹操"]];
    [tableView show: BTUtils.APP_WINDOW];
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
    labelView.isJustOkBtn = YES;
    [labelView showCenter];
}
- (IBAction)alertFieldClick:(id)sender {
    BTAlertTextFieldView * fieldView = [[BTAlertTextFieldView alloc] initWithContent:@"刘备任平原国国相后，任关羽" placeholder:@"来看三国呗"];
    [fieldView showCenter].isNeedMoveFollowKeyboard = YES;
    [fieldView.textField addDoneView];
    __weak BTAlertTextFieldView * weakSelf=fieldView;
    fieldView.okBlock = ^BOOL{
        NSLog(@"%@",weakSelf.textField.text);
        return YES;
    };
}

- (IBAction)alertTextViewClick:(id)sender {
    BTAlertTextView * textView = [[BTAlertTextView alloc] initWithContent:@"又被任为谯县县令，未到任。刘备统治豫州时，荐袁涣为茂才。后袁涣迁移到江 淮之间避祸，被袁术所任命。袁术每次有所咨询，袁涣常有严正的议论。袁术不能违抗，然而也不敢不有礼貌地尊敬他。不久，吕布在阜陵攻击袁术，袁涣前去随从袁术，于是也被吕布拘留。吕布当初与刘备结亲和好，后来有了嫌隙。现在，吕布想要让袁涣写信辱骂刘备，袁涣不答应，再三强迫他，仍不同意。吕布大怒，用兵器威胁袁涣说：“你做就能活，不做就得死。”袁涣脸不变色，笑着回答说：“袁涣听说只有德行才能使人蒙受耻辱，没听说用辱骂的。假使他本来就是个君子，那他将不以将军的话为耻辱，假使他本来就是个小人，那他将像将军一样写信，回骂将军，那样耻辱将在这一方而不在他那一方。况且袁涣我异日侍奉刘将军，就像现在侍奉将军您一样，如果我一旦离开这里，回过头来骂您，可以吗？”吕布感到羞惭，不再逼他。" placeholder:@"请输入你对刘备的评价"];
//    textView.isJustShowText = YES;
    [textView.textView addDoneView];
    [textView showCenter].isNeedMoveFollowKeyboard = YES;
}
@end
