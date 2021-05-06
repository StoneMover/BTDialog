//
//  BTHelp.m
//  BTHelpExample
//
//  Created by apple on 2021/4/14.
//  Copyright © 2021 stonemover. All rights reserved.
//

#import "BTHelp.h"

@implementation BTHelp

@end


static BTScaleHelp * help = nil;

@implementation BTScaleHelp

+ (instancetype)share{
    if (help == nil) {
        help = [BTScaleHelp new];
    }
    return help;
}


+ (CGFloat)scaleViewSize:(CGFloat)value{
    return BTScaleHelp.share.scaleViewBlock(value);
}
+ (CGFloat)scaleViewSize:(CGFloat)value uiDesignWidth:(CGFloat)uiDesignWidth{
    return BTScaleHelp.share.scaleViewFullBlock(value,uiDesignWidth);
}

+ (CGFloat)scaleFontSize:(CGFloat)fontSize{
    return BTScaleHelp.share.scaleFontSizeBlock(fontSize);
}
+ (CGFloat)scaleFontSize:(CGFloat)fontSize uiDesignWidth:(CGFloat)uiDesignWidth{
    return BTScaleHelp.share.scaleFontSizeFullBlock(fontSize,uiDesignWidth);
}

- (instancetype)init{
    self = [super init];
    [self iniSelf];
    return self;
}

- (void)iniSelf{
    self.uiDesignWidth = 375;
    self.scaleViewBlock = ^CGFloat(CGFloat value) {
        return BTUtils.SCREEN_W / self.uiDesignWidth * value;
    };
    
    self.scaleViewFullBlock = ^CGFloat(CGFloat value, CGFloat uiDesignWidth) {
        return BTUtils.SCREEN_W / uiDesignWidth * value;
    };
    
    self.scaleFontSizeBlock = ^CGFloat(CGFloat fontSize) {
        return BTUtils.SCREEN_W / self.uiDesignWidth  * fontSize;
    };
    
    self.scaleFontSizeFullBlock = ^CGFloat(CGFloat fontSize, CGFloat uiDesignWidth) {
        return BTUtils.SCREEN_W / uiDesignWidth  * fontSize;
    };
    
}

@end


@interface BTTimerHelp()

@property(nonatomic,assign)BOOL isHasFire;

@property(nonatomic,strong)NSTimer * timer;

//是否已经开始
@property(nonatomic,assign,readonly)BOOL isStart;


@end

@implementation BTTimerHelp

- (instancetype)initTimerWithChangeTime:(CGFloat)changeTime{
    self=[super init];
    return self;
}

- (void)setChangeTime:(CGFloat)changeTime{
    _changeTime=changeTime;
    if (self.timer) {
        [self stop];
        self.timer=nil;
    }
    self.timer=[NSTimer timerWithTimeInterval:changeTime target:self selector:@selector(timeChanged) userInfo:nil repeats:YES];
    self.isHasFire = NO;
}

-(void)timeChanged{
    _totalTime+=_changeTime;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(BTTimeChanged:)]) {
        [self.delegate BTTimeChanged:self];
    }
    
    if (self.block) {
        self.block();
    }
}

-(void)start{
    if (!self.isHasFire) {
        self.isHasFire=YES;
        _isStart=YES;
        [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
    }else{
        if (_isStart) {
            return;
        }
        _isStart=YES;
        [self.timer setFireDate:[[NSDate alloc]initWithTimeIntervalSinceNow:_changeTime]];//重新开始的时间设置为间隔播放时间几秒后开始
    }
}
-(void)pause{
    if (!self.isHasFire||!_isStart) {
        return;
    }
    
     [self.timer setFireDate:[NSDate distantFuture]];//暂停
    _isStart=NO;
}

-(void)stop{
    [self.timer invalidate];
}

-(void)resetTotalTime{
    _totalTime=0;
}

@end


@interface BTIconHelp()<UIActionSheetDelegate,UIImagePickerControllerDelegate>

@property(nonatomic,weak)UIViewController * rootViewController;

@property(nonatomic,strong)UIImagePickerController * photoVC;

@property (nonatomic, strong) UIButton * btnCancel;

@end


@implementation BTIconHelp

-(instancetype)init:(UIViewController*)vc{
    self=[super init];
    self.rootViewController=vc;
    self.actions=[NSMutableArray new];
    self.btnCancel=[[UIButton alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-80, 80, 80)];
    self.btnCancel.backgroundColor=UIColor.clearColor;
    [self.btnCancel addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    return self;
}

- (void)cancelClick{
    if (self.photoVC.viewControllers.count==3) {
        [self.photoVC popViewControllerAnimated:YES];
    }
}


-(void)go{
    __weak BTIconHelp * weakSelf=self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:self.actionTitle
                                                                             message:nil
                                                                      preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:self.cameraTitle?self.cameraTitle:@"相机" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        [weakSelf actionClick:0];
    }];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:self.photoAlbumTitle?self.photoAlbumTitle:@"相册" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        [weakSelf actionClick:1];
    }];
    
    if (self.cancelActionTitleColor) {
        [cancelAction setValue:self.cancelActionTitleColor forKey:@"titleTextColor"];
    }
    
    if (self.otherActionTitleColor) {
        [cameraAction setValue:self.otherActionTitleColor forKey:@"titleTextColor"];
        [photoAction setValue:self.otherActionTitleColor forKey:@"titleTextColor"];
    }
    
    if (self.actions&&self.isAddDefaultAction) {
        for (UIAlertAction * a in self.actions) {
            [alertController addAction:a];
            if (self.otherActionTitleColor) {
                [a setValue:self.otherActionTitleColor forKey:@"titleTextColor"];
            }
        }
    }
    [alertController addAction:cameraAction];
    [alertController addAction:photoAction];
    if (self.actions&&!self.isAddDefaultAction) {
        for (UIAlertAction * a in self.actions) {
            [alertController addAction:a];
            if (self.otherActionTitleColor) {
                [a setValue:self.otherActionTitleColor forKey:@"titleTextColor"];
            }
        }
    }
    
    [alertController addAction:cancelAction];
    
    [self.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)actionClick:(NSInteger)index{
    
    if (index==0&&!BTPermission.share.isCamera) {
        [BTPermission.share getCameraPermission:^{
            [self actionClick:index];
        }];
        return;
    }
    
    if (index==1&&!BTPermission.share.isAlbum) {
        [BTPermission.share getAlbumPermission:^{
            [self actionClick:index];
        }];
        return;
    }
    if (self.photoVC==nil) {
        self.photoVC=[[UIImagePickerController alloc]init];
        self.photoVC.delegate = (id)self;
        self.photoVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        self.photoVC.allowsEditing = self.isClip;
        self.photoVC.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    
    if (index == 0){
        self.photoVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.rootViewController presentViewController:self.photoVC animated:YES completion:nil];
    }else if(index == 1){
        //调用相册
        self.photoVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.rootViewController presentViewController:self.photoVC animated:YES completion:^{
            UIWindow * window =[UIApplication sharedApplication].delegate.window;
            [window addSubview:self.btnCancel];
        }];
        
    }
}




#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info{
    [self.btnCancel removeFromSuperview];
    UIImage * aImage=self.isClip?info[UIImagePickerControllerEditedImage]:info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:^(void){
        UIImage * imgResult=nil;
        if (self.isClip&&aImage.size.width!=aImage.size.height) {
            imgResult=[self clicpImg:aImage];
        }else{
            imgResult=aImage;
        }
        if (self.imgSize!=0) {
            imgResult=[self scaleToSize:imgResult size:CGSizeMake(self.imgSize, self.imgSize)];
        }
        if (self.block) {
            self.block(imgResult);
        }
    }];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.btnCancel removeFromSuperview];
}


- (UIImage*)clicpImg:(UIImage*)img{
    UIImage *image = img;
    //图片裁剪成正方形
    UIImage *resizeImage;
    CGFloat iw = image.size.width;
    CGFloat ih = image.size.height;
    if (iw > ih) {//长大于宽
        CGImageRef cgimage =CGImageCreateWithImageInRect(image.CGImage, CGRectMake((iw-ih)/2,0, ih, ih));
        resizeImage = [[UIImage alloc] initWithCGImage:cgimage scale:1 orientation:image.imageOrientation];
    } else {
        CGImageRef cgimage =CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0,(ih-iw)/2, iw, iw));
        resizeImage = [[UIImage alloc] initWithCGImage:cgimage scale:1 orientation:image.imageOrientation];
    }
    return  resizeImage;
}


- (UIImage *)scaleToSize:(UIImage*)img size:(CGSize)sizeImage{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(sizeImage);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, sizeImage.width, sizeImage.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}

@end



@interface BTKeyboardHelp()

//需要不被键盘遮挡的view在屏幕上的Y坐标
//@property(nonatomic,assign)CGFloat windowOriY;

//需要不被键盘遮挡的view对象
@property(nonatomic,weak)UIView * viewDisplay;

//需要显示的view在屏幕的y坐标
@property (nonatomic, assign) CGFloat viewDisplayScreenY;

//计算出需要移动的距离
@property(nonatomic,assign)CGFloat resutlY;

//将要移动的rootView,当键盘收起的时候会将其返回到0点的位置
@property (nonatomic, weak) UIView * viewMove;

//需要移动的view的 原始的y坐标
@property (nonatomic, assign) CGFloat viewMoveOriY;

//需要多加的间距
@property (nonatomic, assign) CGFloat moreMargin;

//约束的原始位置点
@property (nonatomic, assign) CGFloat viewOriContraintTop;

@end


@implementation BTKeyboardHelp

- (instancetype)initWithShowView:(UIView*)showView moveView:(UIView*)moveView margin:(NSInteger)margin{
    self=[super init];
    self.moreMargin=margin;
    self.isKeyboardMoveAuto=YES;
    self.viewMove=moveView;
    [self addKeyBoardNofication];
    [self replaceDisplayView:showView withDistance:margin];
    return self;
}

- (instancetype)initWithShowView:(UIView*)showView moveView:(UIView*)moveView{
    return [self initWithShowView:showView moveView:moveView margin:0];
}

- (instancetype)initWithShowView:(UIView*)showView{
    return [self initWithShowView:showView moveView:[[[UIApplication sharedApplication] delegate] window] margin:0];
}

- (instancetype)initWithShowView:(UIView*)showView margin:(NSInteger)margin{
    return [self initWithShowView:showView moveView:[[[UIApplication sharedApplication] delegate] window] margin:margin];
}





//添加键盘监听通知
-(void)addKeyBoardNofication{
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

//当键盘消失的时候调用
- (void)keyboardWillHide:(NSNotification *)notification{
    _isKeyBoardOpen=NO;
    
    if (self.isKeyboardMoveAuto) {
        if (self.contraintTop) {
            [UIView animateWithDuration:.25 animations:^{
                self.contraintTop.constant=self.viewOriContraintTop;
                if (self.contraintTopView) {
                    [self.contraintTopView.superview layoutIfNeeded];
                }else{
                    [self.viewDisplay.superview layoutIfNeeded];
                    [self.viewMove.superview layoutIfNeeded];
                }
            } completion:^(BOOL finished) {
                if(self.delegate&&[self.delegate respondsToSelector:@selector(keyboardDidHide)]){
                    [self.delegate keyboardDidHide];
                }
            }];
        }else{
            [UIView animateWithDuration:.25 animations:^{
                self.viewMove.frame = CGRectMake(self.viewMove.frame.origin.x,self.viewMoveOriY, self.viewMove.frame.size.width, self.viewMove.frame.size.height);
            } completion:^(BOOL finished) {
                if(self.delegate&&[self.delegate respondsToSelector:@selector(keyboardDidHide)]){
                    [self.delegate keyboardDidHide];
                }
            }];
        }
        
    }
    
    if(self.delegate&&[self.delegate respondsToSelector:@selector(keyboardWillHide)]){
        [self.delegate keyboardWillHide];
    }
    self.resutlY=0;
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)notification
{
    if (self.isPause) {
        return;
    }
    
    //获取键盘的高度
    NSDictionary * userInfo = [notification userInfo];
    NSValue * value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    CGFloat keyboardHeight = keyboardRect.size.height;
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGFloat keyboardY=window.frame.size.height-keyboardHeight;
    
    //计算需要移动的距离,键盘针对屏幕的y坐标如果大于需要显示view的y+height说明不会被遮挡则不需要移动,否则则需要将view的y坐标减去result的值保证不被遮挡
    CGFloat result=keyboardY-self.viewDisplay.frame.size.height-self.viewDisplayScreenY-self.moreMargin;
    if (result<0){
        CGFloat newY=self.viewMoveOriY+result;
        
        if (self.isKeyboardMoveAuto) {
            if (self.contraintTop) {
                [UIView animateWithDuration:.25 animations:^{
                    self.contraintTop.constant=self.viewOriContraintTop+result;
                    if (self.contraintTopView) {
                        [self.contraintTopView.superview layoutIfNeeded];
                    }else{
                        [self.viewDisplay.superview layoutIfNeeded];
                        [self.viewMove.superview layoutIfNeeded];
                    }
                }];
            }else{
                [UIView animateWithDuration:.25 animations:^{
                    self.viewMove.frame = CGRectMake(self.viewMove.frame.origin.x, newY, self.viewMove.frame.size.width, self.viewMove.frame.size.height);
                }];
            }
            
        }
    }
    _isKeyBoardOpen=YES;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(keyboardWillShow:)]) {
        [self.delegate keyboardWillShow:keyboardHeight];
    }
    self.resutlY=result;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(keyboardMove:)]) {
        [self.delegate keyboardMove:result];
    }
    
}

-(void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)replaceDisplayView:(UIView*)viewDisplay withDistance:(NSInteger)distance{
    self.viewDisplay=viewDisplay;
    self.viewMoveOriY=self.viewMove.frame.origin.y;
    //将移动view的坐标转换为屏幕坐标,这里是用frame还是bounds需要确认
    //第一个参数rect应该是这个view自己内部的一块区域,这块区域如果你想是view自己本身,那么就是用view.bounds,如果你想是他内部的一块空间,你可以自己指定.但是切忌使用self.frame,那么基本上算出来的就是错误的结果
    //https://www.jianshu.com/p/5a7387b21789
    CGRect rect =[self.viewDisplay convertRect: self.viewDisplay.bounds toView:[[[UIApplication sharedApplication] delegate] window]];
//    CGRect rect =[self.viewDisplay convertRect: self.viewDisplay.frame toView:[[[UIApplication sharedApplication] delegate] window]];
    self.viewDisplayScreenY=rect.origin.y;
    if (!self.contraintTop) {
        for (NSLayoutConstraint * c in viewDisplay.constraints) {
            if (c.identifier&&[c.identifier isEqualToString:@"BT_KEYBOARD_CONSTRAING_ID"]) {
                self.contraintTop=c;
                break;
            }
        }
    }
    
    
}

- (void)setContraintTop:(NSLayoutConstraint *)contraintTop{
    _contraintTop=contraintTop;
    self.viewOriContraintTop=contraintTop.constant;
}

- (void)setNavTransSafeAreaStyle{
    self.viewDisplayScreenY+=BTUtils.NAVCONTENT_HEIGHT;
}

-(void)dealloc{
    [self removeNotification];
}

@end


@implementation BTFileHelp

+ (NSString*)homePath{
    return NSHomeDirectory();
}



+ (NSString*)documentPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return path;
}


+ (NSString*)cachePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return path;
}


+ (NSString*)libraryPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return path;
}


+ (NSString*)tmpPath{
    NSString *path = NSTemporaryDirectory();
    return path;
}

+ (NSString*)cachePicturePath{
    NSString * pic=[NSString stringWithFormat:@"%@/pic",[self cachePath]];
    if (![self isFileExit:pic]) {
        [self createPath:pic];
    }
    
    return pic;
}
+ (NSString*)cacheVideoPath{
    
    NSString * video =[NSString stringWithFormat:@"%@/video",[self cachePath]];
    if (![self isFileExit:video]) {
        [self createPath:video];
    }
    
    return video;
}

+ (NSString*)cacheVoicePath{
    NSString * voice=[NSString stringWithFormat:@"%@/voice",[self cachePath]];
    if (![self isFileExit:voice]) {
        [self createPath:voice];
    }
    return voice;
}


+ (BOOL)isFileExit:(NSString*)path{
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}


+ (void)deleteFile:(NSString*)path{
    if ([self isFileExit:path]) {
        NSError *error;
        [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        if (error) {
            NSLog(@"删除%@出错:%@",path,error.domain);
        }
    }
}


+ (void)copyFile:(NSString*)filePath toPath:(NSString*)path isOverride:(BOOL)overrid{
    NSFileManager * mananger=[NSFileManager defaultManager];
    if (overrid) {
        [self deleteFile:filePath];
    }else{
        if ([self isFileExit:path]) {
            return;
        }
    }
    [self deleteFile:path];
    
    NSString * parentPath=[path stringByDeletingLastPathComponent];
    if (![self isFileExit:parentPath]) {
        [self createPath:parentPath];
    }
    
    NSError * error;
    [mananger copyItemAtPath:filePath toPath:path error:&error];
    if (error) {
        NSLog(@"复制%@出错:%@",path,error.domain);
    }
}


+ (void)createPath:(NSString*)path{
    if (![self isFileExit:path]) {
        NSFileManager * fileManager=[NSFileManager defaultManager];
        NSString * parentPath=[path stringByDeletingLastPathComponent];
        if ([self isFileExit:parentPath]) {
            NSError * error;
            [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        }else{
            [self createPath:parentPath];
            [self createPath:path];
        }
        
    }
}

+ (void)createDocumentPath:(NSString*)path{
    NSString *pathRestul=[NSString stringWithFormat:@"%@/%@",[self documentPath],path];
    [self createPath:pathRestul];
}

+ (NSString*)saveFileWithPath:(NSString*)path fileName:(NSString*)fileName data:(NSData*)data{
    return [self saveFileWithPath:path fileName:fileName data:data isAppend:NO];
}

+ (NSString*)saveFileWithPath:(NSString*)path fileName:(NSString*)fileName data:(NSData*)data isAppend:(BOOL)isAppend{
    [self createPath:path];
    NSData * resultData=nil;
    NSString * resultPath=[NSString stringWithFormat:@"%@/%@",path,fileName];
    if ([self isFileExit:resultPath]&&isAppend) {
        NSMutableData * dataOri=[NSMutableData dataWithContentsOfFile:resultPath];
        [dataOri appendData:data];
        resultData=dataOri;
    }else{
        resultData=data;
    }
    
    [[NSFileManager defaultManager] createFileAtPath:resultPath contents:resultData attributes:nil];
    
    return [NSString stringWithFormat:@"%@/%@",path,fileName];
}



+ (NSArray*)getFolderAllFileName:(NSString*)folderPath fileType:(NSString*)fileType{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *myDirectoryEnumerator = [fileManager enumeratorAtPath:folderPath];  //baseSavePath 为文件夹的路径
    NSMutableArray *filePathArray = [[NSMutableArray alloc]init];   //用来存目录名字的数组
    NSString *file;
    while((file=[myDirectoryEnumerator nextObject]))     //遍历当前目录
    {
        if (fileType) {
            if([[file pathExtension] isEqualToString:fileType])  //取得后缀名为.xml的文件名
            {
                [filePathArray addObject:file];
            }
        }else{
            [filePathArray addObject:file];
        }
        
    }
    return filePathArray;
}

@end
