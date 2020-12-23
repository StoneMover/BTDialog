//
//  SMBtnAutoLayout.m
//  Base
//
//  Created by whbt_mac on 15/11/6.
//  Copyright © 2015年 StoneMover. All rights reserved.
//

#import "BTKeyboardHelp.h"
#import "BTUtils.h"

@interface BTKeyboardHelp()

//需要不被键盘遮挡的view在屏幕上的Y坐标
//@property(nonatomic,assign)CGFloat windowOriY;

//需要不被键盘遮挡的view对象
@property(nonatomic,weak)UIView * viewDisplay;

//需要显示的view在屏幕的y坐标
@property (nonatomic, assign) CGFloat viewDisplayScreenY;

//计算出需要移动的距离
@property(nonatomic,assign)CGFloat resutlY;

//将要移动的rootView,当键盘收起的时候会将其返回到0点的位置
@property (nonatomic, weak) UIView * viewMove;

//需要移动的view的 原始的y坐标
@property (nonatomic, assign) CGFloat viewMoveOriY;

//需要多加的间距
@property (nonatomic, assign) CGFloat moreMargin;

//约束的原始位置点
@property (nonatomic, assign) CGFloat viewOriContraintTop;

@end


@implementation BTKeyboardHelp

- (instancetype)initWithShowView:(UIView*)showView moveView:(UIView*)moveView margin:(NSInteger)margin{
    self=[super init];
    self.moreMargin=margin;
    self.isKeyboardMoveAuto=YES;
    self.viewMove=moveView;
    [self addKeyBoardNofication];
    [self replaceDisplayView:showView withDistance:margin];
    return self;
}

- (instancetype)initWithShowView:(UIView*)showView moveView:(UIView*)moveView{
    return [self initWithShowView:showView moveView:moveView margin:0];
}

- (instancetype)initWithShowView:(UIView*)showView{
    return [self initWithShowView:showView moveView:[[[UIApplication sharedApplication] delegate] window] margin:0];
}

- (instancetype)initWithShowView:(UIView*)showView margin:(NSInteger)margin{
    return [self initWithShowView:showView moveView:[[[UIApplication sharedApplication] delegate] window] margin:margin];
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
- (void)keyboardWillHide:(NSNotification *)notification{
    _isKeyBoardOpen=NO;
    
    if (self.isKeyboardMoveAuto) {
        if (self.contraintTop) {
            [UIView animateWithDuration:.25 animations:^{
                self.contraintTop.constant=self.viewOriContraintTop;
                if (self.contraintTopView) {
                    [self.contraintTopView.superview layoutIfNeeded];
                }else{
                    [self.viewDisplay.superview layoutIfNeeded];
                    [self.viewMove.superview layoutIfNeeded];
                }
            } completion:^(BOOL finished) {
                if(self.delegate&&[self.delegate respondsToSelector:@selector(keyboardDidHide)]){
                    [self.delegate keyboardDidHide];
                }
            }];
        }else{
            [UIView animateWithDuration:.25 animations:^{
                self.viewMove.frame = CGRectMake(self.viewMove.frame.origin.x,self.viewMoveOriY, self.viewMove.frame.size.width, self.viewMove.frame.size.height);
            } completion:^(BOOL finished) {
                if(self.delegate&&[self.delegate respondsToSelector:@selector(keyboardDidHide)]){
                    [self.delegate keyboardDidHide];
                }
            }];
        }
        
    }
    
    if(self.delegate&&[self.delegate respondsToSelector:@selector(keyboardWillHide)]){
        [self.delegate keyboardWillHide];
    }
    self.resutlY=0;
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)notification
{
    if (self.isPause) {
        return;
    }
    
    //获取键盘的高度
    NSDictionary * userInfo = [notification userInfo];
    NSValue * value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    CGFloat keyboardHeight = keyboardRect.size.height;
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGFloat keyboardY=window.frame.size.height-keyboardHeight;
    
    //计算需要移动的距离,键盘针对屏幕的y坐标如果大于需要显示view的y+height说明不会被遮挡则不需要移动,否则则需要将view的y坐标减去result的值保证不被遮挡
    CGFloat result=keyboardY-self.viewDisplay.frame.size.height-self.viewDisplayScreenY-self.moreMargin;
    if (result<0){
        CGFloat newY=self.viewMoveOriY+result;
        
        if (self.isKeyboardMoveAuto) {
            if (self.contraintTop) {
                [UIView animateWithDuration:.25 animations:^{
                    self.contraintTop.constant=self.viewOriContraintTop+result;
                    if (self.contraintTopView) {
                        [self.contraintTopView.superview layoutIfNeeded];
                    }else{
                        [self.viewDisplay.superview layoutIfNeeded];
                        [self.viewMove.superview layoutIfNeeded];
                    }
                }];
            }else{
                [UIView animateWithDuration:.25 animations:^{
                    self.viewMove.frame = CGRectMake(self.viewMove.frame.origin.x, newY, self.viewMove.frame.size.width, self.viewMove.frame.size.height);
                }];
            }
            
        }
    }
    _isKeyBoardOpen=YES;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(keyboardWillShow:)]) {
        [self.delegate keyboardWillShow:keyboardHeight];
    }
    self.resutlY=result;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(keyboardMove:)]) {
        [self.delegate keyboardMove:result];
    }
    
}

-(void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)replaceDisplayView:(UIView*)viewDisplay withDistance:(NSInteger)distance{
    self.viewDisplay=viewDisplay;
    self.viewMoveOriY=self.viewMove.frame.origin.y;
    //将移动view的坐标转换为屏幕坐标,这里是用frame还是bounds需要确认
    //第一个参数rect应该是这个view自己内部的一块区域,这块区域如果你想是view自己本身,那么就是用view.bounds,如果你想是他内部的一块空间,你可以自己指定.但是切忌使用self.frame,那么基本上算出来的就是错误的结果
    //https://www.jianshu.com/p/5a7387b21789
    CGRect rect =[self.viewDisplay convertRect: self.viewDisplay.bounds toView:[[[UIApplication sharedApplication] delegate] window]];
//    CGRect rect =[self.viewDisplay convertRect: self.viewDisplay.frame toView:[[[UIApplication sharedApplication] delegate] window]];
    self.viewDisplayScreenY=rect.origin.y;
    if (!self.contraintTop) {
        for (NSLayoutConstraint * c in viewDisplay.constraints) {
            if (c.identifier&&[c.identifier isEqualToString:@"BT_KEYBOARD_CONSTRAING_ID"]) {
                self.contraintTop=c;
                break;
            }
        }
    }
    
    
}

- (void)setContraintTop:(NSLayoutConstraint *)contraintTop{
    _contraintTop=contraintTop;
    self.viewOriContraintTop=contraintTop.constant;
}

- (void)setNavTransSafeAreaStyle{
    self.viewDisplayScreenY+=BTUtils.NAVCONTENT_HEIGHT;
}

-(void)dealloc{
    [self removeNotification];
}

@end
