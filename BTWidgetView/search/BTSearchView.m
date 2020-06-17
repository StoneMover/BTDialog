//
//  BTSearchView.m
//  BTWidgetViewExample
//
//  Created by apple on 2020/4/14.
//  Copyright © 2020 stone. All rights reserved.
//

#import "BTSearchView.h"
#import "UIView+BTViewTool.h"

@interface BTSearchView()

@property (nonatomic, strong) UIButton * btnCancel;

@end


@implementation BTSearchView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor=[UIColor colorWithWhite:0 alpha:.5];
    __weak BTSearchView * weakSelf=self;
    self.viewHead = [[BTSearchHeadView alloc] initSearchHead];
    self.viewHead.cancelClickBlock = ^{
        [weakSelf dismiss];
    };
    self.viewHead.searchClick = ^(NSString * _Nonnull searchStr) {
        if (weakSelf.searchResult) {
            weakSelf.searchResult(searchStr);
        }
    };
//    self.viewHead.btnCancel.hidden = YES;
    
    self.btnCancel = [[UIButton alloc] init];
    [self.btnCancel addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubViewArray:@[self.viewHead,self.btnCancel]];
    return self;
}

- (void)layoutSubviews{
    self.btnCancel.frame = CGRectMake(0, self.viewHead.bottom, self.width, self.height - self.viewHead.height);
}

- (void)show:(UIView*)view{
    self.frame = view.bounds;
    [view addSubview:self];
    [self.viewHead.textFieldSearch becomeFirstResponder];
}

- (void)dismiss{
    self.viewHead.textFieldSearch.text = @"";
    [self removeFromSuperview];
}

@end
