//
//  BTAlertTextView.m
//  BTWidgetViewExample
//
//  Created by liao on 2019/12/28.
//  Copyright © 2019 stone. All rights reserved.
//

#import "BTAlertTextView.h"
#import <BTHelp/BTUtils.h>
#import "UIView+BTViewTool.h"
#import <BTHelp/UIColor+BTColor.h>
#import "UIFont+BTFont.h"



@implementation BTAlertTextView

- (instancetype)initWithContent:(NSString*)content placeholder:(NSString*)placeholder{
    return [self initWithContent:content placeholder:placeholder height:150];
}

- (instancetype)initWithContent:(NSString*)content placeholder:(NSString*)placeholder height:(CGFloat)height{
    
    BTTextView * textView = [[BTTextView alloc] initWithFrame:CGRectMake(15, 10, BTUtils.SCREEN_W-106-30, height)];
    textView.text = content;
    textView.placeHolder = placeholder;
    textView.isSelfSetEdgeInsets = YES;
    textView.textContainerInset=UIEdgeInsetsMake(5, 5, 5, 5);
    textView.textColor = [UIColor bt_RGBSame:10];
    textView.font = [UIFont BTAutoFontWithSize:16 weight:UIFontWeightMedium];
    textView.BTBorderColor = [UIColor bt_RGBASame:77 A:0.25];
    textView.BTBorderWidth = 0.5;
    textView.BTCorner = 5;
    
    UIView * viewRoot = [[UIView alloc] initBTViewWithSize:CGSizeMake(BTUtils.SCREEN_W-106, height+30)];
    [viewRoot addSubview:textView];

    self= [super initWithcontentView:viewRoot];

    self.labelTitle.text = @"请输入内容";
    self.textView = textView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];
    });
    return self;
}

- (void)setIsJustShowText:(BOOL)isJustShowText{
    _isJustShowText = isJustShowText;
    if (isJustShowText) {
        self.textView.editable = NO;
        self.textView.BTBorderWidth = 0;
        self.textView.BTCorner = 0;
        self.textView.backgroundColor = UIColor.clearColor;
    }else{
        self.textView.editable = YES;
        self.textView.BTBorderColor = [UIColor bt_RGBASame:77 A:0.78];
        self.textView.BTBorderWidth = 0.5;
        self.textView.BTCorner = 5;
        self.textView.backgroundColor = UIColor.whiteColor;
    }
}

@end
