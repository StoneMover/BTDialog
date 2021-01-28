//
//  BTStartView.h
//  民众投顾
//
//  Created by apple on 2020/1/15.
//  Copyright © 2020 ytsr. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,BTStarViewType) {
    BTStarViewTypeImg = 0,
    BTStarViewTypeDraw
};

@interface BTStarView : UIView

- (instancetype)initImgStarWithNum:(NSInteger)totalNum size:(CGFloat)size;

//当normalColor为空则显示为边框样式，不为空则为填充样式
- (instancetype)initDrawStarWithNum:(NSInteger)totalNum size:(CGFloat)size selectColor:(UIColor*)selectColor normalColor:(UIColor *_Nullable)normalColor;

//填充的星星图片，BTStarViewTypeImg下使用
@property (nonatomic, strong) UIImage * fullStarImg;

//半填充星星图片，如果有支持3.5星数据
@property (nonatomic, strong) UIImage * halfStarImg;

//未填充星星图片，BTStarViewTypeImg下使用
@property (nonatomic, strong) UIImage * emptyStarImg;

//每两个星星左右之间的间隔，默认10
@property (nonatomic, assign) CGFloat speace;

// 计算出所需要的宽度
- (CGFloat)calculateWidth;

/*
 需要选中的星星数量,在所有参数设置完毕后调用
 BTStarViewTypeImg:halfStarImg不为空支持四舍五入显示半颗星星功能
 BTStarViewTypeDraw: 支持小数显示模式
 */
@property (nonatomic, assign) CGFloat selectIndex;

//是否可以选择星星选中数量
@property (nonatomic, assign) BOOL isCanTouchSelect;

@property (nonatomic, copy) void(^selectIndexTouchChange)(void);

@end


@interface BTStarDrawView : UIView

//当normalColor为空则显示为边框样式，不为空则为填充样式
- (instancetype)initWithRect:(CGRect)rect selectColor:(UIColor*)selectColor normalColor:(UIColor *_Nullable)normalColor;

//0.0~1.0
@property (nonatomic, assign) CGFloat percent;


@end


NS_ASSUME_NONNULL_END
