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

//最大文字长度设置
@property (nonatomic, assign) IBInspectable NSInteger maxContent;

//字符间距设置
@property (nonatomic, assign) IBInspectable NSInteger kern;

//placeHolder字体大小设置
@property (nonatomic, assign) IBInspectable NSInteger placeHolderFontSize;

//文字内容改变回调
@property (nonatomic, copy) void(^changeBlock)(void);

//文字内容到达最大长度回调
@property (nonatomic, copy) void(^maxContentBlock)(void);

//为键盘添加完成按钮
- (void)addDoneView;

@end


