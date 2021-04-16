//
//  BTStickyPageView.h
//  BTWidgetViewExample
//
//  Created by apple on 2021/4/6.
//  Copyright © 2021 stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTPageView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BTStickyPageViewDataSourse <NSObject>

@required

- (UIView*)BTStickyHeadView;

- (UIView*)BTStickySegmentView;

- (BTPageView*)BTStickyPageView;

@end


@interface BTStickyPageView : UIScrollView

@property (nonatomic, weak) id<BTStickyPageViewDataSourse> stickyDataSource;

- (void)reloadStickyData;

@end

NS_ASSUME_NONNULL_END
