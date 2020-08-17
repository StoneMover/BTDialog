//
//  UIView+BTEasyDialog.h
//  AFNetworking
//
//  Created by stonemover on 2019/5/21.
//

#import <UIKit/UIKit.h>
#import "BTDialogView.h"


@interface UIView (BTEasyDialog)

- (BTDialogView*)bt_createDialog:(BTDialogLocation)location;

- (BTDialogView*)bt_show:(BTDialogLocation)location inView:(UIView*)view;

- (BTDialogView*)bt_show:(BTDialogLocation)location;

- (BTDialogView*)bt_showBottom;

- (BTDialogView*)bt_showCenter;

- (BTDialogView*)bt_showTop;

//当显示后view自身成为dialog的childView，然后即可用该方法获取值
- (BTDialogView*)bt_dialogView;

@end


