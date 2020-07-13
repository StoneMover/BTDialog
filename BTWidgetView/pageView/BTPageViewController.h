//
//  BTPageViewController.h
//  BTWidgetViewExample
//
//  Created by zanyu on 2019/8/26.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTPageView.h"

NS_ASSUME_NONNULL_BEGIN


@class BTPageViewController;

@protocol BTPageViewControllerDataSource <NSObject>

@required

- (NSInteger)pageNumOfVc:(BTPageViewController*)pageView;

- (UIViewController*)pageVc:(BTPageViewController*)pageVc vcForIndex:(NSInteger)index;

//为空则不显示headView
- (nullable BTPageHeadView*)pageVcHeadView:(BTPageViewController*)pageVc;

- (CGPoint)pageVcHeadOrigin:(BTPageViewController*)pageVc;

- (CGRect)pageVcContentFrame:(BTPageViewController*)pageVc;

@end


@protocol BTPageViewControllerDelegate <NSObject>

- (void)pageVc:(BTPageViewController*)pageView didShow:(NSInteger)index;

- (void)pageVc:(BTPageViewController *)pageView didDismiss:(NSInteger)index;

@end

@interface BTPageViewController : UIViewController

- (instancetype)initWithIndex:(NSInteger)index;

//是否需要自动加载当前页面的上一页和下一页，默认为YES
@property (nonatomic, assign) BOOL isNeedLoadNextAndLast;

@property (nonatomic, weak) id<BTPageViewControllerDataSource> dataSource;

@property (nonatomic, weak) id<BTPageViewControllerDelegate> delegate;

//是否可以滑动切换
@property (nonatomic, assign) BOOL isCanScroll;

- (void)reloadData;

- (void)selectIndex:(NSInteger)index animated:(BOOL)animated;

- (NSArray<UIViewController*>*)getAllVc;

- (nullable UIViewController*)vcWithIndex:(NSInteger)index;

- (nullable UIViewController*)vcSelect;

- (CGRect)pageViewFrame;

@end

NS_ASSUME_NONNULL_END
