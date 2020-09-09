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

//文字内容改变回调
@property (nonatomic, copy) void(^changeBlock)(void);

//文字内容到达最大长度回调
@property (nonatomic, copy) void(^maxContentBlock)(void);

//为键盘添加完成按钮
- (void)addDoneView;

```

在```xib```中使用，创建一个```UITextField```，设置```UITextField```的```Class```为```BTTextField```，设置相应参数。

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

//行间距，这个在xib中使用的时候不能设置textView的初始内容，得在代码里面设置，不然没有效果
@property (nonatomic, assign) IBInspectable NSInteger lineSpeac;

//触发最大文字长度回调
@property (nonatomic, copy) void(^blockMax)(void);

//高度发生变化回调
@property (nonatomic, copy) void(^blockHeightChange)(CGFloat height);

//内容发生改变回调
@property (nonatomic, copy) void(^blockContentChange)(void);

//是否自己设置textView的textContainerInset，用来解决textView边距问题
@property (nonatomic, assign) BOOL isSelfSetEdgeInsets;

//添加完成按钮
- (void)addDoneView;
```

在```xib```中使用，创建一个```UITextView```，设置```UITextView ```的```Class```为```BTTextView```，设置相应参数。

![图片.png](https://upload-images.jianshu.io/upload_images/1243802-b077ebd9fdb97a0b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

代码初始化使用

```
- (void)initTextView{
    BTTextView * textView = [[BTTextView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    textView.placeHolder = @"placeHolder";
    textView.placeHolderColor = UIColor.redColor;
    textView.maxStrNum = 100;
    textView.lineSpeac = 2;
    textView.blockMax = ^{
        
    };
    textView.blockHeightChange = ^(CGFloat height) {
        
    };
    textView.blockContentChange = ^{
        
    };
    textView.textContainerInset=UIEdgeInsetsMake(0, -1.5, 0, 0);
    textView.isSelfSetEdgeInsets = YES;
    [textView addDoneView];
}

```

## BTTextInputToolView

一个发送框的样式封装，需要自己完成键盘弹出后的位移以及文字动态高度的变化处理，可以参考```BTTextInputView```如何处理高度变化和键盘的弹出效果

![图片.png](https://upload-images.jianshu.io/upload_images/1243802-c21965f224d408a6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

初始化方法

```
- (instancetype)initWithFrame:(CGRect)frame type:(BTTextInputToolType)type;
```

相关属性

```
//输入框
@property (nonatomic, strong, readonly) BTTextView * textView;

//语音图标
@property (nonatomic, strong) UIImage * voiceImg;

//键盘图标
@property (nonatomic, strong) UIImage * keyboardImg;

//相关事件的状态回调
@property (nonatomic, weak) id<BTTextInputToolViewDelegate> delegate;

//点击发送按钮回调
@property (nonatomic, copy) void(^block)(void);

//能够发送文字状态下的发送文字颜色
@property (nonatomic, strong) UIColor * commitColor;

```

## BTTextInputView

可以快速的弹出一个简单的评论框，自动处理文字的高度变化以及键盘的位移处理。

![Jietu20200617-110830.gif](https://s1.ax1x.com/2020/09/09/w31kZ9.gif)

[看不了GIF点这里](https://s1.ax1x.com/2020/09/09/w31kZ9.gif)

初始化使用

```
self.inputView = [[BTTextInputView alloc]initWithFrame:UIScreen.mainScreen.bounds];
[self.inputView show:((AppDelegate*)UIApplication.sharedApplication.delegate).window];
```

