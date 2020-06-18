//
//  WKWebView+FullImg.m
//  word
//
//  Created by stonemover on 2019/6/8.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "WKWebView+FullImg.h"

@implementation WKWebView (FullImg)

- (void)bt_imageRepresentation:(void(^)(UIImage * img))block{
    CGFloat scale = [UIScreen mainScreen].scale;
    
    CGSize boundsSize = self.bounds.size;
    CGFloat boundsWidth = boundsSize.width;
    CGFloat boundsHeight = boundsSize.height;
    
    CGSize contentSize = self.scrollView.contentSize;
    CGFloat contentHeight = contentSize.height;
    
    CGPoint offset = self.scrollView.contentOffset;
    
    NSMutableArray *images = [NSMutableArray array];
    //创建一个view覆盖在上面
    [self createPlaceholder:images];
    
    
    [self.scrollView setContentOffset:CGPointMake(0, 0)];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self createImg:images height:contentHeight block:^{
            [self.scrollView setContentOffset:offset];
            
            CGSize imageSize = CGSizeMake(contentSize.width * scale,
                                          contentSize.height * scale);
            UIGraphicsBeginImageContext(imageSize);
            [images enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger idx, BOOL *stop) {
                [image drawInRect:CGRectMake(0,
                                             scale * boundsHeight * idx,
                                             scale * boundsWidth,
                                             scale * boundsHeight)];
            }];
            UIImage *fullImage = UIGraphicsGetImageFromCurrentImageContext();
            //        UIScrollView * scrollView =[[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            //        UIImageView * imgView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, contentSize.width, contentSize.height)];
            //        imgView.image=fullImage;
            //        [scrollView addSubview:imgView];
            //        [scrollView setContentSize:contentSize];
            //        scrollView.pagingEnabled=YES;
            //        [APPDELEGATE.window addSubview:scrollView];
            UIGraphicsEndImageContext();
            block(fullImage);
        }];
    });
    
    
}

- (void)createImg:(NSMutableArray*)images height:(CGFloat)contentHeight block:(void(^)(void))block{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [images addObject:image];
    CGFloat offsetY = self.scrollView.contentOffset.y;
    [self.scrollView setContentOffset:CGPointMake(0, offsetY + self.bounds.size.height)];
    contentHeight -= self.bounds.size.height;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (contentHeight>0) {
            [self createImg:images height:contentHeight block:block];
        }else{
            for (UIView * v in self.superview.subviews) {
                if ([v isKindOfClass:[UIImageView class]]) {
                    UIImageView * imgChild=(UIImageView*)v;
                    if (imgChild.image==images[0]) {
                        [imgChild removeFromSuperview];
                        [images removeObjectAtIndex:0];
                        break;
                    }
                }
            }
            block();
        }
    });
}

- (void)createPlaceholder:(NSMutableArray*)imgs{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView * imgViewPlaceholder=[[UIImageView alloc] initWithImage:image];
    imgViewPlaceholder.tag=100;
    imgViewPlaceholder.frame=self.frame;
    [self.superview addSubview:imgViewPlaceholder];
    [imgs addObject:image];
}

@end
