//
//  SMBtnAutoLayout.m
//  Base
//
//  Created by whbt_mac on 15/11/6.
//  Copyright © 2015年 StoneMover. All rights reserved.
//

#import "BTKeyboardHelp.h"

@interface BTKeyboardHelp()


@property(nonatomic,assign)int windowOriY;//需要不被键盘遮挡的view在屏幕上的Y坐标
@property(nonatomic,weak)UIView * viewDisplay;//需要显示的view对象

@property (nonatomic, assign) int viewDisplayScreenY;//需要显示的view在屏幕的y坐标

@property(nonatomic,assign)int resutlY;//计算出需要移动的距离

@property (nonatomic, weak) UIWindow *window;//程序的window窗口

@end


@implementation BTKeyboardHelp


-(instancetype)initWithDisPlayView:(UIView*)displayView{
    return [self initWithDisPlayView:displayView withMargin:5];
}

-(instancetype)initWithDisPlayView:(UIView*)displayView withMargin:(int)margin{
    self=[super init];
    self.window=[[[UIApplication sharedApplication] delegate] window];
    [self addKeyBoardNofication];
    [self replaceDisplayView:displayView withDistance:margin];
    return self;

}


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
- (void)keyboardWillHide:(NSNotification *)not{
    _isKeyBoardOpen=NO;
    self.window.frame = CGRectMake(self.window.frame.origin.x,self.windowOriY, self.window.frame.size.width, self.window.frame.size.height);
    if(self.delegate&&[self.delegate respondsToSelector:@selector(BTBKeyBoardWillHide)]){
        [self.delegate BTBKeyBoardWillHide];
    }
    self.resutlY=0;
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    if (self.isPause) {
        return;
    }
    
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int keyboardHeight = keyboardRect.size.height;
    int keyboardY=self.window.frame.size.height-keyboardHeight;
    
    //计算需要移动的距离,键盘针对屏幕的y坐标如果大于需要显示view的y+height说明不会被遮挡则不需要移动,否则则需要将view的y坐标减去result的值保证不被遮挡
    int result=keyboardY-self.viewDisplay.frame.size.height-self.viewDisplayScreenY;
    if (result<0){
        int newY=self.windowOriY+result;
        UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
        window.frame = CGRectMake(0, newY, window.frame.size.width, window.frame.size.height);
        _isKeyBoardOpen=YES;
    }
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(BTKeyBoardWillShow:)]) {
        [self.delegate BTKeyBoardWillShow:keyboardHeight];
    }
    self.resutlY=result;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(BTKeyBoardMove:)]) {
        [self.delegate BTKeyBoardMove:result];
    }
    
}

-(void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)replaceDisplayView:(UIView*)displayView withDistance:(int)distance{
    self.viewDisplay=displayView;
    self.windowOriY=self.window.frame.origin.y;
    //将移动view的坐标转换为屏幕坐标
    self.viewDisplayScreenY=[self.viewDisplay convertRect: self.viewDisplay.bounds toView:self.window].origin.y+distance;
    
}

-(void)dealloc{
    [self removeNotification];
}

@end
