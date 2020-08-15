//
//  BTGridImgView.m
//  word
//
//  Created by liao on 2019/12/22.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "BTGridImgView.h"
#import "UIView+BTViewTool.h"

@interface BTGridImgView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * collectionView;

@end


@implementation BTGridImgView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self initSelf];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self initSelf];
    return self;
}

- (void)initSelf{
    self.space = 10;
    self.line = 3;
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    [self addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = UIColor.whiteColor;
    [self.collectionView registerClass:[BTGridImgViewCell class] forCellWithReuseIdentifier:@"BTGridImgViewCellId"];
    self.collectionView.scrollEnabled = NO;
}

- (void)layoutSubviews{
    self.collectionView.frame = self.bounds;
}

#pragma mark uicollection delegate
//cell 数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.dataArray.count == self.maxNumber) {
        return  self.dataArray.count;
    }
    return self.dataArray.count+1;
}

//返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    __weak BTGridImgView * weakSelf=self;
    BTGridImgViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"BTGridImgViewCellId"
                                                                          forIndexPath:indexPath];
    if (indexPath.row == self.dataArray.count) {
        cell.imgViewContent.image = self.addImg;
    }else{
        NSObject * objc = self.dataArray[indexPath.row];
        if ([objc isKindOfClass:[UIImage class]]) {
            cell.imgViewContent.image  = self.dataArray[indexPath.row];
        }else{
            if (self.delegate&&[self.delegate respondsToSelector:@selector(BTGridLoadImg:imgView:)]) {
                [self.delegate BTGridLoadImg:indexPath.row imgView:cell.imgViewContent];
            }
        }
        
    }
    cell.longPressBlock = ^{
        if (weakSelf.delegate&&[weakSelf.delegate respondsToSelector:@selector(BTGridImgLongPress:)]&&indexPath.row!=self.dataArray.count) {
            [weakSelf.delegate BTGridImgLongPress:indexPath.row];
        }
    };
    return cell;
}

//每个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = [self cellWidth];
    CGFloat height = width;
    return CGSizeMake(width, height);
}


//左右间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return self.space;
}

//上下间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return self.space;
}

//点击cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate) {
        if (indexPath.row == self.dataArray.count&&[self.delegate respondsToSelector:@selector(BTGridImgAddClick)]) {
            [self.delegate BTGridImgAddClick];
            return;
        }
        
        if ([self.delegate respondsToSelector:@selector(BTGridImgViewClick:)]) {
            [self.delegate BTGridImgViewClick:indexPath.row];
        }
    }
}


- (CGFloat)contentHeight{
    if (self.dataArray.count==0) {
        return [self cellWidth];
    }
    NSInteger line = 0;
    NSInteger totalDataNum = self.dataArray.count;
    if (self.dataArray.count != self.maxNumber) {
        totalDataNum++;
    }
    if (totalDataNum % self.line ==0) {
        line = totalDataNum / self.line;
    }else{
        line = totalDataNum / self.line +1;
    }
    
    return [self cellWidth]*line + self.space*(line-1);
}

- (CGFloat)cellWidth{
    return (self.BTWidth - (self.line-1)*self.space)/self.line;
}

- (void)setDataArray:(NSMutableArray*)dataArray{
    _dataArray = dataArray;
}

- (void)reloadData{
    [self.collectionView reloadData];
}

- (void)removeDataAtIndex:(NSInteger)index{
    [self.dataArray removeObjectAtIndex:index];
    [self reloadData];
}


@end


@implementation BTGridImgViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self initSelf];
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self addGestureRecognizer:longPress];
    return  self;
}


- (void)longPress:(UILongPressGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        if (self.longPressBlock) {
            self.longPressBlock();
        }
    }
}

- (void)initSelf{
    self.imgViewContent = [UIImageView new];
    self.imgViewContent.contentMode = UIViewContentModeScaleAspectFill;
    self.imgViewContent.clipsToBounds = YES;
    [self addSubview:self.imgViewContent];
}

- (void)layoutSubviews{
    self.imgViewContent.frame = self.bounds;
}

@end

