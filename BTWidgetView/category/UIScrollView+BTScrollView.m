//
//  UIScrollView+BTScrollView.m
//  BTWidgetViewExample
//
//  Created by apple on 2021/3/25.
//  Copyright © 2021 stone. All rights reserved.
//

#import "UIScrollView+BTScrollView.h"
#import "UIView+BTViewTool.h"

@implementation UIScrollView (BTScrollView)

- (void)bt_clipImgWithBottomMargin:(CGFloat)margin
                  placeHolderBlock:(void(^)(UIImageView * imgView))placeHolderBlock
                       resultBlock:(void(^)(UIImage * img))resultBlock{
    //创建一个view覆盖在上面
    UIImageView * placeHolderImgView = [self createPlaceholder];
    placeHolderBlock(placeHolderImgView);
    
    CGFloat scale = [UIScreen mainScreen].scale;
    
    CGSize boundsSize = self.bounds.size;
    CGFloat boundsWidth = boundsSize.width;
    CGFloat boundsHeight = boundsSize.height;
    
    CGSize contentSize = self.contentSize;
    CGFloat contentHeight = contentSize.height;
    
    CGPoint offset = self.contentOffset;
    
    NSMutableArray *images = [NSMutableArray array];
    
    
    [self setContentOffset:CGPointMake(0, 0)];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self createImg:images height:contentHeight block:^{

            CGSize imageSize = CGSizeMake(contentSize.width * scale,
                                          (contentSize.height - margin) * scale);
            UIGraphicsBeginImageContext(imageSize);
            [images enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger idx, BOOL *stop) {
                [image drawInRect:CGRectMake(0,
                                             scale * boundsHeight * idx,
                                             scale * boundsWidth,
                                             scale * boundsHeight)];
            }];
            UIImage *fullImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            resultBlock(fullImage);
            [placeHolderImgView removeFromSuperview];
            [self setContentOffset:offset];
        }];
    });
}

- (void)createImg:(NSMutableArray*)images height:(CGFloat)contentHeight block:(void(^)(void))block{
    UIImage *image = self.superview.bt_selfImg;
    [images addObject:image];
    CGFloat offsetY = self.contentOffset.y;
    [self setContentOffset:CGPointMake(0, offsetY + self.bounds.size.height)];
    contentHeight -= self.bounds.size.height;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (contentHeight>0) {
            [self createImg:images height:contentHeight block:block];
        }else{
            block();
        }
    });
}

- (UIImageView *)createPlaceholder{
    UIImage *image = self.superview.bt_selfImg;

    UIImageView * imgViewPlaceholder=[[UIImageView alloc] initWithImage:image];
    imgViewPlaceholder.tag=100;
    imgViewPlaceholder.frame=self.superview.frame;
    [self.superview.superview addSubview:imgViewPlaceholder];
    return imgViewPlaceholder;
}

@end
