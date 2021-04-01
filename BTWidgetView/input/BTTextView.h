//
//  BTTextView.h
//  word
//
//  Created by stonemover on 2019/3/13.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BTTextView : UITextView

//placeHolder文字
@property (nonatomic, strong) IBInspectable NSString * placeHolder;

//placeHolder文字颜色
@property (nonatomic, strong) IBInspectable UIColor * placeHolderColor;

//最大字符串长度
@property (nonatomic, assign) IBInspectable NSInteger maxStrNum;

//行间距，这个在xib中使用的时候不能设置textView的初始内容，得在代码里面设置，不然没有效果
@property (nonatomic, assign) IBInspectable NSInteger lineSpeac;

//触发最大文字长度回调
@property (nonatomic, copy) void(^blockMax)(void);

//高度发生变化回调
@property (nonatomic, copy) void(^blockHeightChange)(CGFloat height);

//内容发生改变回调
@property (nonatomic, copy) void(^blockContentChange)(void);

//是否自己设置textView的textContainerInset，用来解决textView边距问题
@property (nonatomic, assign) BOOL isSelfSetEdgeInsets;

//自定义光标大小
@property (nonatomic, assign) CGSize cursorSize;

//添加完成按钮
- (void)addDoneView;

- (void)addDoneView:(NSString*)str;

//开始编辑回调
@property (nonatomic, copy) void(^blockStartEdit)(void);

//结束编辑回调
@property (nonatomic, copy) void(^blockEndEdit)(void);

//隐藏placeholder
- (void)hidePlaceholder;

//显示placeholder
- (void)showPlaceholder;



@end


