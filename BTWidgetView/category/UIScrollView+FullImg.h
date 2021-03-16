//
//  UIScrollView+FullImg.h
//  word
//
//  Created by liao on 2021/3/13.
//  Copyright © 2021 stonemover. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (FullImg)

- (void)bt_clipImgWithBottomMargin:(CGFloat)margin
                  placeHolderBlock:(void(^)(UIImageView * imgView))placeHolderBlock
                       resultBlock:(void(^)(UIImage * img))resultBlock;



@end

NS_ASSUME_NONNULL_END
