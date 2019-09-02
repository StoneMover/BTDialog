//
//  SMListDialogView.m
//  Base
//
//  Created by whbt_mac on 16/1/5.
//  Copyright © 2016年 StoneMover. All rights reserved.
//

#import "BTDialogView.h"


@interface BTDialogView()

@property(strong, nonatomic) UIView * showView;

@property(strong, nonatomic) UIButton * btnBg;//用来监听点击消失手势的按钮

@property(strong, nonatomic) UIView * bgBlackColor;//透明的黑色

@property (nonatomic,assign) BTDialogAnimStyle animStyle;//动画样式

@property (nonatomic, assign) BTDialogLocation location;//位置对象



@end

@implementation BTDialogView

#pragma mark 初始化方法


-(instancetype)init:(UIView*)showView withLocation:(BTDialogLocation)location{
    self=[super init];
    self.location=location;
    self.showView=showView;
    [self initDialog];
    return self;
}

-(instancetype)init:(UIView*)showView{
    return [self init:showView withLocation:BTDialogLocationCenter];
}


//初始化弹框
-(void)initDialog{
    //设置颜色背景
    self.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    self.clickEmptyAreaDismiss=YES;
    
    //设置透明层
    self.bgBlackColor=[[UIView alloc]init];
    self.bgBlackColor.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1];
    self.bgBlackColor.alpha=0;
    [self addSubview:self.bgBlackColor];
    
    //设置消失点击按钮
    self.btnBg=[[UIButton alloc]init];
    [self.btnBg addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnBg];
    
    [self addSubview:self.showView];
}




-(void)layoutSubviews{
    self.bgBlackColor.frame=self.bounds;
    self.btnBg.frame=self.bounds;
}



#pragma mark show & dismiss & destory

-(void)show:(UIView *)view{
    [self show:view withAnimStyle:BTDialogAnimStyleStyleDefault];
}

-(void)show:(UIView *)view withAnimStyle:(BTDialogAnimStyle)style{
    [view addSubview:self];
    self.frame=CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    self.animStyle=style;
    
    switch (self.location) {
        case BTDialogLocationCenter:
            self.showView.center=CGPointMake(self.width/2, self.height/2-self.centerOffset);
            [self centerLocationShowAnim];
            break;
        case BTDialogLocationTop:
        {
            self.showView.frame=CGRectMake(0, -self.showView.height, self.showView.width, self.showView.height);
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.bgBlackColor.alpha=.5;
                [self.showView setAlpha:1];
                self.showView.frame=CGRectMake(0, 0, self.showView.width, self.showView.height);
            } completion:^(BOOL finished) {
                
            }];
            
        }
            break;
        case BTDialogLocationBottom:
        {
            self.showView.frame=CGRectMake(0, self.height, self.showView.width, self.showView.height);
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.bgBlackColor.alpha=.5;
                [self.showView setAlpha:1];
                self.showView.frame=CGRectMake(self.showView.left, self.height-self.showView.height, self.showView.width, self.showView.height);
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
    }
}

#pragma mark 显示动画
-(void)centerLocationShowAnim{
    switch (self.animStyle) {
        case BTDialogAnimStyleAndroid:{
            self.showView.alpha=0;
            self.showView.transform = CGAffineTransformMakeScale(.25f, .25f);
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.bgBlackColor.alpha=.5;
                self.showView.alpha=1;
                self.showView.transform=CGAffineTransformMakeScale(1.0f, 1.0f);
            } completion:^(BOOL finished) {
                
            }];
            
        }
            
            break;
        case BTDialogAnimStyleStyleDefault:{
            self.showView.alpha=0;
            self.showView.transform = CGAffineTransformMakeScale(1.2, 1.2);
            
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.showView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                self.showView.alpha = 1;
                self.bgBlackColor.alpha = .5;
            } completion:^(BOOL finished) {
                
            }];
        }
            
            break;
    }
}


#pragma mark 消失动画
-(void)dismiss{
    switch (self.location) {
        case BTDialogLocationCenter:
            [self dismissCenterAnim];
            break;
        case BTDialogLocationTop:
        {
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.bgBlackColor.alpha = 0;
                self.showView.frame=CGRectMake(self.showView.left,-self.showView.height, self.showView.width, self.showView.height);
            } completion:^(BOOL finished) {
                [self destory];
            }];
        }
            break;
        case BTDialogLocationBottom:
        {
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.bgBlackColor.alpha = 0;
                self.showView.frame=CGRectMake(self.showView.left, self.height, self.showView.width, self.showView.height);
            } completion:^(BOOL finished) {
                self.showView.alpha = 0;
                [self destory];
            }];
        }
            break;
            
        default:
            break;
    }
    
}

-(void)dismissCenterAnim{
    switch (self.animStyle) {
        case BTDialogAnimStyleStyleDefault:
        {
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.showView.alpha = 0;
                self.bgBlackColor.alpha = 0;
            }completion:^(BOOL finished){
                [self destory];
            }];
        }
            break;
        case BTDialogAnimStyleAndroid:{
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.bgBlackColor.alpha = 0;
                self.showView.alpha=0;
                self.showView.transform=CGAffineTransformMakeScale(.25f, .25f);
            } completion:^(BOOL finished) {
                [self destory];
            }];
            
            
        }
            
        default:
            break;
    }
}



#pragma mark 销毁
-(void)destory{
    if (self.blockDismiss) {
        self.blockDismiss();
    }
    [self removeFromSuperview];
}

-(void)btnClick{
    if (self.clickEmptyAreaDismiss)[self dismiss];
}

-(void)setCornerNum:(CGFloat)cornerNum{
    _cornerNum=cornerNum;
    self.showView.layer.cornerRadius=cornerNum;
}

@end