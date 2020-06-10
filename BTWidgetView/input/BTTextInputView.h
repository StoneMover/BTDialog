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

typedef void(^BTTextInputBlock)(void);

typedef NS_ENUM(NSInteger,BTTextInputToolType) {
    BTTextInputViewTypeNoVoice = 0,//没有语音功能，有输入框和发送按钮，用于普通的评论
    BTTextInputViewTypeAll//有语音输入的按钮、有发送按钮、有输入框,用于聊天对话中
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

- (void)setDefaultStatus;

//发送按钮
@property (nonatomic, strong) UIButton * btnCommit;

//切换语音、键盘按钮
@property (nonatomic, strong) UIButton * btnVoice;

//按住说话按钮
@property (nonatomic, strong) UIButton * btnPressVoice;

//输入框
@property (nonatomic, strong) BTTextView * textView;

//语音图标
@property (nonatomic, strong) UIImage * voiceImg;

//键盘图标
@property (nonatomic, strong) UIImage * keyboardImg;

@property (nonatomic, weak) id<BTTextInputToolViewDelegate> delegate;

@property (nonatomic, copy) BTTextInputBlock block;

//能够发送文字状态下的发送文字颜色
@property (nonatomic, strong) UIColor * commitColor;

@end


