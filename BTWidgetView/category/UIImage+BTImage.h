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

+ (UIImage*)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)imageWithColor:(UIColor *)color equalSize:(CGFloat)size;

+ (UIImage*)imageOriWithName:(NSString*)imgName;

- (NSData *)compressQualityWithMaxLength:(NSInteger)maxLength;

- (UIImage *)scaleToSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
