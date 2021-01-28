//
//  SlideView.h
//  BTWidgetViewExample
//
//  Created by apple on 2020/5/8.
//  Copyright © 2020 stone. All rights reserved.
//  侧滑View

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,BTSlideStyle){
    BTSlideStyleLeft = 0,
    BTSlideStyleRight
};

@interface BTSlideView : UIView

- (instancetype)initWithSlideView:(UIView*)slideView style:(BTSlideStyle)style;

- (void)show:(UIView*)parentView;

- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
