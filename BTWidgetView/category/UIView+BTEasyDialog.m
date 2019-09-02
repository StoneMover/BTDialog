//
//  UIView+BTEasyDialog.m
//  AFNetworking
//
//  Created by stonemover on 2019/5/21.
//

#import "UIView+BTEasyDialog.h"

@implementation UIView (BTEasyDialog)

- (BTDialogView*)createDialog:(BTDialogLocation)location{
    BTDialogView * dialogView = [[BTDialogView alloc] init:self withLocation:location];
    return dialogView;
}

- (BTDialogView*)show:(BTDialogLocation)location inView:(UIView*)view{
    BTDialogView * dialogView = [self createDialog:location];
    [dialogView show:view];
    return dialogView;
}

- (BTDialogView*)show:(BTDialogLocation)location{
    return [self show:location inView:[UIApplication sharedApplication].delegate.window];
}

- (BTDialogView*)showBottom{
    return [self show:BTDialogLocationBottom inView:[UIApplication sharedApplication].delegate.window];
}

- (BTDialogView*)showCenter{
    return [self show:BTDialogLocationCenter inView:[UIApplication sharedApplication].delegate.window];
}

- (BTDialogView*)showTop{
    return [self show:BTDialogLocationTop inView:[UIApplication sharedApplication].delegate.window];
}

- (BTDialogView*)dialogView{
    if (self.superview) {
        if ([self.superview isKindOfClass:[BTDialogView class]]) {
            return (BTDialogView*)(self.superview);
        }
    }
    return nil;
}

@end
