//
//  UIFont+BTFont.m
//  mingZhong
//
//  Created by apple on 2021/1/8.
//

#import "UIFont+BTFont.h"
#import <BTHelp/BTScaleHelp.h>
#import <objc/runtime.h>

@implementation UIFont (BTFont)

//+ (void)load{
//    Method imp = class_getInstanceMethod([self class], @selector(fontWithName:size:));
//    Method myImp = class_getInstanceMethod([self class], @selector(BTFontWithName:size:));
//    method_exchangeImplementations(imp, myImp);
//}
//

+ (UIFont*)BTAutoFontSizeWithName:(NSString*)fontName size:(CGFloat)fontSize{
    UIFont * font = [UIFont fontWithName:fontName size:[BTScaleHelp scaleFontSize:fontSize]];
    return font;
}

+ (UIFont*)BTAutoFontWithSize:(CGFloat)size weight:(UIFontWeight)weight{
    return [UIFont systemFontOfSize:[BTScaleHelp scaleFontSize:size] weight:weight];
}

+ (UIFont*)BTAutoFontWithSize:(CGFloat)size{
    return [UIFont systemFontOfSize:[BTScaleHelp scaleFontSize:size] weight:UIFontWeightRegular];
}

+ (UIFontWeight)BTGetFontWeight:(UIFont*)font{
    NSString * weight = @"";
    NSArray * weightArray = [font.fontName componentsSeparatedByString:@"-"];
    if (weightArray.count != 2) {
        
        return UIFontWeightRegular;
    }
    weight = weightArray.lastObject;
    if ([weight isEqual:@"Ultralight"]) {
        return UIFontWeightUltraLight;
    }
    
    if ([weight isEqual:@"Thin"]) {
        return UIFontWeightThin;
    }
    
    if ([weight isEqual:@"Light"]) {
        return UIFontWeightLight;
    }
    
    if ([weight isEqual:@"Regular"]) {
        return UIFontWeightRegular;
    }
    
    if ([weight isEqual:@"Medium"]) {
        return UIFontWeightMedium;
    }
    
    if ([weight isEqual:@"Semibold"]) {
        return UIFontWeightSemibold;
    }
    
    if ([weight isEqual:@"Bold"]) {
        return UIFontWeightBold;
    }
    
    if ([weight isEqual:@"Heavy"]) {
        return UIFontWeightHeavy;
    }
    
    if ([weight isEqual:@"Black"]) {
        return UIFontWeightBlack;
    }
    
    return UIFontWeightRegular;
}

@end


@implementation UIButton (BTFont)

+ (void)load{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(BTFontInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}


- (id)BTFontInitWithCoder:(NSCoder*)aDecode{
    [self BTFontInitWithCoder:aDecode];
    
    if (self && self.tag == 1024) {
        UIFont * font = self.titleLabel.font;
        
//        NSLog(@"ssss%@",font);
        UIFont * resultFont = [UIFont BTAutoFontWithSize:font.pointSize weight:[UIFont BTGetFontWeight:font]];
        self.titleLabel.font = resultFont;
//        NSLog(@"sss%@",resultFont);
    }
    return self;
}

@end


@implementation UILabel (BTFont)

+ (void)load{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(BTFontInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}


- (id)BTFontInitWithCoder:(NSCoder*)aDecode{
    [self BTFontInitWithCoder:aDecode];
    
    if (self && self.tag == 1024) {
        UIFont * font = self.font;
        
//        NSLog(@"ssss%@",font);
        UIFont * resultFont = [UIFont BTAutoFontWithSize:font.pointSize weight:[UIFont BTGetFontWeight:font]];
        self.font = resultFont;
//        NSLog(@"sss%@",resultFont);
    }
    return self;
}

@end


@implementation UITextField (BTFont)

+ (void)load{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(BTFontInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}


- (id)BTFontInitWithCoder:(NSCoder*)aDecode{
    [self BTFontInitWithCoder:aDecode];
    
    if (self && self.tag == 1024) {
        UIFont * font = self.font;
        
//        NSLog(@"ssss%@",font);
        UIFont * resultFont = [UIFont BTAutoFontWithSize:font.pointSize weight:[UIFont BTGetFontWeight:font]];
        self.font = resultFont;
//        NSLog(@"sss%@",resultFont);
    }
    return self;
}

@end


@implementation UITextView (BTFont)

+ (void)load{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(BTFontInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}


- (id)BTFontInitWithCoder:(NSCoder*)aDecode{
    [self BTFontInitWithCoder:aDecode];
    
    if (self && self.tag == 1024) {
        UIFont * font = self.font;
        
//        NSLog(@"ssss%@",font);
        UIFont * resultFont = [UIFont BTAutoFontWithSize:font.pointSize weight:[UIFont BTGetFontWeight:font]];
        self.font = resultFont;
//        NSLog(@"sss%@",resultFont);
    }
    return self;
}

@end
