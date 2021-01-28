//
//  BTVerticalAnimView.h
//  live
//
//  Created by stonemover on 2019/5/10.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BTVerticalAnimView;

@protocol BTVerticalAnimViewDelegate <NSObject>

@required

- (UIView*)BTVerticalAnimView:(BTVerticalAnimView*)view viewWithIndex:(NSInteger)index;

- (NSInteger)BTVerticalAnimViewNumOfRows:(BTVerticalAnimView*)view;

@end


@interface BTVerticalAnimView : UIView

- (instancetype)initWithFrame:(CGRect)frame padding:(CGFloat)padding pauseTime:(NSInteger)time;

@property (nonatomic,weak) id<BTVerticalAnimViewDelegate> delegate;

@property (nonatomic, assign) BOOL isHoz;

- (void)reload;

- (UIView*)getCacheView;

@end


