# BTButton

提供系统没有的图片、文字布局样式

```
typedef NS_ENUM(NSInteger,BTButtonStyle) {
    BTButtonStyleVertical=0,//垂直，图片在上，文字在下
    BTButtonStyleHoz,//水平，图片在右，文字在左
    BTButtonStyleDefault//默认
};
```

提供长按监听

```
- (void)addLongPressWithTime:(CGFloat)second block:(BTBtnLongPressBlock)block;
```

提供```bage```数字展示

```
@property (nonatomic, strong) IBInspectable NSString * bageNum;
```


## BTLineView

绘制的细线

```
typedef NS_ENUM(NSInteger,BTLineViewOrientation) {
        BTLineViewHoz=0,
        BTLineViewVer
};

typedef NS_ENUM(NSInteger,BTLineViewAlignment) {
    BTLineViewAlignmentTop=0,
    BTLineViewAlignmentCenter,
    BTLineViewAlignmentBottom,
    BTLineViewAlignmentLeft,
    BTLineViewAlignmentRight
};
```


```
//线的粗细,默认0.5,没有特殊要求不需要设置
@property(nonatomic,assign) IBInspectable CGFloat lineWidth;

//线的颜色,默认[UIColor colorWithRed:0.235294 green:0.235294 blue:0.262745 alpha:0.29];
@property(nonatomic,strong) IBInspectable UIColor * color;

//方向,默认水平
@property(nonatomic,assign) IBInspectable NSInteger oriention;

//方位,垂直情况默认是居左,水平情况默认是居上
@property(nonatomic,assign) IBInspectable NSInteger aligntMent;
```


## BTStarView

星星分数图标


