//
//  UIView+BTEasyDialog.h
//  AFNetworking
//
//  Created by stonemover on 2019/5/21.
//

#import <UIKit/UIKit.h>
#import "BTDialogView.h"


@interface UIView (BTEasyDialog)

- (BTDialogView*)createDialog:(BTDialogLocation)location;

- (BTDialogView*)show:(BTDialogLocation)location inView:(UIView*)view;

- (BTDialogView*)show:(BTDialogLocation)location;

- (BTDialogView*)showBottom;

- (BTDialogView*)showCenter;

- (BTDialogView*)showTop;

//当显示后view自身成为dialog的childView，然后即可用该方法获取值
- (BTDialogView*)dialogView;

@end


