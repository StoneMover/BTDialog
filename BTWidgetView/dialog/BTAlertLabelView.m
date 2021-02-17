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
#import <BTHelp/NSString+BTString.h>

@implementation BTAlertLabelView

- (instancetype)initWithTitle:(NSString*)title msg:(NSString*)msg{
    return [self initWithTitle:title msg:msg msgFont:[UIFont BTAutoFontWithSize:16 weight:UIFontWeightMedium] lineSpeace:2];
}

- (instancetype)initWithTitle:(NSString*)title msg:(NSString*)msg msgFont:(UIFont*)font lineSpeace:(CGFloat)lineSpeace{
    UILabel * labelContent = [UILabel new];
    labelContent.textAlignment = NSTextAlignmentCenter;
    labelContent.font = font;
    labelContent.textColor = [UIColor bt_RGBSame:5];
    labelContent.text = msg;
    labelContent.numberOfLines = 0;
    labelContent.backgroundColor = UIColor.clearColor;
    labelContent.BTWidth = BTUtils.SCREEN_W-106-40;
    CGFloat labelHeight = [msg bt_calculateStrHeight:labelContent.BTWidth font:font lineSpeace:lineSpeace];
    labelContent.BTHeight = labelHeight;
    labelContent.BTLeft = 20;
    labelContent.BTTop = 15;
    UIView * viewRoot = [[UIView alloc] initBTViewWithSize:CGSizeMake(BTUtils.SCREEN_W-106, labelHeight+35)];
    [viewRoot addSubview:labelContent];
    self= [super initWithcontentView:viewRoot];
    
    self.labelContent = labelContent;
    [self.labelContent bt_setText:msg lineSpacing:lineSpeace];
    self.labelTitle.text = title;
    return self;
}

@end
