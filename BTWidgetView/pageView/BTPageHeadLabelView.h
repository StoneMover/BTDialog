//
//  BTPageHeadLabelView.h
//  live
//
//  Created by stonemover on 2019/7/30.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "BTPageHeadView.h"

@interface BTPageHeadLabelView : BTPageHeadView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles style:(BTPageHeadViewStyle)style;

//选中字体大小
@property (nonatomic, assign) CGFloat selectFontSize;

//未选中字体大小
@property (nonatomic, assign) CGFloat normalFontSize;

//选中文字颜色
@property (nonatomic, strong) UIColor * selectColor;

//未选中文字颜色
@property (nonatomic, strong) UIColor * normalColor;

//将label恢复到出事状态，解决初始化的时候颜色不更新问题
- (void)unSelectLabel:(NSInteger)index;

@end


