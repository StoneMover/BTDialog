//
//  SearchHeadView.h
//  BTWidgetViewExample
//
//  Created by apple on 2020/4/3.
//  Copyright © 2020 stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTLineView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchHeadView : UIView

@property (nonatomic, strong) UIImage * imgSearchIcon;

@property (nonatomic, strong) UIButton * btnCancel;

@property (nonatomic, strong) UITextField * textFieldSearch;

@property (nonatomic, strong) BTLineView * viewLine;

@end

NS_ASSUME_NONNULL_END
