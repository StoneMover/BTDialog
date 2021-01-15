//
//  UIFont+BTFont.h
//  mingZhong
//
//  Created by apple on 2021/1/8.
//  当xib中UIButton、UILabel、UITextField、UITextView控件tag不为1024的时候，控件字体大小将根据屏幕宽度缩放
//  基于BTAutoFontSize方法进行字体大小的计算，xib中支持UIFontWeight的设置

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (BTFont)

//获取根据屏幕宽度缩放后的字体大小对象，具体缩放规则在<BTHelp/BTScaleHelp.h>中实现
+ (UIFont*)BTAutoFontSizeWithName:(NSString*)fontName size:(CGFloat)fontSize;
+ (UIFont*)BTAutoFontWithSize:(CGFloat)size weight:(UIFontWeight)weight;
+ (UIFont*)BTAutoFontWithSize:(CGFloat)size;

@end


@interface UIButton (BTFont)

@end


@interface UILabel(BTFont)

@end


@interface UITextField(BTFont)

@end

@interface UITextView(BTFont)

@end


NS_ASSUME_NONNULL_END
