//
//  BTVerticalButton.h
//  VoiceBag
//
//  Created by HC－101 on 2018/6/20.
//  Copyright © 2018年 stonemover. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BTButtonStyle) {
    BTButtonStyleVertical=0,//垂直，图片在上，文字在下
    BTButtonStyleHoz,//水平，图片在右，文字在左
    BTButtonStyleDefault//默认
};

typedef void(^BTBtnLongPressBlock)(void);

@interface BTButton : UIButton

//样式
@property (nonatomic, assign) IBInspectable NSInteger style;

//图片和文字的间距
@property (nonatomic, assign) IBInspectable CGFloat  margin;

//-1隐藏,bageNum是在有图片的时候，根据图片的位置显示在图片的右上角
@property (nonatomic, strong) IBInspectable NSString * bageNum;

//bageNumColor
@property (nonatomic, strong) IBInspectable UIColor * bageNumColor;

//bage距离默认中心的偏移量
@property (nonatomic, assign) IBInspectable CGFloat topDistance;

//bage距离默认中心的偏移量
@property (nonatomic, assign) IBInspectable CGFloat lefDistance;

//labelBage
@property (nonatomic, strong) UILabel * labelBage;

//labelBageHeight
@property (nonatomic, assign) CGFloat labelBageHeight;

//添加长按监听
- (void)addLongPressWithTime:(CGFloat)second block:(BTBtnLongPressBlock)block;

@end
