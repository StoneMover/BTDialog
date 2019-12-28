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
#import <BTHelp/BTUtils.h>
#import "UIImage+BTImage.h"

@interface BTAlertView()

@property (nonatomic, strong) UIVisualEffectView * effectView;

@end


@implementation BTAlertView

- (instancetype)initWithcontentView:(UIView*)contentView{
    self = [super initWithFrame:CGRectMake(0, 0, BTUtils.SCREEN_W-106, contentView.height+88)];
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
    self.labelTitle.textColor = [BTUtils RGB:5 G:5 B:5];
    self.labelTitle.numberOfLines = 1;
    self.labelTitle.font = [UIFont systemFontOfSize:19 weight:UIFontWeightMedium];
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    self.labelTitle.text = @"标题";
    
    self.btnCancel = [[UIButton alloc] init];
    self.btnCancel.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    [self.btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [self.btnCancel setTitleColor:[BTUtils RGBA:19 G:19 B:19 A:1] forState:UIControlStateNormal];
    [self.btnCancel addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self.btnCancel setBackgroundImage:[UIImage imageWithColor:[BTUtils RGB:219 G:219 B:219] size:CGSizeMake(100, 100)] forState:UIControlStateHighlighted];
    
    self.btnOk = [[UIButton alloc] init];
    self.btnOk.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    [self.btnOk setTitle:@"确定" forState:UIControlStateNormal];
    [self.btnOk setBackgroundImage:[UIImage imageWithColor:[BTUtils RGB:219 G:219 B:219] size:CGSizeMake(100, 100)] forState:UIControlStateHighlighted];
    [self.btnOk setTitleColor:UIColor.systemBlueColor forState:UIControlStateNormal];
    [self.btnOk addTarget:self action:@selector(okClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.viewLineHoz = [UIView new];
    self.viewLineHoz.backgroundColor = [BTUtils RGBA:77 G:77 B:77 A:.78];
    
    
    self.viewLineVertical = [UIView new];
    self.viewLineVertical.backgroundColor = [BTUtils RGBA:77 G:77 B:77 A:.78];
    
    
    [self addSubViewArray:@[self.labelTitle,self.contentView,self.btnCancel,self.btnOk,self.viewLineVertical,self.viewLineHoz]];
    
}

- (void)layoutSubviews{
    self.effectView.frame = self.bounds;
    self.labelTitle.frame = CGRectMake(10, 18, self.width-20, 24);
    self.contentView.frame = CGRectMake(0, self.labelTitle.bottom, self.width, self.contentView.height);
    if (self.isJustOkBtn) {
        self.btnCancel.hidden = YES;
        self.viewLineVertical.hidden = YES;
        self.btnOk.frame = CGRectMake(0, self.height-46, self.width, 46);
        self.viewLineHoz.frame = CGRectMake(0, self.btnOk.top, self.width, .5);
    }else{
        self.btnCancel.hidden = NO;
        self.viewLineVertical.hidden = NO;
        self.btnCancel.frame = CGRectMake(0, self.height-46, self.width/2.0, 46);
        self.btnOk.frame = CGRectMake(self.btnCancel.right, self.btnCancel.top, self.btnCancel.width, self.btnCancel.height);
        self.viewLineHoz.frame = CGRectMake(0, self.btnOk.top, self.width, .5);
        self.viewLineVertical.frame = CGRectMake(self.btnCancel.right, self.btnCancel.top, .5, self.btnCancel.height);
    }
}

- (void)cancelClick{
    if (!self.cancelBlock) {
        [self.dialogView dismiss];
        return;
    }
    
    if (self.cancelBlock()) {
        [self.dialogView dismiss];
    }
}

- (void)okClick{
    if (!self.okBlock) {
        [self.dialogView dismiss];
        return;
    }
    
    if (self.okBlock()) {
        [self.dialogView dismiss];
    }
}

- (void)setIsJustOkBtn:(BOOL)isJustOkBtn{
    _isJustOkBtn = isJustOkBtn;
    [self layoutSubviews];
}



@end
