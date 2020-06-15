## BTTextField

继承于```UITextField```，提供一些```UITextField```没有的属性设置


### 相关属性

```
//光标最大高度设置
@property (nonatomic, assign) IBInspectable NSInteger maxCursorH;

//最大文字长度设置
@property (nonatomic, assign) IBInspectable NSInteger maxContent;

//字符间距设置
@property (nonatomic, assign) IBInspectable NSInteger kern;

//placeHolder字体大小设置
@property (nonatomic, assign) IBInspectable NSInteger placeHolderFontSize;

//文字内容该表回调
@property (nonatomic, copy) void(^changeBlock)(void);

//文字内容到达最大长度回调
@property (nonatomic, copy) void(^maxContentBlock)(void);

//为键盘添加完成按钮
- (void)addDoneView;

```

在```xib```中使用，创建一个```TextField```，设置```TextField```的```Class```为```BTTextField```，设置相应参数。

![图片.png](https://upload-images.jianshu.io/upload_images/1243802-7de576a5998aa635.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

代码初始化使用

```
- (void)initTextField{
    self.textField = [[BTTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    self.textField.maxCursorH = 10;
    self.textField.maxContent = 11;
    self.textField.kern = 3;
    self.textField.placeHolderFontSize = 18;
    self.textField.maxContentBlock = ^{
        
    };
    self.textField.changeBlock = ^{
        
    };
}

```


## BTTextView

继承于```UITextView```，提供一些```UITextView```没有的属性设置

### 相关属性

```
//placeHolder文字
@property (nonatomic, strong) IBInspectable NSString * placeHolder;

@property (nonatomic, strong) IBInspectable UIColor * placeHolderColor;

//最多字符串长度
@property (nonatomic, assign) IBInspectable NSInteger maxStrNum;

//这个在xib中使用的时候不能设置textView的初始内容，得在代码里面设置，不然没有效果
@property (nonatomic, assign) IBInspectable NSInteger lineSpeac;

//行间距
@property (nonatomic, strong) UILabel * labelPlaceHolder;

//触发最大文字长度回调
@property (nonatomic, copy) void(^blockMax)(void);

//高度发生变化回调
@property (nonatomic, copy) void(^blockHeightChange)(CGFloat height);

//内容发生改变回调
@property (nonatomic, copy) void(^blockContentChange)(void);

//是否自己设施textView的textContainerInset
@property (nonatomic, assign) BOOL isSelfSetEdgeInsets;

//添加完成按钮
- (void)addDoneView;

```

