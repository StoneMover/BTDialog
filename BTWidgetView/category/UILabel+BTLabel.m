//
//  UILabel+BTLabel.m
//  BTWidgetViewExample
//
//  Created by apple on 2020/6/16.
//  Copyright © 2020 stone. All rights reserved.
//

#import "UILabel+BTLabel.h"
#import <BTHelp/NSString+BTString.h>

@implementation UILabel (BTLabel)


- (NSMutableAttributedString*)bt_AttributedString{
    if (self.attributedText == nil) {
        return [[NSMutableAttributedString alloc] initWithString:self.text];
    }
    
    return [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
}

//设置文字字体
- (void)bt_AttributedFont:(UIFont*)font str:(NSString*)str{
    [self bt_AttributedFont:font range:[self.text rangeOfString:str]];
}

- (void)bt_AttributedFont:(UIFont*)font range:(NSRange)range{
    NSMutableAttributedString * attributed = [self bt_AttributedString];
    [attributed addAttribute:NSFontAttributeName value:font range:range];
    self.attributedText = attributed;
}

//设置文字颜色
- (void)bt_AttributedColor:(UIColor*)color str:(NSString*)str{
    [self bt_AttributedColor:color range:[self.text rangeOfString:str]];
}

- (void)bt_AttributedColor:(UIColor*)color range:(NSRange)range{
    NSMutableAttributedString * attributed = [self bt_AttributedString];
    [attributed addAttribute:NSForegroundColorAttributeName value:color range:range];
    self.attributedText = attributed;
}

//设置文字背景颜色
- (void)bt_AttributedBgColor:(UIColor*)color range:(NSRange)range{
    NSMutableAttributedString * attributed = [self bt_AttributedString];
    [attributed addAttribute:NSBackgroundColorAttributeName value:color range:range];
    self.attributedText = attributed;
}

- (void)bt_AttributedBgColor:(UIColor*)color str:(NSString*)str{
    [self bt_AttributedBgColor:color range:[self.text rangeOfString:str]];
}

//设置字体文字间距
- (void)bt_AttributedKern:(NSNumber*)kern range:(NSRange)range{
    NSMutableAttributedString * attributed = [self bt_AttributedString];
    [attributed addAttribute:NSKernAttributeName value:kern range:range];
    self.attributedText = attributed;
}

- (void)bt_AttributedKern:(NSNumber*)kern str:(NSString*)str{
    [self bt_AttributedKern:kern range:[self.text rangeOfString:str]];
}


//设置删除线
- (void)bt_AttributedDelLine:(UIColor*)color range:(NSRange)range{
    NSMutableAttributedString * attributed = [self bt_AttributedString];
    [attributed addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle) range:range];
    [attributed addAttribute:NSStrikethroughColorAttributeName value:color range:range];
    self.attributedText = attributed;
}

- (void)bt_AttributedDelLine:(UIColor*)color str:(NSString*)str{
    [self bt_AttributedDelLine:color range:[self.text rangeOfString:str]];
}

//设置下划线
- (void)bt_AttributedUnderLine:(UIColor*)color range:(NSRange)range{
    NSMutableAttributedString * attributed = [self bt_AttributedString];
    [attributed addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:range];
    [attributed addAttribute:NSUnderlineColorAttributeName value:color range:range];
    self.attributedText = attributed;
}

- (void)bt_AttributedUnderLine:(UIColor*)color str:(NSString*)str{
    [self bt_AttributedUnderLine:color range:[self.text rangeOfString:str]];
}

//设置超链接
- (void)bt_AttributedLink:(NSURL*)url range:(NSRange)range{
    NSMutableAttributedString * attributed = [self bt_AttributedString];
    [attributed addAttribute:NSLinkAttributeName value:url range:range];
    self.attributedText = attributed;
}

- (void)bt_AttributedLink:(NSURL*)url str:(NSString*)str{
    [self bt_AttributedLink:url range:[self.text rangeOfString:str]];
}


/**
 设置两端对齐
 需要验证是否需要NSUnderlineStyleAttributeName:NSUnderlineStyleNone
 NSDictionary *dic = @{NSParagraphStyleAttributeName: para,NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleNone]};
 */
- (void)bt_AttributedAlignStartEnd{
    NSMutableAttributedString *attri = [self bt_AttributedString];
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc]init];
    //设置文字两端对齐
    para.alignment = NSTextAlignmentJustified;
    NSDictionary *dic = @{NSParagraphStyleAttributeName: para};
    [attri setAttributes:dic range:NSMakeRange(0, attri.length)];
    self.attributedText = attri;
}

- (void)bt_setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing{
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = lineSpacing;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    self.attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (CGFloat)bt_calculateLabelHeight{
    return [self.text bt_calculateStrHeight:self.frame.size.width font:self.font];
}


- (CGFloat)bt_calculateLabelWidth{
    return [self.text bt_calculateStrWidth:self.frame.size.height font:self.font];
}

- (instancetype)initBTLabelWithColor:(UIColor*)color font:(UIFont*)font{
    self = [super initWithFrame:CGRectZero];
    self.textColor = color;
    self.font = font;
    [self sizeToFit];
    return self;
}

@end
