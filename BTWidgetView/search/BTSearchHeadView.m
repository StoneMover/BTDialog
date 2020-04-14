//
//  BTSearchHeadView.m
//  BTWidgetViewExample
//
//  Created by apple on 2020/4/14.
//  Copyright © 2020 stone. All rights reserved.
//

#import "BTSearchHeadView.h"
#import "UIView+BTViewTool.h"
#import <BTHelp/BTUtils.h>

@implementation BTSearchHeadView

- (instancetype)initSearchHead{
    self = [super initWithFrame:CGRectMake(0, 0, BTUtils.SCREEN_W, BTUtils.UI_IS_IPHONEX?88:44)];
    self.btnCancel = [[UIButton alloc]initWithSize:CGSizeMake(60, 44)];
    [self.btnCancel addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.viewBgColor = [[UIView alloc] init];
    self.viewBgColor.backgroundColor = [BTUtils RGBA:239 G:239 B:241 A:1];
    
    self.imgSearchIcon = [[UIImageView alloc] initWithEqualSize:28];
    self.imgSearchIcon.image = [UIImage imageNamed:@"bt_search_icon"];
    self.imgSearchIcon.contentMode = UIViewContentModeScaleAspectFill;
    
    self.viewLine = [[BTLineView alloc] initWithSize:CGSizeMake(self.width, 1)];
    self.viewLine.lineWidth = .5;
    self.viewLine.color = UIColor.lightGrayColor;
    
    self.textFieldSearch = [[BTTextField alloc] init];
    self.textFieldSearch.placeholder = @"请输入搜索内容";
    self.textFieldSearch.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.textFieldSearch addDoneView];
    
    [self addSubViewArray:@[self.btnCancel,self.viewBgColor,self.imgSearchIcon,self.viewLine,self.textFieldSearch]];
    
    return self;
}

- (void)layoutSubviews{
    self.viewLine.frame = CGRectMake(0, self.height - 1, self.width, 1);
    
    self.btnCancel.right = self.width;
    self.btnCancel.bottom = self.viewLine.top;
    
    self.viewBgColor.left = 8;
    self.viewBgColor.frame = CGRectMake(8, self.height - 32 - 6, self.btnCancel.left - 8, 32);
    
    self.imgSearchIcon.left = self.viewBgColor.left + 8;
    self.imgSearchIcon.centerY = self.viewBgColor.centerY;
    
    self.textFieldSearch.frame = CGRectMake(self.imgSearchIcon.right + 2, self.viewBgColor.top, self.viewBgColor.right - self.imgSearchIcon.right - 2, self.viewBgColor.height);
    
    
}

- (void)cancelClick{
    if (self.cancelClickBlock) {
        self.cancelClickBlock();
    }
}

@end
