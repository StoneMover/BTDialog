//
//  WKWebView+FullImg.h
//  word
//
//  Created by stonemover on 2019/6/8.
//  Copyright © 2019 stonemover. All rights reserved.
//  在WKWebView中生成图片

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKWebView (FullImg)

- (void)bt_imageRepresentation:(void(^)(UIImage * img))block;

@end

NS_ASSUME_NONNULL_END
