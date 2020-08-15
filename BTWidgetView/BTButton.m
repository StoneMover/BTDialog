//
//  BTVerticalButton.m
//  VoiceBag
//
//  Created by HC－101 on 2018/6/20.
//  Copyright © 2018年 stonemover. All rights reserved.
//

#import "BTButton.h"
#import "UIView+BTViewTool.h"
#import <BTHelp/BTUtils.h>
#import <BTHelp/UIColor+BTColor.h>

@interface BTButton()

@property (nonatomic, copy) BTBtnLongPressBlock longPressBlock;

@end


@implementation BTButton

-(void)awakeFromNib{
    [super awakeFromNib];
    [self initSelf];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    [self initSelf];
    return self;
}

- (void)initSelf{
    self.labelBage=[[UILabel alloc] init];
    self.labelBage.textAlignment=NSTextAlignmentCenter;
    self.labelBage.font=[UIFont systemFontOfSize:8 weight:UIFontWeightSemibold];
    self.labelBage.layer.cornerRadius=self.labelBageHeight==0?6:self.labelBageHeight/2.0;
    self.labelBage.clipsToBounds=YES;
    self.labelBage.textColor=[UIColor whiteColor];
    self.labelBage.backgroundColor=[UIColor bt_R:247 G:89 B:89];
    [self addSubview:self.labelBage];
}



-(void)layoutSubviews {
    [super layoutSubviews];
    switch (self.style) {
        case BTButtonStyleVertical:
        {
            // Center image
            CGPoint center = self.imageView.center;
            center.x = self.frame.size.width/2;
            center.y = self.frame.size.height/2-(self.imageView.frame.size.height+self.titleLabel.frame.size.height+self.margin)/2+self.imageView.frame.size.height/2;
            
            self.imageView.center = center;
            
            //Center text
            CGRect newFrame = [self titleLabel].frame;
            newFrame.origin.x = 0;
            newFrame.origin.y = self.imageView.frame.size.height + self.margin+self.imageView.frame.origin.y;
            
            newFrame.size.width = self.frame.size.width;
            
            self.titleLabel.frame = newFrame;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
        case BTButtonStyleHoz:
        {
            CGFloat startX=self.frame.size.width/2-(self.titleLabel.frame.size.width+self.margin+self.imageView.frame.size.width)/2;
            
            self.titleLabel.frame=CGRectMake(startX, self.frame.size.height/2-self.titleLabel.frame.size.height/2, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
            self.imageView.frame=CGRectMake(self.titleLabel.frame.size.width+self.titleLabel.frame.origin.x+self.margin, self.frame.size.height/2-self.imageView.frame.size.height/2, self.imageView.frame.size.width, self.imageView.frame.size.height);
            
        }
            break;
    }
    
    if (!self.bageNum) {
        self.labelBage.hidden=YES;
    }else{
        self.labelBage.hidden=NO;
        self.labelBage.text=self.bageNum;
        [self.labelBage sizeToFit];
        self.labelBage.BTHeight=self.labelBageHeight==0?12:self.labelBageHeight;
        if (self.labelBage.BTWidth>self.labelBage.BTHeight) {
            self.labelBage.BTWidth+=4;
        }else{
            self.labelBage.BTWidth=self.labelBage.BTHeight;
        }
        
        self.labelBage.center=CGPointMake(self.imageView.BTRight+self.lefDistance, self.imageView.BTTop+self.topDistance);
    }
    
    
    
}

-(void)setMargin:(CGFloat)margin{
    _margin=margin;
    [self setNeedsDisplay];
}

- (void)setStyle:(NSInteger)style{
    _style=style;
    [self setNeedsDisplay];
}

- (void)setBageNum:(NSString *)bageNum{
    _bageNum=bageNum;
    self.labelBage.text=self.bageNum;
    [self layoutSubviews];
}

- (void)addLongPressWithTime:(CGFloat)second block:(BTBtnLongPressBlock)block{
    self.longPressBlock = block;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    longPress.minimumPressDuration = second; //定义按的时间
    [self addGestureRecognizer:longPress];
}

- (void)longPressAction:(UILongPressGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        if (self.longPressBlock) {
            self.longPressBlock();
        }
    }
}

@end
