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
#import "BTWidgetView.h"

@interface BTSearchHeadView()<UITextFieldDelegate>



@end


@implementation BTSearchHeadView

- (instancetype)initSearchHead{
    self = [super initWithFrame:CGRectMake(0, 0, BTUtils.SCREEN_W, BTUtils.NAV_HEIGHT)];
    
    self.backgroundColor = UIColor.whiteColor;
    
    self.btnCancel = [[UIButton alloc]initWithSize:CGSizeMake(60, 44)];
    [self.btnCancel setTitleColor:UIColor.lightGrayColor forState:UIControlStateNormal];
    [self.btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    self.btnCancel.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    [self.btnCancel addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.viewBgColor = [[UIView alloc] init];
    self.viewBgColor.backgroundColor = [BTUtils RGBA:239 G:239 B:241 A:1];
    
    self.imgSearchIcon = [[UIImageView alloc] initWithEqualSize:28];
    self.imgSearchIcon.image = [BTWidgetView imageBundleName:@"bt_search_icon"];
    self.imgSearchIcon.contentMode = UIViewContentModeCenter;
    
    self.viewLine = [[BTLineView alloc] initWithSize:CGSizeMake(self.width, 1)];
    self.viewLine.lineWidth = .5;
    self.viewLine.aligntMent = BTLineViewAlignmentBottom;
    self.viewLine.color = UIColor.lightGrayColor;
    
    
    self.textFieldSearch = [[BTTextField alloc] init];
    self.textFieldSearch.returnKeyType = UIReturnKeySearch;
    self.textFieldSearch.placeholder = @"请输入搜索内容";
    self.textFieldSearch.delegate = self;
    self.textFieldSearch.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
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
    self.viewBgColor.corner = 16;
    
    self.imgSearchIcon.left = self.viewBgColor.left + 8;
    self.imgSearchIcon.centerY = self.viewBgColor.centerY;
    
    self.textFieldSearch.frame = CGRectMake(self.imgSearchIcon.right + 2, self.viewBgColor.top, self.viewBgColor.right - self.imgSearchIcon.right - 2, self.viewBgColor.height);
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (self.searchClick) {
        self.searchClick(self.textFieldSearch.text);
    }
    self.textFieldSearch.text=@"";
    return YES;
}


- (void)cancelClick{
    if (self.cancelClickBlock) {
        self.cancelClickBlock();
    }
}

@end
