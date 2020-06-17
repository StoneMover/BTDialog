# BTSearchView

快速的搜索弹框界面

![图片.png](https://upload-images.jianshu.io/upload_images/1243802-27b083e4e48a5d12.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

使用

```
BTSearchView * view = [[BTSearchView alloc] initWithFrame:UIScreen.mainScreen.bounds];
view.searchResult = ^(NSString * _Nullable searchStr) {
        
};
[view show:UIApplication.sharedApplication.delegate.window];
```

如果仅仅需要上面的头部，那么使用```BTSearchHeadView```

```
self.viewHead = [[BTSearchHeadView alloc] initSearchHead];
self.viewHead.cancelClickBlock = ^{
    
};
self.viewHead.searchClick = ^(NSString * _Nonnull searchStr) {

};
```

如果不想要取消按钮

```
self.viewHead.btnCancel.hidden = YES;
```