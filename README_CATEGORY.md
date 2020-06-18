# UILabel+BTLabel.h

提供一些```NSMutableAttributedString```快捷设置，复杂的富文本使用```YYLabel```或者```NudeIn```实现

```
//设置文字字体
- (void)bt_AttributedFont:(UIFont*)font str:(NSString*)str;

//设置文字颜色
- (void)bt_AttributedColor:(UIColor*)color str:(NSString*)str;

//设置文字背景颜色
- (void)bt_AttributedBgColor:(UIColor*)color str:(NSString*)str;

//设置字体文字间距
- (void)bt_AttributedKern:(NSNumber*)kern str:(NSString*)str;


//设置删除线
- (void)bt_AttributedDelLine:(UIColor*)color str:(NSString*)str;

//设置下划线
- (void)bt_AttributedUnderLine:(UIColor*)color str:(NSString*)str;

//设置超链接
- (void)bt_AttributedLink:(NSURL*)url str:(NSString*)str;

//设置两端对齐,可能与下划线有冲突
- (void)bt_AttributedAlignStartEnd;

```

## WKWebView+FullImg.h

提供快捷方法获取整个```webView```内容截图的图片

[参考](https://www.jianshu.com/p/85982ebc8b58)

```
- (void)imageRepresentation:(void(^)(UIImage * img))block;
```

## UIView+BTViewTool.h

提供快捷的```UIView```属性设置

分类中的快捷初始化方法

```
- (instancetype)initWithSubView:(UIView*)subView;
- (instancetype)initWithSize:(CGSize)size;
- (instancetype)initWithEqualSize:(CGFloat)size;
```


获取、设置```frame```属性

```
- (void)setWidth:(CGFloat)width;
- (CGFloat)width;

- (void)setHeight:(CGFloat)height;
- (CGFloat)height;

- (void)setLeft:(CGFloat)left;
- (CGFloat)left;

- (void)setRight:(CGFloat)right;
- (CGFloat)right;

- (void)setTop:(CGFloat)top;
- (CGFloat)top;

- (void)setBottom:(CGFloat)bottom;
- (CGFloat)bottom;

- (void)setCenterY:(CGFloat)centerY;
- (CGFloat)centerY;

- (void)setCenterX:(CGFloat)centerX;
- (CGFloat)centerX;

- (void)setSize:(CGSize)size;
- (CGSize)size;

- (void)setOrigin:(CGPoint)point;
- (CGPoint)origin;

```

圆角相关处理

```
@property (nonatomic, assign) CGFloat corner;
    
@property (nonatomic, assign) CGFloat borderWidth;
    
@property (nonatomic, strong) UIColor * borderColor;
    
- (void)setCorner:(CGFloat)corner borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor;
    
- (void)setCornerRadiusBottom:(CGFloat)corner;
- (void)setCornerRadiusTop:(CGFloat)corner;
- (void)setCornerRadiusLeft:(CGFloat)corner;
- (void)setCornerRadiusRight:(CGFloat)corner;
```

获取当前```vc```

```
- (UIViewController*)viewController;
```

移除子```view```

```
- (void)removeChild:(UIView*)childView;
- (void)removeAllChildView;
```

设置阴影效果

```
- (void)setDefaultShade;
- (void)setShade:(CGFloat)opacity radius:(CGFloat)radius;
- (void)setShade:(CGFloat)opacity color:(UIColor*)color radius:(CGFloat)radius offset:(CGSize)size;
```

从```xib```中加载对象

```
+ (instancetype)loadInstanceFromNib;
```

添加很多的```view```

```
- (void)addSubViewArray:(NSArray<UIView*>*)subviews;
```

生成当前```view```的图片

```
- (UIImage*)selfImg;
```

## UIView+BTConstraint.h

简单的自动布局```Constraint```的封装，作为项目内部编程使用以减少对其它第三方库的依赖，可忽略

## UIImage+BTImage.h

根据颜色生成图片

```
+ (UIImage*)imageWithColor:(UIColor *)color;

+ (UIImage*)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage*)imageWithColor:(UIColor *)color equalSize:(CGFloat)size;
```

加载图片不受系统tintColor颜色的影响显示

```
+ (UIImage*)imageOriWithName:(NSString*)imgName;
```

压缩大小到指定的大小

```
- (NSData *)compressQualityWithMaxLength:(NSInteger)maxLength;
```

将图片缩放到指定的大小，多出的部分将以中心为基准进行裁剪

```
- (UIImage *)scaleToSize:(CGSize)size;
```

绘制圆角

```
- (UIImage*)imageWithCornerRadius:(CGFloat)radius;
```

## UIView+BTEasyDialog.h

快速的弹框分类，基于```BTDialogView```

```
- (BTDialogView*)createDialog:(BTDialogLocation)location;

- (BTDialogView*)show:(BTDialogLocation)location inView:(UIView*)view;

- (BTDialogView*)show:(BTDialogLocation)location;

- (BTDialogView*)showBottom;

- (BTDialogView*)showCenter;

- (BTDialogView*)showTop;

//当显示后view自身成为dialog的childView，然后即可用该方法获取值
- (BTDialogView*)dialogView;
```