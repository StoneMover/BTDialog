//
//  BTTextInputView.h
//  word
//
//  Created by stonemover on 2019/3/17.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTTextView.h"

typedef void(^BTTextInputBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface BTTextInputView : UIView

@property (nonatomic, strong) UIButton * btnCommit;

@property (nonatomic, strong) BTTextView * textView;

@property (nonatomic, copy) BTTextInputBlock block;

- (void)show:(UIView*)view;

@end

NS_ASSUME_NONNULL_END
