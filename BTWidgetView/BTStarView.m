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
