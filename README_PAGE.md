# BTPageView

左右滑动的```page```控件，可基于```UIView```、```UIViewController```展示，支持头部自定义

[GIF](https://upload-images.jianshu.io/upload_images/1243802-f7acb17be4624935.gif)

初始化```pageView```

```
self.pageView=[[BTPageView alloc] initWithFrame:self.view.bounds];
self.pageView.dataSource=self;
self.pageView.delegate=self;
```

初始化```headView```，如果不需要则在实现的协议中反回空即可

```
self.headView=[[BTPageHeadLabelView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40) titles:@[@"第0项",@"第1项第1项第1项第1项",@"第2项第1项第1项",@"第3项"] style:BTPageHeadViewStyleDefault];
```

实现```BTPageViewDataSource```、```BTPageViewDelegate```协议

```
- (NSInteger)pageNumOfView:(BTPageView*)pageView{
    return 9;
}

- (UIView*)pageView:(BTPageView*)pageView contentViewForIndex:(NSInteger)index{
    UILabel * label =[[UILabel alloc] init];
    label.font=[UIFont systemFontOfSize:146 weight:UIFontWeightBold];
    label.text=[NSString stringWithFormat:@"%ld",index];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=BTUtils.RANDOM_COLOR;
    label.backgroundColor=BTUtils.RANDOM_COLOR;
    return label;
}

//为空则不显示headView
- (BTPageHeadView*)pageViewHeadView:(BTPageView*)pageView{
    return self.headView;
}

- (CGRect)pageViewContentFrame:(BTPageView*)pageView{
    return CGRectMake(0, 40, self.view.width, self.view.height-40);
}

- (CGPoint)pageViewHeadOrigin:(BTPageView *)pageView{
    return CGPointMake(0, 0);
}

- (void)pageView:(BTPageView*)pageView didShow:(NSInteger)index{
    
}

- (void)pageView:(BTPageView*)pageView didDismiss:(NSInteger)index{
    
}

```

刷新数据

```
[self.pageView reloadData];
```

如果你的```headView```需要放在导航器上，那么在代理中返回空，设置如下属性关联即可

```
//外部自由摆放位置的head
@property (nonatomic, strong) BTPageHeadView * headViewOut;
```

## BTPageHeadLabelView

如果你的顶部只有文字样式那么使用```BTPageHeadLabelView```

初始化

```
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles style:(BTPageHeadViewStyle)style;
```

相关属性

```
//选中字体大小
@property (nonatomic, assign) CGFloat selectFontSize;

//未选中字体大小
@property (nonatomic, assign) CGFloat normalFontSize;

//选中文字颜色
@property (nonatomic, strong) UIColor * selectColor;

//未选中文字颜色
@property (nonatomic, strong) UIColor * normalColor;

```


## BTPageHeadView

需要定制自定义的头部样式使用```BTPageHeadView```

使用```frame```方式初始化后设置```BTPageHeadViewDataSource```代理，在代理中返回每一个自定义的头部```view```

```
- (NSInteger)pageHeadViewNumOfItem:(BTPageHeadView*)headView;

- (UIView*)pageHeadView:(BTPageHeadView*)headView contentViewForIndex:(NSInteger)index;

- (BTPageHeadViewStyle)pageHeadViewStyle:(BTPageHeadView*)headView;
```


## BTPageViewController

基于```vc```的使用类型，创建一个```vc```继承于```BTPageViewController```

```
self.dataSource=self;
self.delegate=self;
```

初始化头部```view```

```
self.headView=[[BTPageHeadLabelView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40) titles:@[@"第0项",@"第1项",@"第2项",@"第3项"] style:BTPageHeadViewStyleAverage];
[self.headView initViewIndicator:CGSizeMake(15, 2) corner:0 bgColor:UIColor.redColor];
```

实现协议方法

```
- (NSInteger)pageNumOfVc:(BTPageViewController*)pageView{
    return 4;
}

- (UIViewController*)pageVc:(BTPageViewController*)pageVc vcForIndex:(NSInteger)index{
    PageChildVcViewController * vc =[PageChildVcViewController new];
    vc.index=index;
    return vc;
}

//为空则不显示headView
- (BTPageHeadView*)pageVcHeadView:(BTPageViewController*)pageVc{
    return self.headView;
}

- (CGPoint)pageVcHeadOrigin:(BTPageViewController *)pageVc{
    return CGPointMake(0, 0);
}

- (CGRect)pageVcContentFrame:(BTPageViewController*)pageVc{
    return CGRectMake(0, 50, self.view.width, self.view.height-50);
}

- (void)pageVc:(BTPageViewController*)pageView didShow:(NSInteger)index{
    
}

- (void)pageVc:(BTPageViewController *)pageView didDismiss:(NSInteger)index{
    
}

```

刷新数据

```
[self reloadData];
```
