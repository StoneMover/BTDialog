//
//  BTSearchView.h
//  BTWidgetViewExample
//
//  Created by apple on 2020/4/14.
//  Copyright © 2020 stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTSearchHeadView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BTSearchView : UIView

@property (nonatomic, strong) BTSearchHeadView * viewHead;

- (void)show:(UIView*)view;

@end

NS_ASSUME_NONNULL_END
