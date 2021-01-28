//
//  SlideView.m
//  BTWidgetViewExample
//
//  Created by apple on 2020/5/8.
//  Copyright © 2020 stone. All rights reserved.
//

#import "BTSlideView.h"
#import <BTHelp/BTUtils.h>
#import "UIView+BTViewTool.h"
#import <BTHelp/UIColor+BTColor.h>

@interface BTSlideView()

@property (nonatomic, assign) BTSlideStyle style;

@property (nonatomic, strong) UIView * slideView;

@property (nonatomic, assign) NSTimeInterval beginTime;

@property (nonatomic, assign) NSInteger changeTime;

@end


@implementation BTSlideView

- (instancetype)initWithSlideView:(UIView*)slideView style:(BTSlideStyle)style{
    self = [super init];
    self.slideView = slideView;
    self.style = style;
    [self addSubview:self.slideView];
    [self addGesture];
    return self;
}

- (void)addGesture{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    
    [self addGestureRecognizer:tap];
    [self addGestureRecognizer:pan];
    
}

- (void)tap:(UITapGestureRecognizer*)tap{
    CGPoint point = [tap locationInView:self];
    switch (self.style) {
        case BTSlideStyleLeft:
            if (point.x > self.slideView.BTWidth) {
                [self dismiss];
            }
            break;
        case BTSlideStyleRight:
            if (point.x < self.BTWidth - self.slideView.BTWidth) {
                [self dismiss];
            }
            break;
    }
    
}

- (void)panView:(UIPanGestureRecognizer *)sender{
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
//            NSLog(@"UIGestureRecognizerStateBegan");
            self.changeTime = 0;
            self.beginTime = [[[NSDate alloc] init] timeIntervalSince1970];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            
            if (self.changeTime>4) {
//                NSLog(@"UIGestureRecognizerStateChanged");
                CGPoint transP = [sender translationInView:self];
                CGFloat x = transP.x;
                
                self.slideView.BTLeft += x;
                switch (self.style) {
                    case BTSlideStyleLeft:
                        if (self.slideView.BTLeft > 0) {
                            self.slideView.BTLeft = 0;
                        }

                        if (self.slideView.BTLeft < -self.slideView.BTWidth) {
                            self.slideView.BTLeft = -self.slideView.BTWidth;
                        }

                        break;
                    case BTSlideStyleRight:
                        if (self.slideView.BTLeft < self.BTWidth - self.slideView.BTWidth) {
                            self.slideView.BTLeft = self.BTWidth - self.slideView.BTWidth;
                        }

                        if (x > self.BTWidth) {
                            self.slideView.BTLeft = self.BTWidth;
                        }
                        break;
                }
            }else{
//                NSLog(@"UIGestureRecognizerStateChanged没有来");
            }
            self.changeTime++;
            [sender setTranslation:CGPointZero inView:self];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            NSTimeInterval endTime = [[[NSDate alloc] init] timeIntervalSince1970];
//            NSLog(@"开始时间:%f,结束时间:%f,耗时:%f",self.beginTime,endTime,endTime-self.beginTime);
            if (endTime-self.beginTime < 0.2) {
                [self dismiss];
                return;
            }
//            NSLog(@"UIGestureRecognizerStateEnded");
            switch (self.style) {
                case BTSlideStyleLeft:
                    if (fabs(0 - self.slideView.BTLeft) > self.slideView.BTWidth / 3.0) {
                        [self dismiss];
                    }else{
                        [UIView animateWithDuration:.3 animations:^{
                            self.slideView.BTLeft = 0;
                        }];
                    }

                    break;
                case BTSlideStyleRight:
                    if (fabs(self.BTWidth - self.slideView.BTWidth - self.slideView.BTLeft) > self.slideView.BTWidth / 3.0) {
                        [self dismiss];
                    }else{
                        [UIView animateWithDuration:.3 animations:^{
                            self.slideView.BTLeft = self.BTWidth - self.slideView.BTWidth;
                        }];
                    }
                    break;
            }
        }
            break;
        case UIGestureRecognizerStatePossible:
//            NSLog(@"UIGestureRecognizerStatePossible");
            break;
        case UIGestureRecognizerStateCancelled:
//            NSLog(@"UIGestureRecognizerStateCancelled");
            break;
        case UIGestureRecognizerStateFailed:
//            NSLog(@"UIGestureRecognizerStateFailed");
            break;
    }
    
    
    
}


- (void)show:(UIView *)parentView{
    self.backgroundColor = [UIColor bt_RGBASame:0 A:0];
    self.frame = parentView.bounds;
    [parentView addSubview:self];
    switch (self.style) {
        case BTSlideStyleLeft:
            self.slideView.BTLeft = -self.slideView.BTWidth;
            break;
        case BTSlideStyleRight:
            self.slideView.BTLeft = self.BTWidth;
            break;
    }
    [UIView animateWithDuration:.3 animations:^{
        self.backgroundColor = [UIColor bt_RGBASame:0 A:0.65];
        switch (self.style) {
            case BTSlideStyleLeft:
                self.slideView.BTLeft = 0;
                break;
            case BTSlideStyleRight:
                self.slideView.BTLeft = self.BTWidth - self.slideView.BTWidth;
                break;
        }
    }];
}



- (void)dismiss{
    [UIView animateWithDuration:.3 animations:^{
        self.backgroundColor = [UIColor bt_RGBASame:0 A:0];
        switch (self.style) {
            case BTSlideStyleLeft:
                self.slideView.BTLeft = -self.slideView.BTWidth;
                break;
            case BTSlideStyleRight:
                self.slideView.BTLeft = self.BTWidth;
                break;
        }
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
