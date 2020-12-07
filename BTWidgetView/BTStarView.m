//
//  BTStartView.m
//  民众投顾
//
//  Created by apple on 2020/1/15.
//  Copyright © 2020 ytsr. All rights reserved.
//

#import "BTStarView.h"


@interface BTStarView()

@property (nonatomic, assign) BTStarViewType type;

@property (nonatomic, assign) NSInteger totalNumber;

@property (nonatomic, strong) NSMutableArray * starViewArray;

@property (nonatomic, assign) CGSize imgViewSize;

@property (nonatomic, strong) UIColor * starColor;

@end


@implementation BTStarView

- (instancetype)initImgStarWithNum:(NSInteger)totalNum size:(CGFloat)size{
    self = [super init];
    self.type = BTStarViewTypeImg;
    self.totalNumber = totalNum;
    self.imgViewSize = CGSizeMake(size, size);
    [self initSelf];
    return self;
}
- (instancetype)initDrawStarWithNum:(NSInteger)totalNum size:(CGFloat)size starColor:(UIColor*)color{
    self = [super init];
    self.type = BTStarViewTypeDraw;
    self.totalNumber = totalNum;
    self.imgViewSize = CGSizeMake(size, size);
    self.starColor = color;
    [self initSelf];
    return self;
}

- (void)initSelf{
    self.speace = 10;
    self.starViewArray = [NSMutableArray new];
    if (self.type == BTStarViewTypeImg) {
        for (int i=0; i<self.totalNumber; i++) {
            UIImageView * imgView = [[UIImageView alloc] init];
            imgView.image = self.emptyStarImg;
            [self.starViewArray addObject:imgView];
            [self addSubview:imgView];
        }
    }else{
        for (int i=0; i<self.totalNumber; i++) {
            BTStarDrawView * starView = [[BTStarDrawView alloc] initWithRect:CGRectMake(0, 0, self.imgViewSize.width, self.imgViewSize.height) color:self.starColor];
            starView.percent = 0;
            [self.starViewArray addObject:starView];
            [self addSubview:starView];
        }
    }
    
}

- (void)layoutSubviews{
    CGFloat startX = 0;
    for (UIView * view in self.starViewArray) {
        view.frame = CGRectMake(startX, 0, self.imgViewSize.width, self.imgViewSize.height);
        startX = startX + self.speace + self.imgViewSize.width;
    }
}

- (void)setSelectIndex:(CGFloat)selectIndex{
    _selectIndex = selectIndex;
    NSInteger index = (NSInteger)selectIndex;
    if (self.type == BTStarViewTypeImg) {
        if (self.halfStarImg) {
            for (int i=0; i<self.starViewArray.count; i++) {
                UIImageView * imgView = self.starViewArray[i];
                if (i < index) {
                    imgView.image = self.fullStarImg;
                }else if(i == index && selectIndex - index >= 0.5){
                    imgView.image = self.halfStarImg;
                }else{
                    imgView.image = self.emptyStarImg;
                }
            }
        }else{
            for (int i=0; i<self.starViewArray.count; i++) {
                UIImageView * imgView = self.starViewArray[i];
                if (i < selectIndex) {
                    imgView.image = self.fullStarImg;
                }else{
                    imgView.image = self.emptyStarImg;
                }
            }
        }
        
    }else{
        
        for (int i=0; i<self.starViewArray.count; i++) {
            BTStarDrawView * starView = self.starViewArray[i];
            if (i < index) {
                starView.percent = 1;
            }else if(i == index){
                starView.percent = selectIndex - index;
            }else{
                starView.percent = 0;
            }
        }
    }
}

- (CGFloat)calculateWidth{
    return self.imgViewSize.width * self.totalNumber + (self.totalNumber - 1) * self.speace;
}


@end



@interface BTStarDrawView()

@property (nonatomic, strong) UIColor * starColor;

@property (nonatomic, strong) NSMutableArray * starLayers;

@end


@implementation BTStarDrawView

- (instancetype)initWithRect:(CGRect)rect color:(UIColor*)color{
    self = [super initWithFrame:rect];
    self.starColor = color;
    self.starLayers = [NSMutableArray new];
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    for (CALayer * layer in self.starLayers) {
        [layer removeFromSuperlayer];
    }
    
    float R = rect.size.height/2;
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
        if(i == 0){
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
    slayer.frame = CGRectMake(0,0,rect.size.width,rect.size.height);
    slayer.path = path.CGPath;
    slayer.fillColor = [UIColor clearColor].CGColor;
    slayer.strokeColor = self.starColor.CGColor;
    slayer.lineWidth = 1;
    [self.starLayers addObject:slayer];
    [self.layer addSublayer:slayer];
    
    //内侧五角星
    CAShapeLayer * slayer1 = [CAShapeLayer layer];
    slayer1.frame = CGRectMake(0, 0, rect.size.width * self.percent, rect.size.height);
    slayer1.path = path.CGPath;
    
    CALayer * layer1 = [CALayer layer];
    layer1.frame = CGRectMake(0,0,rect.size.width * self.percent,rect.size.height);
    layer1.backgroundColor = self.starColor.CGColor;
    layer1.mask = slayer1 ;
    [self.starLayers addObject:layer1];
    [self.layer addSublayer:layer1];
}

- (void)setPercent:(CGFloat)percent{
    _percent = percent;
    [self setNeedsDisplay];
}




@end
