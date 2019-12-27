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

@implementation BTAlertTextFieldView

- (instancetype)initWithContent:(NSString*)content placeholder:(NSString*)placeholder{
    
    BTTextField * textField = [[BTTextField alloc] initWithFrame:CGRectMake(5, 0, BTUtils.SCREEN_W-106-30, 42)];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.text = content;
    textField.placeholder = placeholder;
    
    UIView * viewParent = [[UIView alloc] initWithSize:CGSizeMake(BTUtils.SCREEN_W-106-20, 42)];
    viewParent.borderColor = [BTUtils RGBA:77 G:77 B:77 A:.78];
    viewParent.borderWidth = 0.5;
    viewParent.corner = 5;
    [viewParent addSubview:textField];
    viewParent.top = 15;
    viewParent.left = 10;
    
    UIView * viewRoot = [[UIView alloc] initWithSize:CGSizeMake(BTUtils.SCREEN_W-106, 45+30)];
    [viewRoot addSubview:viewParent];
    
    self= [super initWithcontentView:viewRoot];
    
    self.textField = textField;
    self.labelTitle.text = @"请输入内容";
    [self.textField becomeFirstResponder];
    return self;
}

@end
