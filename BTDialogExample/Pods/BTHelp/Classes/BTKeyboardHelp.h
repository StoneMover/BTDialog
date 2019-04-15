//
//  SMBtnAutoLayout.h
//  Base
//  用来控制view不被键盘遮挡,该界面必须无导航器
//  Created by whbt_mac on 15/11/6.
//  Copyright © 2015年 StoneMover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BTBtnAutoLayoutDelegate<NSObject>

@optional
-(void)BTKeyBoardWillShow:(CGFloat)keyboardH;
-(void)BTBKeyBoardWillHide;
-(void)BTKeyBoardMove:(CGFloat)moveY;

@end

@interface BTKeyboardHelp : NSObject


-(instancetype)initWithDisPlayView:(UIView*)displayView;

-(instancetype)initWithDisPlayView:(UIView*)displayView withMargin:(int)margin;

@property(nonatomic,assign,readonly)BOOL isKeyBoardOpen;

@property(nonatomic,weak)id<BTBtnAutoLayoutDelegate> delegate;

//在界面消失的时候设置为YES,出现的时候设置为NO,以免影响其它界面的弹出
@property (nonatomic, assign) BOOL isPause;

-(void)replaceDisplayView:(UIView*)displayView withDistance:(int)distance;

@end
