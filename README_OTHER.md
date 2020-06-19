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

星星分数控件


![图片.png](https://upload-images.jianshu.io/upload_images/1243802-7c9478e3111e19e3.png)

```
self.starView = [[BTStartView alloc] initWithNumber:5 imgViewSize:CGSizeMake(15, 15) imgSelect:[UIImage imageNamed:@"star"] imgNormal:[UIImage imageNamed:@"star"]];
self.starView.selectColor = [BTUtils RGB:255 G:181 B:95];

self.starView.height = 20;
self.starView.width = [self.starView calculateWidth];
```

## BTContentAutoView

类似于搜索推荐或者搜索历史记录的自动填充数据控件

![图片.png](https://upload-images.jianshu.io/upload_images/1243802-9e2bf24f4bfb1c19.png)

使用

```
- (void)initHistoryView{
    __weak TestContentAutoViewController * weakSelf=self;
    NSArray * data = @[@"雪花飘飘",@"我是一只小小鸟",@"阿瓦大啃大瓜",@"君威GS",@"迈锐宝XL",@"蒙迪欧",@"标志内饰最好看",@"张翼德",@"关云长",@"我的马儿",@"曹孟德",@"许攸辱我"];
    
    self.contentView = [[BTContentAutoView alloc] initWithFrame:CGRectMake(10, self.headView.bottom + 20, BTUtils.SCREEN_W - 20, 400)];
    self.contentView.textColor = UIColor.whiteColor;
    self.contentView.textFont = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
    self.contentView.paddingLeftRight = 7;
    self.contentView.textBgColor = UIColor.redColor;
    self.contentView.contentHSpace = 15;
    self.contentView.blockClick = ^(NSInteger index) {
        weakSelf.headView.textFieldSearch.text = data[index];
    };
    
    self.contentView.block = ^(CGFloat resultH) {
        
    };
    
    
    [self.contentView setData:data];
    [self.view addSubview:self.contentView];
}
```

如果你在列表中使用类似布局，通过如下方法计算高度

![图片.png](https://upload-images.jianshu.io/upload_images/1243802-20a15328b2bbc1fa.png)

```
+ (CGFloat)calculateHeightWithStrs:(NSArray<NSString*>*)strs
                             width:(CGFloat)width
                          contentH:(CGFloat)contentH
                     contentHSpace:(CGFloat)contentHSpace
                     contentVSpace:(CGFloat)contentVSpace
                          textFont:(UIFont*)textFont
                  paddingLeftRight:(CGFloat)paddingLeftRight;
```

## BTGridImgView

类似于发布社交动态的时候选择图片的控件

![图片.png](https://upload-images.jianshu.io/upload_images/1243802-b88cd3dd332ef500.png)

使用

```
- (void)initGridView{
    self.gridImgView = [[BTGridImgView alloc] initWithFrame:CGRectMake(20, 20, BTUtils.SCREEN_W - 40, 0)];
    self.gridImgView.line = 3;
    self.gridImgView.maxNumber = 9;
    self.gridImgView.space = 10;
    self.gridImgView.addImg = [UIImage imageNamed:@"add"];
    
    self.gridImgView.dataArray = [NSMutableArray new];
    self.gridImgView.height = self.gridImgView.contentHeight;
    self.gridImgView.delegate = self;
    
    [self.view addSubview:self.gridImgView];
    [self.gridImgView reloadData];
}
```

实现代理方法

```
//点击照片，你可以做一些自己的交互，比如进入详情展示
- (void)BTGridImgViewClick:(NSInteger)index{
    
}

//进行你自己的照片添加逻辑
- (void)BTGridImgAddClick{
    __weak TestGridImageViewController * weakSelf=self;
    if (!self.iconHelp) {
        self.iconHelp = [[BTIconHelp alloc] init:self];
        self.iconHelp.block = ^(UIImage *image) {
            [weakSelf.gridImgView.dataArray addObject:image];
            weakSelf.gridImgView.height = weakSelf.gridImgView.contentHeight;
            [weakSelf.gridImgView reloadData];
        };
    }
    
    [self.iconHelp go];
}

//长按照片，你可以做一些自己的交互，比如提示是否删除
- (void)BTGridImgLongPress:(NSInteger)index{
    BTAlertLabelView * alert = [[BTAlertLabelView alloc] initWithTitle:@"提示" msg:@"是否删除?"];
    [alert showCenter];
    alert.okBlock = ^BOOL{
        [self.gridImgView removeDataAtIndex:index];
        self.gridImgView.height = self.gridImgView.contentHeight;
        [self.gridImgView reloadData];
        return YES;
    };
}

//如果你的dataArray数组中的对象不全是UIImage对戏，那么在这里进行imageView的赋值
- (void)BTGridLoadImg:(NSInteger)index imgView:(UIImageView*)imgView{
    
}

```

## BTSlideView

侧滑控件

![图片.png](https://upload-images.jianshu.io/upload_images/1243802-931f00646101be17.png)

使用

```
UIView * viewBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BTUtils.SCREEN_W - 150, BTUtils.SCREEN_H)];
viewBg.backgroundColor = UIColor.redColor;
    
BTSlideView * slideView = [[BTSlideView alloc] initWithSlideView:viewBg style:BTSlideStyleRight];
[slideView show:BTUtils.APP_WINDOW];
```

## BTProgressView

进度条


![图片.png](https://upload-images.jianshu.io/upload_images/1243802-eee4410e44dd617c.png)

使用

```
- (void)initProgressView{
    BTProgressView * progressView = [[BTProgressView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    progressView.backgroundColor = UIColor.redColor;
    progressView.progressView.backgroundColor = UIColor.whiteColor;
    progressView.type = 0;
    progressView.percent = 0.25;
}

```

## BTVerticalAnimView

可以进行垂直或者水平方向的滚动容器，效果详见```Demo```-```TestVerticalAnimViewController```

```
BTVerticalAnimView * verticalView = [[BTVerticalAnimView alloc]initWithFrame:CGRectMake(40, 40, 200, 40) padding:5 pauseTime:2];
verticalView.delegate = self;
verticalView.isHoz = YES;
[verticalView reload];
[self.view addSubview:verticalView];
```

实现代理

```
- (UIView*)BTVerticalAnimView:(BTVerticalAnimView*)view viewWithIndex:(NSInteger)index{
    UILabel * label =(UILabel*) [view getCacheView];
    if (label == nil) {
        label = [[UILabel alloc] init];
        label.backgroundColor = UIColor.redColor;
    }
    label.text = [NSString stringWithFormat:@"%ld",index];
    return label;
}

- (NSInteger)BTVerticalAnimViewNumOfRows:(BTVerticalAnimView*)view{
    return 10;
}

```

## BTScrollLabelView

跑马灯效果，效果详见```Demo```-```TestVerticalAnimViewController```

```
BTScrollLabelView * labelView = [[BTScrollLabelView alloc] initWithFrame:CGRectMake(40, 100, 200, 40)];
    
labelView.type = BTScrollLabelTypeBy;
labelView.color = UIColor.redColor;
labelView.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
labelView.margin = 10;
labelView.animTime = 3;
//设置上面的属性要在设置strData之前进行
labelView.strData = @"我是一个快乐的跑马灯，不知疲倦的漫天跑，到底是累";
[self.view addSubview:labelView];
//给一些延时，让界面完成布局后再开启动画
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     [labelView start];
});
```