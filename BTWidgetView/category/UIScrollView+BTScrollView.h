//
//  UIScrollView+BTScrollView.h
//  BTWidgetViewExample
//
//  Created by apple on 2021/3/25.
//  Copyright © 2021 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (BTScrollView)

- (void)bt_clipImgWithBottomMargin:(CGFloat)margin
                  placeHolderBlock:(void(^)(UIImageView * imgView))placeHolderBlock
                       resultBlock:(void(^)(UIImage * img))resultBlock;

@end

NS_ASSUME_NONNULL_END
