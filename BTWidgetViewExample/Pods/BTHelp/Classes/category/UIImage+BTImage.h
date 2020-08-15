//
//  UIImage+BTImage.h
//  moneyMaker
//
//  Created by Motion Code on 2019/1/29.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (BTImage)

+ (UIImage*)bt_imageWithColor:(UIColor *)color;

+ (UIImage*)bt_imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage*)bt_imageWithColor:(UIColor *)color equalSize:(CGFloat)size;

//加载图片不受系统颜色的影响显示
+ (UIImage*)bt_imageOriWithName:(NSString*)imgName;

//压缩大小到指定的大小
- (NSData *)bt_compressQualityWithMaxLength:(NSInteger)maxLength;

//将图片缩放到指定的大小，多出的部分将以中心为基准进行裁剪
- (UIImage *)bt_scaleToSize:(CGSize)size;

//绘制圆角
- (UIImage*)bt_imageWithCornerRadius:(CGFloat)radius;

//将UIimage重绘成圆形,如果不是等宽,等高则绘制中心图片
- (UIImage*)bt_circleImage;

@end

NS_ASSUME_NONNULL_END
