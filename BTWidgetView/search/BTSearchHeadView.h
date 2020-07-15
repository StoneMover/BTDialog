//
//  BTSearchHeadView.h
//  BTWidgetViewExample
//
//  Created by apple on 2020/4/14.
//  Copyright © 2020 stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTLineView.h"
#import "BTTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface BTSearchHeadView : UIView

- (instancetype)initNavHead;

- (instancetype)initDefaultHead;

@property (nonatomic, strong) UIImageView * imgSearchIcon;

//取消按钮，设置显示隐藏即可改变相应的布局
@property (nonatomic, strong) UIButton * btnCancel;

@property (nonatomic, strong) BTTextField * textFieldSearch;

@property (nonatomic, strong) BTLineView * viewLine;

@property (nonatomic, strong) UIView * viewBgColor;

@property (nonatomic, copy) void(^cancelClickBlock)(void);

@property (nonatomic, copy) void(^searchClick) (NSString * _Nullable  searchStr);

//是否在点击搜索按钮的时候情况输入框内容
@property (nonatomic, assign) BOOL isSearchClickEmptyTextField;

@end

NS_ASSUME_NONNULL_END
