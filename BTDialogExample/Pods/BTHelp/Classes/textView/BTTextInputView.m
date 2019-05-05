//
//  BTTextInputView.m
//  word
//
//  Created by stonemover on 2019/3/17.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "BTTextInputView.h"
#import "UIView+BTViewTool.h"
#import "BTUtils.h"

@interface BTTextInputView()

@property (nonatomic, strong) UIView * rootView;

@property (nonatomic, assign) CGFloat basicHeight;

@property (nonatomic, assign) CGFloat keyboardH;

@end

@implementation BTTextInputView

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    [self initSelf];
    return self;
}

- (void)initSelf{
    self.basicHeight=56;
    [self addKeyBoardNofication];
    self.rootView=[[UIView alloc] initWithFrame:CGRectMake(0, self.height-53, self.width, self.basicHeight)];
    self.rootView.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.rootView];
    
    
    UIView * viewLine=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, .5)];
    viewLine.backgroundColor=[BTUtils RGB:235 G:235 B:235];
    [self.rootView addSubview:viewLine];
    
    self.btnCommit=[[UIButton alloc] initWithSize:CGSizeMake(75, 55)];
    [self.btnCommit addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    [self.btnCommit setTitle:@"发布" forState:UIControlStateNormal];
    [self.btnCommit setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.btnCommit.titleLabel.font=[UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
    [self.rootView addSubview:self.btnCommit];
    
    __weak BTTextInputView * weakSelf=self;
    self.textView=[[BTTextView alloc] initWithSize:CGSizeMake(100, self.basicHeight-20)];
    [self.textView setTextContainerInset:UIEdgeInsetsMake(8, 5, 8, 5)];
    self.textView.font=[UIFont systemFontOfSize:16];
    self.textView.textColor=[BTUtils RGB:74 G:76 B:95];
    self.textView.corner=5;
    self.textView.borderColor=[BTUtils RGB:234 G:234 B:234];
    self.textView.borderWidth=.5;
    self.textView.placeHolderColor=[BTUtils RGB:198 G:198 B:198];
    self.textView.placeHolder=@"请输入评论";
    self.textView.maxStrNum=140;
    self.textView.blockMax = ^{
        
    };
    self.textView.blockHeightChange = ^(CGFloat height) {
        CGFloat h=height+20;
        if (h<weakSelf.basicHeight) {
            h=weakSelf.basicHeight;
        }
        if (h>120) {
            h=120;
        }
        weakSelf.rootView.height=h;
        [weakSelf layoutSubviews];
        weakSelf.rootView.bottom=[UIScreen mainScreen].bounds.size.height-weakSelf.keyboardH;
    };
    self.textView.blockContentChange = ^{
        if (weakSelf.textView.text.length==0) {
            [weakSelf.btnCommit setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }else{
            [weakSelf.btnCommit setTitleColor:weakSelf.commitColor?weakSelf.commitColor:UIColor.redColor forState:UIControlStateNormal];
        }
    };
    [self.rootView addSubview:self.textView];
    
    
    
}

- (void)layoutSubviews{
    self.textView.frame=CGRectMake(15, 10, self.rootView.width-15-self.btnCommit.width, self.rootView.height-20);
    self.btnCommit.frame=CGRectMake(self.textView.right, 0, self.btnCommit.width, self.rootView.height);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textView endEditing:YES];
}

- (void)show:(UIView*)view{
    if ([self superview]) {
        [self removeFromSuperview];
    }
    
    [view addSubview:self];
    [self.textView becomeFirstResponder];
}




#pragma mark 键盘广播
//添加键盘监听通知
-(void)addKeyBoardNofication{
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}


//当键盘消失的时候调用
- (void)keyboardWillHide:(NSNotification *)notif {
    [UIView animateWithDuration:.2 animations:^{
        self.rootView.bottom=[UIScreen mainScreen].bounds.size.height;
        self.rootView.alpha=0;
    } completion:^(BOOL finished) {
        self.rootView.hidden=YES;
        self.rootView.alpha=1;
        [self removeFromSuperview];
    }];
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    self.keyboardH= keyboardRect.size.height;
    
    self.rootView.hidden=NO;
    [UIView animateWithDuration:.25 animations:^{
        self.rootView.bottom=[UIScreen mainScreen].bounds.size.height-self.keyboardH;
    } completion:^(BOOL finished) {
    }];
}

- (void)saveClick{
    if (self.textView.text.length==0) {
        return;
    }
    if (self.block) {
        self.block();
    }
}


@end
