//
//  BTStartView.h
//  民众投顾
//
//  Created by apple on 2020/1/15.
//  Copyright © 2020 ytsr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTStarView : UIView

//需要的总星数量，图片的大小，选中的样式，未选中的样式
- (instancetype)initWithNumber:(NSInteger)number imgViewSize:(CGSize)size imgSelect:(UIImage*)imgSelect imgNormal:(UIImage*)imgNormal;

//需要选中的星星数量
@property (nonatomic, assign) NSInteger selectIndex;

//左右之间的间隔，默认10
@property (nonatomic, assign) CGFloat space;

//设置选中的颜色，设置后将不用imgSelect对象，直接渲染imgNormal
@property (nonatomic, strong) UIColor * selectColor;

- (CGFloat)calculateWidth;

@end


