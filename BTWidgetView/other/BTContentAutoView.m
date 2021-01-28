//
//  BTContentAutoView.m
//  word
//
//  Created by stonemover on 2018/1/10.
//  Copyright © 2018年 stonemover. All rights reserved.
//

#import "BTContentAutoView.h"
#import "BTUtils.h"
#import "UIView+BTViewTool.h"
#import <BTHelp/NSString+BTString.h>

@interface BTContentAutoView()

@property (nonatomic, strong) NSMutableArray * dataBtns;

@property (nonatomic, assign) CGFloat startX;

@property (nonatomic, assign) CGFloat startY;

@end

@implementation BTContentAutoView

- (instancetype)initWithCoder:(NSCoder *)coder{
    self= [super initWithCoder:coder];
    [self initSelf];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self initSelf];
    return self;
}

- (void)initSelf{
    self.dataBtns=[NSMutableArray new];
    
    if (self.contentH==0) {
        self.contentH=20;
    }
    
    if (self.contentVSpace==0) {
        self.contentVSpace=15;
    }
    
    if (self.contentHSpace==0) {
        self.contentHSpace=15;
    }
    
    if (self.paddingLeftRight == 0) {
        self.paddingLeftRight = 20;
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.startX=0;
    self.startY=0;
    for (UIButton * btn in self.dataBtns) {
        NSString * btnStr=btn.titleLabel.text;
        CGFloat btnW=[btnStr bt_calculateStrWidth:self.contentH font:btn.titleLabel.font];
        btnW+=self.paddingLeftRight*2;//左右间隙
        
        CGFloat endX=0;
        if (self.startX==0) {
            //第一行的第一个
            endX=btnW+self.startX;
        }else{
            endX=btnW+self.contentHSpace+self.startX+4;
        }
        
        if (endX>=self.BTWidth &&self.startX==0) {
            //说明需要自己单独一行
            btn.frame=CGRectMake(self.startX, self.startY, self.BTWidth, self.contentH);
            self.startY+=self.contentVSpace+self.contentH;
            
            
        }else{
            if (endX>=self.BTWidth) {
                //当前行的宽度不够，到下一行
                self.startX=0;
                self.startY+=self.contentVSpace+self.contentH;
                if (btnW>=self.BTWidth) {
                    //需要自己一行
                    btn.frame=CGRectMake(self.startX, self.startY, self.BTWidth, self.contentH);
                    self.startX=0;
                    self.startY+=self.contentVSpace+self.contentH;
                }else{
                    btn.frame=CGRectMake(self.startX, self.startY, btnW, self.contentH);
                    self.startX=btnW;
                }
                
            }else{
                //保持当前行
                btn.frame=CGRectMake(endX-btnW, self.startY, btnW, self.contentH);
                self.startX=endX;
            }
        }
    }
    
    if (self.block) {
        self.block(self.startY+self.contentH);
        self.BTHeight = self.startY+self.contentH;
    }
    
}

- (void)clearData{
    [self.dataBtns removeAllObjects];
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    [self setNeedsLayout];
}

- (void)setData:(NSArray *)strs{
    NSInteger index=0;
    for (NSString * str in strs) {
        UIButton * btn=[[UIButton alloc]init];
        btn.tag = index;
        btn.titleLabel.font=self.textFont;
        btn.layer.cornerRadius=self.contentH/2;
        btn.titleLabel.textAlignment=NSTextAlignmentCenter;
        [btn setTitleColor:self.textColor forState:UIControlStateNormal];
        [btn setBackgroundColor:self.textBgColor];
        [btn setTitle:str forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.dataBtns addObject:btn];
        [self addSubview:btn];
        index++;
    }
}

- (void)btnClick:(id)sender{
    UIButton * btn = sender;
    if (self.blockClick) {
        self.blockClick(btn.tag);
    }
}

//选中某一个按钮
- (void)selectIndex:(NSInteger)index{
    UIButton * btn = self.dataBtns[index];
    if (self.textColorSel) {
        [btn setTitleColor:self.textColorSel forState:UIControlStateNormal];
    }
    
    if (self.textBgColorSel) {
        btn.backgroundColor = self.textBgColorSel;
    }
    
}

- (void)deSelectIndex:(NSInteger)index{
    UIButton * btn = self.dataBtns[index];
    if (self.textColor) {
        [btn setTitleColor:self.textColor forState:UIControlStateNormal];
    }
    
    if (self.textBgColor) {
        btn.backgroundColor = self.textBgColor;
    }
}

//取消所有的选中状态
- (void)deselectAll{
    for (UIButton * btn in self.dataBtns) {
        [btn setTitleColor:self.textColor forState:UIControlStateNormal];
        btn.backgroundColor = self.textBgColor;
    }
}

+ (CGFloat)calculateHeightWithStrs:(NSArray<NSString*>*)strs
                             width:(CGFloat)width
                          contentH:(CGFloat)contentH
                     contentHSpace:(CGFloat)contentHSpace
                     contentVSpace:(CGFloat)contentVSpace
                          textFont:(UIFont*)textFont
                  paddingLeftRight:(CGFloat)paddingLeftRight
{
    CGFloat height = 0;
    CGFloat startX=0;
    CGFloat startY=0;
    for (NSString * btnStr in strs) {
        CGFloat btnW=[btnStr bt_calculateStrWidth:contentH font:textFont];
        btnW+=paddingLeftRight * 2;//左右间隙
        
        CGFloat endX=0;
        if (startX==0) {
            //第一行的第一个
            endX=btnW+startX;
        }else{
            endX=btnW+contentHSpace+startX+4;
        }
        
        if (endX>=width &&startX==0) {
            //说明需要自己单独一行
           startY+=contentVSpace+contentH;
        }else{
            if (endX>=width) {
                //当前行的宽度不够，到下一行
                startX=0;
                startY+=contentVSpace+contentH;
                if (btnW>=width) {
                    //需要自己一行
                    startX=0;
                    startY+=contentVSpace+contentH;
                }else{
                    startX=btnW;
                }
            }else{
                //保持当前行
                startX=endX;
            }
        }
    }
    height = startY + contentH;
    return height;
}

@end
