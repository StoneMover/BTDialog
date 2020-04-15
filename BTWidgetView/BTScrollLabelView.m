//
//  SMScrollLabelView.m
//  Base
//
//  Created by whbt_mac on 15/11/11.
//  Copyright © 2015年 StoneMover. All rights reserved.
//

#import "BTScrollLabelView.h"
#import "UIView+BTViewTool.h"


@interface BTScrollLabelView ()<CAAnimationDelegate>


//当前文字
@property (nonatomic, strong) UILabel * label;

//下一个文字
@property (nonatomic, strong) UILabel * labelNext;

//是否已经停止
@property (nonatomic, assign) BOOL isStop;

//是否已经开始过了
@property (nonatomic, assign) BOOL isHasStarted;

@end

@implementation BTScrollLabelView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    [self initSMScrollLabel];
    return self;
}


-(void)initSMScrollLabel{
    self.isStop = YES;
    self.animTime = 10;
    self.margin = 30;
    self.label = [[UILabel alloc]init];
    self.labelNext = [[UILabel alloc]init];
    [self addSubview:self.labelNext];
    [self addSubview:self.label];
    self.clipsToBounds=YES;
    
    
    // app从后台进入前台都会调用这个方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActive) name:UIApplicationWillEnterForegroundNotification object:nil];
    // 添加检测app进入后台的观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnterBackground) name: UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)applicationBecomeActive{
    if (self.isHasStarted&&self.isStop) {
        [self start];
    }
}

-  (void)applicationEnterBackground{
    if (self.isHasStarted&&!self.isStop) {
        [self stop];
    }
}

-(void)layoutSubviews{
    self.label.left=0;
    self.label.centerY=self.height/2;
    self.labelNext.centerY=self.label.centerY;
    self.labelNext.left=self.label.right+30;
    if (self.label.right>self.width) {
        self.labelNext.hidden=NO;
    }else{
        self.labelNext.hidden=YES;
    }
}

-(void)stop{
    if (self.isStop) {
        return;
    }
    self.isStop=YES;
    [self.label.layer removeAllAnimations];
    [self.labelNext.layer removeAllAnimations];
    [self layoutSubviews];
}

-(void)start{
    if (!self.isStop) {
        return;
    }
    self.isHasStarted=YES;
    self.isStop=NO;
    if (!self.labelNext.hidden) {
        if (self.type==BTScrollLabelTypeRound) {
            [self startRound];
        }else if (self.type==BTScrollLabelTypeBy) {
            [self startBy:0];
        }
    }else{
        self.isStop=YES;
    }
}

-(void)startRound{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = self.animTime;
    animation.repeatCount = MAXFLOAT;
    animation.autoreverses = YES;
    animation.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fromValue = [NSValue valueWithCGPoint:self.label.center]; // 起始帧
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.label.center.x, self.label.center.y)];
    animation.delegate=self;
    [self.label.layer addAnimation:animation forKey:@"move-layer"];
}

-(void)startBy:(CGFloat)time{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = self.animTime;
    animation.repeatCount = 1;
    animation.autoreverses = NO;
    animation.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fromValue = [NSValue valueWithCGPoint:self.label.center]; // 起始帧
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(-self.label.frame.size.width/2-self.margin, self.label.center.y)];
    animation.removedOnCompletion=NO;
    animation.beginTime=CACurrentMediaTime()+time;
    [self.label.layer addAnimation:animation forKey:@"move-layer"];
    
    
    CABasicAnimation *animationNext = [CABasicAnimation animationWithKeyPath:@"position"];
    animationNext.duration = self.animTime;
    animationNext.repeatCount = 1;
    animationNext.autoreverses = NO;
    animationNext.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animationNext.fromValue = [NSValue valueWithCGPoint:self.labelNext.center]; // 起始帧
    animationNext.toValue = [NSValue valueWithCGPoint:CGPointMake(self.labelNext.frame.size.width/2, self.labelNext.center.y)];
    animationNext.removedOnCompletion=NO;
    animationNext.delegate=self;
    animationNext.beginTime=CACurrentMediaTime()+time;
    [self.labelNext.layer addAnimation:animationNext forKey:@"move-layer-next"];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (!self.isStop) {
        [self startBy:2];
    }
}



-(void)setStrData:(NSString *)strData{
    _strData=strData;
    if (self.font) {
        self.label.font=self.font;
        self.labelNext.font=self.font;
    }
    if (self.color) {
        self.label.textColor=self.color;
        self.labelNext.textColor=self.color;
    }
    self.label.text=strData;
    [self.label sizeToFit];
    [self.label.layer removeAllAnimations];
    
    self.labelNext.text=strData;
    [self.labelNext sizeToFit];
    [self.labelNext.layer removeAllAnimations];
    
    [self layoutSubviews];
    
}





@end
