//
//  UIImage+BTImage.m
//  moneyMaker
//
//  Created by Motion Code on 2019/1/29.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "UIImage+BTImage.h"

@implementation UIImage (BTImage)

+ (UIImage *)bt_imageWithColor:(UIColor *)color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 55.f, 1.f);
    return [self bt_imageWithColor:color size:rect.size];
}

+ (UIImage *)bt_imageWithColor:(UIColor *)color size:(CGSize)size{
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+(UIImage *)bt_imageWithColor:(UIColor *)color equalSize:(CGFloat)size{
    return [self bt_imageWithColor:color size:CGSizeMake(size, size)];
}


+ (UIImage*)bt_imageOriWithName:(NSString*)imgName{
    return [[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (NSData *)bt_compressQualityWithMaxLength:(NSInteger)maxLength {
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

- (UIImage *)bt_scaleToSize:(CGSize)size{
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

- (UIImage*)bt_imageWithCornerRadius:(CGFloat)radius {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddPath(ctx, [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    CGContextClip(ctx);
    [self drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage*)bt_circleImage{
    CGRect rectClip;
    
    if (self.size.width>self.size.height) {
        rectClip=CGRectMake(self.size.width/2-self.size.height/2, 0, self.size.height,self.size.height);
    }else{
        rectClip=CGRectMake(0, self.size.height/2-self.size.width/2, self.size.width, self.size.width);
    }
    
    CGImageRef cgimg = CGImageCreateWithImageInRect([self CGImage], rectClip);
    UIImage * clipImage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);//用完一定要释放，否则内存泄露
    UIGraphicsBeginImageContext(clipImage.size);
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:1.0 green:0.1871 blue:0.3886 alpha:0].CGColor);
    
    CGRect rect=CGRectMake(0, 0, clipImage.size.width, clipImage.size.width);
    
    CGContextAddEllipseInRect(context, rect);
    
    CGContextClip(context);
    
    //在圆区域内画出image原图
    
    [clipImage drawInRect:rect];
    
    CGContextAddEllipseInRect(context, rect);
    
    CGContextStrokePath(context);
    
    //生成新的image
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newimg;
    
}


@end
