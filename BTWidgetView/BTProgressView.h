//
//  BTProgressView.h
//  BTWidgetViewExample
//
//  Created by apple on 2020/4/28.
//  Copyright © 2020 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BTProgressView : UIView

//显示的进度view
@property (nonatomic, strong) UIView * progressView;

//0:横向；1:竖向
@property (nonatomic, assign) IBInspectable NSInteger type;

//百分比 0.5
@property (nonatomic, assign) IBInspectable CGFloat percent;

@end

NS_ASSUME_NONNULL_END
