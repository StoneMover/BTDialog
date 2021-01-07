//
//  BTTextField.h
//  live
//
//  Created by stonemover on 2019/5/7.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import <UIKit/UIKit.h>

//IB_DESIGNABLE

@interface BTTextField : UITextField

//光标最大高度设置
@property (nonatomic, assign) IBInspectable NSInteger maxCursorH;

//最大文字长度设置,设置后maxContent、maxContentBlock、changeBlock才会有回调
@property (nonatomic, assign) IBInspectable NSInteger maxContent;

//字符间距设置
@property (nonatomic, assign) IBInspectable NSInteger kern;

//placeHolder字体大小设置 需要与placeHolderColor一起设置
@property (nonatomic, assign) IBInspectable NSInteger placeHolderFontSize;

//placeHolder 颜色设置 需要与placeHolderFontSize一起设置
@property (nonatomic, assign) IBInspectable UIColor * placeHolderColor;

//文字内容改变回调
@property (nonatomic, copy) void(^changeBlock)(void);

//文字内容到达最大长度回调
@property (nonatomic, copy) void(^maxContentBlock)(void);

//开始编辑
@property (nonatomic, copy) void(^beginEditBlock)(void);

//结束编辑
@property (nonatomic, copy) void(^endEditBlock)(void);

//为键盘添加完成按钮
- (void)addDoneView;
- (void)addDoneView:(NSString*)str;

- (void)setAttributedPlaceholderWithFont:(UIFont*)font color:(UIColor*)color;
@end


