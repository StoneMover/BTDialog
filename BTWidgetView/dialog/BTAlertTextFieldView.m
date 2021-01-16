//
//  BTAlertTextFieldView.m
//  BTWidgetViewExample
//
//  Created by liao on 2019/12/27.
//  Copyright © 2019 stone. All rights reserved.
//

#import "BTAlertTextFieldView.h"
#import <BTHelp/BTUtils.h>
#import "UIView+BTViewTool.h"
#import <BTHelp/UIColor+BTColor.h>
#import "UIFont+BTFont.h"

@implementation BTAlertTextFieldView

- (instancetype)initWithContent:(NSString*)content placeholder:(NSString*)placeholder{
    
    BTTextField * textField = [[BTTextField alloc] initWithFrame:CGRectMake(5, 0, BTUtils.SCREEN_W-106-30, 42)];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.text = content;
    textField.placeholder = placeholder;
    textField.clipsToBounds = NO;
    textField.font = [UIFont BTAutoFontWithSize:16];
    
    UIView * viewParent = [[UIView alloc] initBTViewWithSize:CGSizeMake(BTUtils.SCREEN_W-106-20, 42)];
    viewParent.BTBorderColor = [UIColor bt_RGBASame:77 A:0.25];
    viewParent.BTBorderWidth = 0.5;
    viewParent.BTCorner = 5;
    [viewParent addSubview:textField];
    viewParent.BTTop = 15;
    viewParent.BTLeft = 10;
    
    UIView * viewRoot = [[UIView alloc] initBTViewWithSize:CGSizeMake(BTUtils.SCREEN_W-106, 45+30)];
    [viewRoot addSubview:viewParent];
    
    self= [super initWithcontentView:viewRoot];
    
    self.textField = textField;
    self.labelTitle.text = @"请输入内容";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textField becomeFirstResponder];
    });
    return self;
}

@end
