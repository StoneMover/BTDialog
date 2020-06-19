//
//  BTGridImgView.h
//  word
//
//  Created by liao on 2019/12/22.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BTGridImgViewDelegate <NSObject>

@optional

- (void)BTGridImgViewClick:(NSInteger)index;

- (void)BTGridImgAddClick;

- (void)BTGridImgLongPress:(NSInteger)index;

- (void)BTGridLoadImg:(NSInteger)index imgView:(UIImageView*)imgView;

@end

@interface BTGridImgView : UIView

//数据可以为UIimage对象，也可以为任意类型，如果不是UIimage对象则需要实现BTGridLoadImg代理自己进行赋值
@property (nonatomic, strong) NSMutableArray * dataArray;

//有多少列
@property (nonatomic, assign) NSInteger line;

//上下左右的间距
@property (nonatomic, assign) CGFloat space;

//允许显示的最大图片数量
@property (nonatomic, assign) NSInteger maxNumber;

//加号图片
@property (nonatomic, strong) UIImage * addImg;

//容器的高度，实时计算
@property (nonatomic, assign,readonly) CGFloat contentHeight;

@property (nonatomic, weak) id<BTGridImgViewDelegate> delegate;


- (void)reloadData;

- (void)removeDataAtIndex:(NSInteger)index;

@end



@interface BTGridImgViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView * imgViewContent;

@property (nonatomic, copy) void(^longPressBlock) (void);

@end



