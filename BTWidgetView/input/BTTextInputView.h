//
//  BTTextInputView.h
//  word
//
//  Created by stonemover on 2019/3/17.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTTextView.h"

@class BTTextInputToolView;

typedef NS_ENUM(NSInteger,BTTextInputToolType) {
    BTTextInputViewTypeSimple = 0,//没有语音功能，有输入框和发送按钮，用于普通的评论
    BTTextInputViewTypeVoice,//有语音输入的按钮、有发送按钮、有输入框,用于聊天对话中
    BTTextInputViewTypeAll
};

@interface BTTextInputView : UIView

@property (nonatomic, strong) BTTextInputToolView * toolView;

- (void)show:(UIView*)view;

@end


@protocol BTTextInputToolViewDelegate <NSObject>

@optional

//录音开始
- (void)BTTextInputToolViewStart:(BTTextInputToolView*)view;

//录音的状态改变，取消录音，松开发送状态改变
- (void)BTTextInputToolViewStatus:(BTTextInputToolView*)view isCancel:(BOOL)isCancel;

//录音结束
- (void)BTTextInputToolViewEnd:(BTTextInputToolView*)view;

//变成录音界面
- (void)BTTextInputToolViewChangeToVoice:(BTTextInputToolView*)view;

//变成输入框界面
- (void)BTTextInputToolViewChangeToText:(BTTextInputToolView*)view;

@end


@interface BTTextInputToolView : UIView

- (instancetype)initWithFrame:(CGRect)frame type:(BTTextInputToolType)type;

//设置当前输入状态为文字状态
- (void)setDefaultStatus;

//输入框
@property (nonatomic, strong, readonly) BTTextView * textView;

//发送按钮
@property (nonatomic, strong, readonly) UIButton * btnCommit;

//切换语音、键盘按钮
@property (nonatomic, strong, readonly) UIButton * btnVoice;

//表情按钮
@property (nonatomic, strong, readonly) UIButton * btnEmoj;

//更多
@property (nonatomic, strong, readonly) UIButton * btnMore;

//语音图标
@property (nonatomic, strong) UIImage * voiceImg;

//键盘图标
@property (nonatomic, strong) UIImage * keyboardImg;

//相关事件的状态回调
@property (nonatomic, weak) id<BTTextInputToolViewDelegate> delegate;

//点击发送按钮回调
@property (nonatomic, copy) void(^sendClickBlock)(void);

//布局回调，可以自己调整想要的自定义布局
@property (nonatomic, copy) void(^layoutBlock)(void);

//能够发送文字状态下的发送文字颜色
@property (nonatomic, strong) UIColor * commitColor;

@end


