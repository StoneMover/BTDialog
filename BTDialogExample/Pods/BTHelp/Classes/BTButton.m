//
//  BTVerticalButton.m
//  VoiceBag
//
//  Created by HC－101 on 2018/6/20.
//  Copyright © 2018年 王迅. All rights reserved.
//

#import "BTButton.h"
#import "UIView+BTViewTool.h"
#import "BTMacro.h"

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
    self.labelBage.layer.cornerRadius=6;
    self.labelBage.clipsToBounds=YES;
    self.labelBage.textColor=[UIColor whiteColor];
    self.labelBage.backgroundColor=BT_RGB(247, 89, 89);
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
        self.labelBage.height=12;
        if (self.labelBage.width+4<16) {
            self.labelBage.width=16;
        }else{
            self.labelBage.width+=4;
        }
        
        self.labelBage.center=CGPointMake(self.imageView.right+self.lefDistance, self.imageView.top+self.topDistance);
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
    [self setNeedsDisplay];
}

@end
