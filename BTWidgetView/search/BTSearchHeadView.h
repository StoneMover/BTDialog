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

- (instancetype)initSearchHead;

@property (nonatomic, strong) UIImageView * imgSearchIcon;

@property (nonatomic, strong) UIButton * btnCancel;

@property (nonatomic, strong) BTTextField * textFieldSearch;

@property (nonatomic, strong) BTLineView * viewLine;

@property (nonatomic, strong) UIView * viewBgColor;

@property (nonatomic, copy) void(^cancelClickBlock)(void);

@property (nonatomic, copy) void(^searchClick) (NSString * _Nullable  searchStr);

@end

NS_ASSUME_NONNULL_END
