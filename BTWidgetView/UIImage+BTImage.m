//
//  UIImage+BTImage.m
//  moneyMaker
//
//  Created by Motion Code on 2019/1/29.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "UIImage+BTImage.h"

@implementation UIImage (BTImage)

+ (UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 55.f, 1.f);
    return [self imageWithColor:color size:rect.size];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+(UIImage *)imageWithColor:(UIColor *)color equalSize:(CGFloat)size{
    return [self imageWithColor:color size:CGSizeMake(size, size)];
}


+ (UIImage*)imageOriWithName:(NSString*)imgName{
    return [[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (NSData *)compressQualityWithMaxLength:(NSInteger)maxLength {
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    if (data.length < maxLength) return data;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    return data;
}

- (UIImage *)scaleToSize:(CGSize)size{
    if (size.width>size.height) {
        if (size.width > self.size.width) {
            return  self;
        }
        CGFloat height = (size.width / self.size.width) * self.size.height;
        CGRect  rect = CGRectMake(0, 0, size.width, height);
        UIGraphicsBeginImageContext(rect.size);
        [self drawInRect:rect];
        UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }else{
        if (size.height > self.size.height) {
            return  self;
        }
        CGFloat width = (size.height / self.size.height) * self.size.width;
        CGRect  rect = CGRectMake(0, 0, width, size.height);
        UIGraphicsBeginImageContext(rect.size);
        [self drawInRect:rect];
        UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}

@end
