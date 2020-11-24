//
//  BTStartView.m
//  民众投顾
//
//  Created by apple on 2020/1/15.
//  Copyright © 2020 ytsr. All rights reserved.
//

#import "BTStarView.h"


@interface BTStarView()

@property (nonatomic, assign) NSInteger totalNumber;

@property (nonatomic, strong) NSMutableArray * imgViewArray;

@property (nonatomic, assign) CGSize imgViewSize;

@property (nonatomic, strong) UIImage * starNormalImg;

@property (nonatomic, strong) UIImage * starSelectImg;

@end


@implementation BTStarView

- (instancetype)initWithNumber:(NSInteger)number imgViewSize:(CGSize)size imgSelect:(UIImage*)imgSelect imgNormal:(UIImage*)imgNormal{
    self = [super init];
    self.space = 10;
    self.totalNumber = number;
    self.imgViewSize = size;
    self.starNormalImg = imgNormal;
    self.starSelectImg = imgSelect;
    [self initSelf];
    return self;
}


- (void)initSelf{
    self.imgViewArray = [NSMutableArray new];
    for (int i=0; i<self.totalNumber; i++) {
        UIImageView * imgView = [[UIImageView alloc] init];
        imgView.image = self.starNormalImg;
        [self.imgViewArray addObject:imgView];
        [self addSubview:imgView];
    }
}

- (void)layoutSubviews{
    CGFloat startX = 0;
    for (UIImageView * imgView in self.imgViewArray) {
        imgView.frame = CGRectMake(startX, 0, self.imgViewSize.width, self.imgViewSize.height);
        startX = startX + self.space + self.imgViewSize.width;
    }
}

- (void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex = selectIndex;
    for (int i=0; i<self.imgViewArray.count; i++) {
        UIImageView * imgView = self.imgViewArray[i];
        if (i < selectIndex) {
            if (self.selectColor) {
                imgView.image = [self.starNormalImg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            }else{
                imgView.image = self.starSelectImg;
            }
            
        }else{
            imgView.image = self.starNormalImg;
        }
    }
}

- (CGFloat)calculateWidth{
    return self.imgViewSize.width * self.totalNumber + (self.totalNumber - 1) * self.space;
}

- (void)setSelectColor:(UIColor *)selectColor{
    _selectColor = selectColor;
    for (int i=0; i<self.imgViewArray.count; i++) {
        UIImageView * imgView = self.imgViewArray[i];
        imgView.tintColor = selectColor;
    }
}

@end


@implementation BTStarDrawView

- (instancetype)initWithRect:(CGRect)rect color:(UIColor*)color percent:(CGFloat)percent{
    self = [super initWithFrame:rect];
    
    [self creatViewWitNumber:percent color:color];
    
    return self;
}

-(void)creatViewWitNumber:(CGFloat)percent color:(UIColor*)color
{
    float R = self.frame.size.height/2;
    float r = R * sinf(M_PI * 18/180.0)/sinf(M_PI * 36/180.0);
    
    //用来画五角星
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    for(int i = 0;i<5;i++ )//
    {
        float x = R * cos(M_PI * 72/180.0 * i - M_PI * 18/180.0) + R;
        float y = R * sin(M_PI * 72/180.0 * i - M_PI * 18/180.0) + R;
        
        float x1 = r * cos(M_PI * 72/180.0 * i + M_PI * 36/180.0 - M_PI * 18/180.0) + R;
        float y1 = r * sin(M_PI * 72/180.0 * i + M_PI * 36/180.0 - M_PI * 18/180.0) + R;
        
        CGPoint point = CGPointMake(x, y);
        CGPoint point1 = CGPointMake(x1, y1);
        if(i == 0)
        {
            [path moveToPoint:point];
            [path addLineToPoint:point1];
        }else{
            [path addLineToPoint:point];
            [path addLineToPoint:point1];
        }
    }
    
    [path closePath];
    
    //外侧五角星框
    CAShapeLayer * slayer = [CAShapeLayer layer];
    slayer.frame = CGRectMake(self.frame.size.height, 0, self.frame.size.height, self.frame.size.height);
    slayer.path = path.CGPath;
    slayer.fillColor = [UIColor clearColor].CGColor;
    slayer.strokeColor = color.CGColor;
    slayer.lineWidth = 1;
    [self.layer addSublayer:slayer];
    
    //内侧五角星
    CAShapeLayer * slayer1 = [CAShapeLayer layer];
    slayer1.frame = CGRectMake(self.frame.size.height, 0, self.frame.size.height, self.frame.size.height);
    slayer1.path = path.CGPath;
    
    CALayer * layer1 = [CALayer layer];
    layer1.frame = CGRectMake(self.frame.size.height,
                              0,
                              self.frame.size.height * percent,
                              self.frame.size.height);
    layer1.backgroundColor = color.CGColor;
    layer1.mask = slayer1 ;
    [self.layer addSublayer:layer1];
}




@end
