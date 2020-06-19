# BTHelp

开发中常用的一些工具类，旨在用特定的工具类快速完成特定的功能。

使用方法

```
pod install 'BTHelp'
```

## BTModel

一个自动的```json```解析```model```，继承于该类写上对象的```json```属性即可

### TestModel.h

```
#import "BTModel.h"

@class TestChildModel;

NS_ASSUME_NONNULL_BEGIN

@interface TestModel : BTModel

@property (nonatomic, strong) NSString * title;

@property (nonatomic, strong) TestChildModel * child;

@property (nonatomic, strong) NSMutableArray * childs;

@end

@interface TestChildModel : BTModel

@property (nonatomic, strong) NSString * content;

@end

NS_ASSUME_NONNULL_END

```

### TestModel.m

```
#import "TestModel.h"

@implementation TestModel

- (void)initSelf{
    [super initSelf];
    self.classDict = @{@"child":TestChildModel.class,@"childs":TestChildModel.class};
}

@end


@implementation TestChildModel



@end

```
解析

```
NSDictionary * dict = @{@"title":@"三国演义",@"child":@{@"content":@"东汉末年"},@"childs":@[@{@"content":@"分三国"},@{@"content":@"烽火连天不休"}]};
TestModel * model = [TestModel modelWithDict:dict];
NSLog(@"下个断点看有没有解析成功");
```

如果是字典的数组那么调用这个方法返回一个数组的```model```

```
+(NSMutableArray*)modelWithArray:(NSArray*)array;
```

同样支持将```model```转化为字典数据

```
-(NSDictionary*)autoDataToDictionary;
```


## BTTimerHelp

一个基于```NSTimer```封装的计时器，如果你需要精准的计时器功能，使用```gcd```，该类会提供快捷的开始、暂停、结束、重设计时器回调间隔功能

```
self.timer = [[BTTimerHelp alloc]init];
self.timer.changeTime = 1;
//每隔一秒回调一次
self.timer.block = ^{
               
};
[self.timer start];
```

暂停

```
[self.timer pause];
```

如果你需要在某一刻改变计时间隔

```
self.timer.changeTime = 3;
[self.timer start];
```

用完之后记得销毁

```
[self.timer stop];
```

## BTIconHelp

快速选取头像辅助类，相册、相机权限自己在```info.plist```中添加，权限问题也会在内部自己判断处理

初始化使用

```
self.iconHelp = [[BTIconHelp alloc] init:self];
self.iconHelp.block = ^(UIImage *image) {
                    
};
[self.iconHelp go];
```

## BTKeyboardHelp

在```viewDidAppear```中初始化，这个时候布局已经完成，可以避免一些坐标的计算错误问题，在初始化前必须保证的就是界面已经完成了布局

```
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.help == nil) {
        self.help = [[BTKeyboardHelp alloc] initWithShowView:self.textField moveView:self.displayView margin:0];
        [self.textField becomeFirstResponder];
    }
    
}
```

在```vc```的出现、消失的生命周期方法中进行暂停、恢复，防止进入其它页面后使用键盘弹出后的影响

```
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.help.isPause = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.help.isPause = NO;
}
```

## BTPermission

权限获取工具类，注意先要在```info.plist```中添加对应的权限使用描述文字

```
[[BTPermission share] getMicPermission:@"当前暂无麦克风权限，请打开后重试" success:^{
                
}];

[[BTPermission share] getAlbumPermission:^{
                
}];
```

## BTApplePay

使用方式见```PayViewController```，目前仅支持消耗类型项目的购买，不支持恢复购买、订阅


## NSDate+BTDate.h

提供更方便的```NSDate```对象的使用方式

初始化，根据时区获取对应的date，避免中国时区少```8```小时的问题

```
+ (instancetype)initLocalDate;
```

```NSDateFormatter```初始化方式

```
//传入2010-01-01 这个字符串获取date
+ (NSDate*)dateYMD:(NSString*)dateStr;

//传入2010-01-01 13:04:34 这个字符串获取date
+ (NSDate*)dateYMDHMS:(NSString*)dateStr;

//传入2010-01-01 13:04 这个字符串获取date
+ (NSDate*)dateYMDHM:(NSString*)dateStr;

//传入日期,以及格式化样式获取date
+ (NSDate*)dateFromStr:(NSString*)dateStr formatter:(NSString*)formatterStr;
```

获取格式化字符串

```
- (NSString*)dateStr:(NSString*)formater;
```

其它快捷使用方法见类中注释

## BTUtils

工具类，集合常用方法，见注释

## BTDownloadMananger

下载工具类，基于```NSURLSessionDownload```，在主动调用停止下载的情况下可以实现断点续传。无法实现断点续传情况：断网、杀掉应用

加入下载，如果当前下载数量过多会等待下载

```
[[BTDownloadMananger share] downLoad:@"下载地址"];
```

加入回调监听

```
[[BTDownloadMananger share] addDelegate:self];
```

实现```BTDownloadDelegate```监听下载回调

```
- (void)downloadStateChange:(BTDownloadModel *)model;

- (void)downloadProgressChange:(BTDownloadModel *)model;

- (void)downloadError:(BTDownloadModel *)model error:(NSError*)error;
```

不用的时候移除监听

```
[[BTDownloadMananger share] removeDelegate:self];
```

取消下载

```
[[BTDownloadMananger share] cancel:@"下载地址"];
```

是否正在下载

```
[[BTDownloadMananger share] isDownloading:@"下载地址"];
```

## BTLocation
定位工具类，待完善。
