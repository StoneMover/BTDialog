//
//  UIView+BTEasyDialog.m
//  AFNetworking
//
//  Created by stonemover on 2019/5/21.
//

#import "UIView+BTEasyDialog.h"

@implementation UIView (BTEasyDialog)

- (BTDialogView*)bt_createDialog:(BTDialogLocation)location{
    BTDialogView * dialogView = [[BTDialogView alloc] init:self withLocation:location];
    return dialogView;
}

- (BTDialogView*)bt_show:(BTDialogLocation)location inView:(UIView*)view{
    BTDialogView * dialogView = [self bt_createDialog:location];
    [dialogView show:view];
    return dialogView;
}

- (BTDialogView*)bt_show:(BTDialogLocation)location{
    return [self bt_show:location inView:[UIApplication sharedApplication].delegate.window];
}

- (BTDialogView*)bt_showBottom{
    return [self bt_show:BTDialogLocationBottom inView:[UIApplication sharedApplication].delegate.window];
}

- (BTDialogView*)bt_showCenter{
    return [self bt_show:BTDialogLocationCenter inView:[UIApplication sharedApplication].delegate.window];
}

- (BTDialogView*)bt_showTop{
    return [self bt_show:BTDialogLocationTop inView:[UIApplication sharedApplication].delegate.window];
}

- (BTDialogView*)bt_dialogView{
    if (self.superview) {
        if ([self.superview isKindOfClass:[BTDialogView class]]) {
            return (BTDialogView*)(self.superview);
        }
    }
    return nil;
}

@end
