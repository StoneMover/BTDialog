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



@interface BTTextInputView : UIView

@property (nonatomic, strong) UIButton * btnCommit;

@property (nonatomic, strong) BTTextView * textView;

@property (nonatomic, copy) BTTextInputBlock block;

@property (nonatomic, strong) UIColor * commitColor;

- (void)show:(UIView*)view;

@end


