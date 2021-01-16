//
//  BTAlertView.m
//  word
//
//  Created by liao on 2019/12/21.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "BTAlertView.h"
#import "UIView+BTViewTool.h"
#import "UIView+BTEasyDialog.h"
#import <BTHelp/UIImage+BTImage.h>
#import <BTHelp/UIColor+BTColor.h>
#import <BTHelp/BTUtils.h>
#import "UIFont+BTFont.h"

@interface BTAlertView()

@property (nonatomic, strong) UIVisualEffectView * effectView;

@end


@implementation BTAlertView

- (instancetype)initWithcontentView:(UIView*)contentView{
    self = [super initWithFrame:CGRectMake(0, 0, BTUtils.SCREEN_W-106, contentView.BTHeight+88)];
    self.contentView = contentView;
    [self initSelf];
    return self;
}

- (void)initSelf{
    self.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:.8];
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    self.effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    [self.effectView setAlpha:.5];
    [self addSubview:self.effectView];
    
    self.contentView.backgroundColor = UIColor.clearColor;
    
    self.layer.cornerRadius = 12;
    self.clipsToBounds = YES;
    
    self.labelTitle = [UILabel new];
    self.labelTitle.textColor = [UIColor bt_RGBSame:5];
    self.labelTitle.numberOfLines = 1;
    self.labelTitle.font = [UIFont BTAutoFontWithSize:19 weight:UIFontWeightMedium];
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    self.labelTitle.text = @"标题";
    
    self.btnCancel = [[UIButton alloc] init];
    self.btnCancel.titleLabel.font = [UIFont BTAutoFontWithSize:17 weight:UIFontWeightMedium];
    [self.btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [self.btnCancel setTitleColor:[UIColor bt_RGBSame:19] forState:UIControlStateNormal];
    [self.btnCancel addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self.btnCancel setBackgroundImage:[UIImage bt_imageWithColor:[UIColor bt_RGBSame:219] size:CGSizeMake(100, 100)] forState:UIControlStateHighlighted];
    
    self.btnOk = [[UIButton alloc] init];
    self.btnOk.titleLabel.font = [UIFont BTAutoFontWithSize:17 weight:UIFontWeightMedium];
    [self.btnOk setTitle:@"确定" forState:UIControlStateNormal];
    [self.btnOk setBackgroundImage:[UIImage bt_imageWithColor:[UIColor bt_RGBSame:219] size:CGSizeMake(100, 100)] forState:UIControlStateHighlighted];
    [self.btnOk setTitleColor:UIColor.systemBlueColor forState:UIControlStateNormal];
    [self.btnOk addTarget:self action:@selector(okClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.viewLineHoz = [UIView new];
    self.viewLineHoz.backgroundColor = [UIColor bt_RGBASame:77 A:0.25];
    
    
    self.viewLineVertical = [UIView new];
    self.viewLineVertical.backgroundColor = [UIColor bt_RGBASame:77 A:0.25];
    
    
    [self bt_addSubViewArray:@[self.labelTitle,self.contentView,self.btnCancel,self.btnOk,self.viewLineVertical,self.viewLineHoz]];
    
}

- (void)layoutSubviews{
    self.effectView.frame = self.bounds;
    self.labelTitle.frame = CGRectMake(10, 18, self.BTWidth-20, 24);
    self.contentView.frame = CGRectMake(0, self.labelTitle.BTBottom, self.BTWidth, self.contentView.BTHeight);
    if (self.isJustOkBtn) {
        self.btnCancel.hidden = YES;
        self.viewLineVertical.hidden = YES;
        self.btnOk.frame = CGRectMake(0, self.BTHeight-46, self.BTWidth, 46);
        self.viewLineHoz.frame = CGRectMake(0, self.btnOk.BTTop, self.BTWidth, .5);
    }else{
        self.btnCancel.hidden = NO;
        self.viewLineVertical.hidden = NO;
        self.btnCancel.frame = CGRectMake(0, self.BTHeight-46, self.BTWidth/2.0, 46);
        self.btnOk.frame = CGRectMake(self.btnCancel.BTRight, self.btnCancel.BTTop, self.btnCancel.BTWidth, self.btnCancel.BTHeight);
        self.viewLineHoz.frame = CGRectMake(0, self.btnOk.BTTop, self.BTWidth, .5);
        self.viewLineVertical.frame = CGRectMake(self.btnCancel.BTRight, self.btnCancel.BTTop, .5, self.btnCancel.BTHeight);
    }
}

- (void)cancelClick{
    if (!self.cancelBlock) {
        [self.bt_dialogView dismiss];
        return;
    }
    
    if (self.cancelBlock()) {
        [self.bt_dialogView dismiss];
    }
}

- (void)okClick{
    if (!self.okBlock) {
        [self.bt_dialogView dismiss];
        return;
    }
    
    if (self.okBlock()) {
        [self.bt_dialogView dismiss];
    }
}

- (void)setIsJustOkBtn:(BOOL)isJustOkBtn{
    _isJustOkBtn = isJustOkBtn;
    [self layoutSubviews];
}



@end
