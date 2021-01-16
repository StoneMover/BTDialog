//
//  BTAlertLabelView.m
//  BTWidgetViewExample
//
//  Created by liao on 2019/12/27.
//  Copyright © 2019 stone. All rights reserved.
//

#import "BTAlertLabelView.h"
#import <BTHelp/BTUtils.h>
#import "UIView+BTViewTool.h"
#import <BTHelp/UIColor+BTColor.h>
#import "UILabel+BTLabel.h"
#import "UIFont+BTFont.h"

@implementation BTAlertLabelView

- (instancetype)initWithTitle:(NSString*)title msg:(NSString*)msg{
    UILabel * labelContent = [UILabel new];
    labelContent.textAlignment = NSTextAlignmentCenter;
    labelContent.font = [UIFont BTAutoFontWithSize:16 weight:UIFontWeightMedium];
    labelContent.textColor = [UIColor bt_RGBSame:5];
    labelContent.text = msg;
    labelContent.numberOfLines = 0;
    labelContent.backgroundColor = UIColor.clearColor;
    labelContent.BTWidth = BTUtils.SCREEN_W-106-40;
    CGFloat labelHeight = labelContent.bt_calculateLabelHeight;
    labelContent.BTHeight = labelHeight;
    labelContent.BTLeft = 20;
    labelContent.BTTop = 15;
    UIView * viewRoot = [[UIView alloc] initBTViewWithSize:CGSizeMake(BTUtils.SCREEN_W-106, labelHeight+35)];
    [viewRoot addSubview:labelContent];
    self= [super initWithcontentView:viewRoot];
    
    self.labelContent = labelContent;
    self.labelTitle.text = title;
    
    return self;
}

@end