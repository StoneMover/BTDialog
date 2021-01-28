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

//0:未曾调用过开始方法，1:正在进行动画，2：动画结束
@property (nonatomic, assign) NSInteger animStatus;

@end

@implementation BTScrollLabelView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    [self initSMScrollLabel];
    return self;
}


-(void)initSMScrollLabel{
    self.animTime = 10;
    self.margin = 30;
    self.nextAnimTime = 3;
    self.label = [[UILabel alloc]init];
    self.labelNext = [[UILabel alloc]init];
    [self addSubview:self.labelNext];
    [self addSubview:self.label];
    self.clipsToBounds=YES;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActive) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnterBackground) name: UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)applicationBecomeActive{
    if (self.animStatus == 0) return;
    [self start];
}

-  (void)applicationEnterBackground{
    if (self.animStatus == 0) return;
    [self stop];
}

-(void)layoutSubviews{
    self.label.BTLeft = 0;
    self.label.BTCenterY = self.BTHeight / 2;
    self.labelNext.BTCenterY = self.label.BTCenterY;
    self.labelNext.BTLeft = self.label.BTRight + self.margin;
    if (self.label.BTRight > self.BTWidth) {
        self.labelNext.hidden=NO;
    }else{
        self.labelNext.hidden=YES;
    }
}

-(void)stop{
    if (self.animStatus == 2 || self.animStatus == 0 || self.labelNext.hidden) {
        return;
    }
    
    self.animStatus = 2;
    [self.label.layer removeAllAnimations];
    [self.labelNext.layer removeAllAnimations];
    [self layoutSubviews];
}

-(void)start{
    if (self.animStatus == 1) return;
    if (self.labelNext.hidden) return;
    
    self.animStatus = 1;
    if (self.type==BTScrollLabelTypeRound) {
        [self startRound];
    }else if (self.type==BTScrollLabelTypeBy) {
        [self startBy];
    }
}

-(void)startRound{
    [UIView animateWithDuration:self.animTime delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionCurveLinear animations:^{
        self.label.BTRight = self.BTWidth;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)startBy{
    [UIView animateWithDuration:self.animTime delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.label.BTRight = - self.margin ;
        self.labelNext.BTLeft = 0;
    } completion:^(BOOL finished) {
        [self layoutSubviews];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.animStatus == 1) {
                [self startBy];
            }
        });
    }];
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
