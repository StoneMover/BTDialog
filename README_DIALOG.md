# BTDialogView

![](https://upload-images.jianshu.io/upload_images/1243802-ac4bd16b4644bd99.gif)

[GIF](https://upload-images.jianshu.io/upload_images/1243802-ac4bd16b4644bd99.gif)

显示你的自定义```view```，根据```BTDialogLocation```的类型来确定```view```显示的位置

```
typedef NS_ENUM(NSInteger,BTDialogLocation) {
    BTDialogLocationTop=0,//位置,顶部
    BTDialogLocationCenter,//中部
    BTDialogLocationBottom//底部
};
```

```
UIView * yourView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BTUtils.SCREEN_W, 400)];
yourView.backgroundColor = UIColor.redColor;
UILabel * label = [[UILabel alloc] init];
label.text = @"我是一个自定义的View";
[label sizeToFit];
[yourView addSubview:label];
    
BTDialogView * dialogView = [[BTDialogView alloc] init:yourView withLocation:BTDialogLocationCenter];
[dialogView show:BTUtils.APP_WINDOW];
```

或者可以引入```UIView+BTEasyDialog.h```，用更快的方法创建弹框

```
UIView * yourView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BTUtils.SCREEN_W, 400)];
yourView.backgroundColor = UIColor.redColor;
UILabel * label = [[UILabel alloc] init];
label.text = @"我是一个自定义的View";
[label sizeToFit];
[yourView addSubview:label];

[yourView showBottom];
```

相关属性

```
//圆角的数值,不需要则为0即可
@property (nonatomic, assign) CGFloat cornerNum;

//点击空白区域消失，默认消失
@property (nonatomic,assign) BOOL clickEmptyAreaDismiss;

//当view显示在中部的时候的偏移量
@property (nonatomic, assign) CGFloat centerOffset;

//dialog消失完成后的block回调
@property (nonatomic, copy) BTDialogDissmisFinishBlock blockDismiss;

//是否需要跟随键盘移动
@property (nonatomic, assign) BOOL isNeedMoveFollowKeyboard;

```


## BTDialogTableView

快速的创建一个列表样式的弹框，提供单选或者多选的功能，基于```BTDialogView```


![图片](https://upload-images.jianshu.io/upload_images/1243802-31d5cac77d20293e.png)




```
BTDialogTableView * tableView = [[BTDialogTableView alloc] initDialogTableView:BTDialogLocationCenter];
tableView.headView.labelTitle.text = @"三国好看啊";
tableView.miniRootHeight = 100;
tableView.blockTable = ^BOOL(NSInteger index) {
        
        
	return YES;
};
[tableView createDataWithStr:@[@"刘备",@"诸葛亮",@"赵子龙",@"关羽",@"曹操"]];
[tableView show: BTUtils.APP_WINDOW];
```

相关属性

```
//头部view
@property(strong, nonatomic) BTDialogTableHeadView * headView;

//数据源
@property (strong, nonatomic) NSArray * dataArray;

//返回bool值来表明是否关闭view
@property (nonatomic, copy) BOOL(^blockTable)(NSInteger index);

//是否需要头部,默认为true
@property (nonatomic, assign) BOOL isNeedHead;

//rootView 最小的高度,默认300
@property (nonatomic, assign) CGFloat miniRootHeight;

//rootView 的最大高度,默认300
@property (nonatomic, assign) CGFloat maxRootHeight;

//cell的高度，默认45，如果为-1则为高度自适应，如果是高度自适应的话rootView、tableView的高度会被设置为maxRootHeight
@property (nonatomic, assign) CGFloat cellHeight;
```


## BTAlertView

将你的```view```像```UIAlertView```的方式弹出

[图片](https://upload-images.jianshu.io/upload_images/1243802-6d955dbbbbc02970.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```
UIView * viewShow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
UILabel * label = [[UILabel alloc] init];
label.text = @"我是一个自定义的View";
[label sizeToFit];
[viewShow addSubview:label];
    
BTAlertView * alertView = [[BTAlertView alloc] initWithcontentView:viewShow];
[alertView showCenter];
```

相关属性

```
//标题label
@property (nonatomic, strong) UILabel * labelTitle;

//取消按钮
@property (nonatomic, strong) UIButton * btnCancel;

//确定按钮
@property (nonatomic, strong) UIButton * btnOk;

//横向的线
@property (nonatomic, strong) UIView * viewLineHoz;

//竖向的线
@property (nonatomic, strong) UIView * viewLineVertical;

//需要展示的内容
@property (nonatomic, strong) UIView * contentView;

//取消回调
@property (nonatomic, copy) BOOL(^cancelBlock)(void);

//确定回调
@property (nonatomic, copy) BOOL(^okBlock)(void);

//是否只需要确定按钮
@property (nonatomic, assign) BOOL isJustOkBtn;

```

创建一个文本类型的弹框

[图片](https://upload-images.jianshu.io/upload_images/1243802-42ca9d4a20664ca4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```
BTAlertLabelView * labelView = [[BTAlertLabelView alloc] initWithTitle:@"关张马黄赵传第六" msg:@"因战乱逃亡到涿郡。刘备在家乡招集兵马，关羽和张飞担任他的护卫。刘备任平原国国相后，任关羽、张飞为别部司马，分管所辖军队。刘备与关、张二人连睡觉都同一张床 ，亲如同胞兄弟。关、张二人在大庭广众之中，整日侍立在刘备身旁，跟随刘备对敌作战，从不惧避艰险。刘备袭击徐州杀死刺史车胄后，即让关羽镇守下邳城，代行太守职务，自己则率军回驻小沛。"];
labelView.isJustOkBtn = YES;
[labelView showCenter];
```

创建一个单行编辑的弹框

[图片](https://upload-images.jianshu.io/upload_images/1243802-91326af89f21b725.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```
BTAlertTextFieldView * fieldView = [[BTAlertTextFieldView alloc] initWithContent:@"刘备任平原国国相后，任关羽" placeholder:@"来看三国呗"];
[fieldView showCenter].isNeedMoveFollowKeyboard = YES;
[fieldView.textField addDoneView];
__weak BTAlertTextFieldView * weakSelf=fieldView;
fieldView.okBlock = ^BOOL{
    NSLog(@"%@",weakSelf.textField.text);
    return YES;
};
```

创建一个多行编辑的弹框

[图片](https://upload-images.jianshu.io/upload_images/1243802-adeb5f24289aa63b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```
BTAlertTextView * textView = [[BTAlertTextView alloc] initWithContent:@"又被任为谯县县令，未到任。刘备统治豫州时，荐袁涣为茂才。后袁涣迁移到江 淮之间避祸，被袁术所任命。袁术每次有所咨询，袁涣常有严正的议论。袁术不能违抗，然而也不敢不有礼貌地尊敬他。不久，吕布在阜陵攻击袁术，袁涣前去随从袁术，于是也被吕布拘留。吕布当初与刘备结亲和好，后来有了嫌隙。现在，吕布想要让袁涣写信辱骂刘备，袁涣不答应，再三强迫他，仍不同意。吕布大怒，用兵器威胁袁涣说：“你做就能活，不做就得死。”袁涣脸不变色，笑着回答说：“袁涣听说只有德行才能使人蒙受耻辱，没听说用辱骂的。假使他本来就是个君子，那他将不以将军的话为耻辱，假使他本来就是个小人，那他将像将军一样写信，回骂将军，那样耻辱将在这一方而不在他那一方。况且袁涣我异日侍奉刘将军，就像现在侍奉将军您一样，如果我一旦离开这里，回过头来骂您，可以吗？”吕布感到羞惭，不再逼他。" placeholder:@"请输入你对刘备的评价"];
[textView.textView addDoneView];
[textView showCenter].isNeedMoveFollowKeyboard = YES;
```