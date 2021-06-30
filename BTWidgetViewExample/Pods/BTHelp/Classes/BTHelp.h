//
//  BTHelp.h
//  BTHelpExample
//
//  Created by apple on 2021/4/14.
//  Copyright © 2021 stonemover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BTUtils.h"
#import "BTPermission.h"

NS_ASSUME_NONNULL_BEGIN

@interface BTHelp : NSObject

@end


@interface BTScaleHelp : NSObject

+ (instancetype)share;

+ (CGFloat)scaleViewSize:(CGFloat)value;
+ (CGFloat)scaleViewSize:(CGFloat)value uiDesignWidth:(CGFloat)uiDesignWidth;

+ (CGFloat)scaleFontSize:(CGFloat)fontSize;
+ (CGFloat)scaleFontSize:(CGFloat)fontSize uiDesignWidth:(CGFloat)uiDesignWidth;

//UI设计图的宽度，默认375
@property (nonatomic, assign) CGFloat uiDesignWidth;

//根据宽度的缩放计算高度
@property (nonatomic, copy) CGFloat (^scaleViewBlock) (CGFloat value) ;

@property (nonatomic, copy) CGFloat (^scaleViewFullBlock) (CGFloat value, CGFloat uiDesignWidth);


//根据宽度的缩放计算字体
@property (nonatomic, copy) CGFloat (^scaleFontSizeBlock) (CGFloat fontSize) ;

@property (nonatomic, copy) CGFloat (^scaleFontSizeFullBlock) (CGFloat fontSize, CGFloat uiDesignWidth);



@end


@class BTTimerHelp;

@protocol BTTimerHelpDelegate <NSObject>

@optional

-(void)BTTimeChanged:(BTTimerHelp*)timer;

@end

@interface BTTimerHelp : NSObject

//间隔时间,必须调用设置
@property(nonatomic,assign)CGFloat changeTime;

//计时器目前跑的总的时间
@property(nonatomic,assign,readonly)CGFloat totalTime;


@property(nonatomic,weak,nullable)id<BTTimerHelpDelegate> delegate;

//时间变化后的block回调
@property (nonatomic, copy) void(^block)(void);

//开始,暂停后重新开始,调用相同的方法
-(void)start;

//暂停
-(void)pause;

//不使用的调用,销毁
-(void)stop;

//设置totalTime为0
-(void)resetTotalTime;

@end


@interface BTIconHelp : NSObject

//初始化方法,传入当前页面的ViewController,将基于该界面弹出相机拍照和图片选择
-(instancetype)init:(UIViewController*)vc;

//是否进行图片的裁剪
@property (nonatomic, assign) BOOL isClip;


//显示头像修改UIActionSheet
-(void)go;

//直接去选取头像，0相机、1相册
- (void)actionClick:(NSInteger)index;

@property (nonatomic, copy) void(^block)(UIImage*image);

//标题文字
@property (nonatomic, strong) NSString * actionTitle;

//相机文字,不设置会有默认文字替代
@property (nonatomic, strong) NSString * cameraTitle;

//相册文字，不设置会有默认文字替代
@property (nonatomic, strong) NSString * photoAlbumTitle;

//图片的最大长宽,为0不限制
@property (nonatomic, assign) CGFloat imgSize;

//是否需要长宽相等,在isClip=YES的时候,系统返回的才将可能不是正方形,如果为YES则会裁剪出中间的正方形部分
@property (nonatomic, assign) BOOL isNeedWidthEqualsHeight;

//取消按钮文字颜色
@property (nonatomic, strong) UIColor * cancelActionTitleColor;

//其它按钮文字颜色
@property (nonatomic, strong) UIColor * otherActionTitleColor;


//需要添加其它的选项内容
@property (nonatomic, strong) NSMutableArray<UIAlertAction*> * actions;

//是否添加在默认action的前面
@property (nonatomic, assign) BOOL isAddDefaultAction;

@end


@protocol BTKeyboardDelegate<NSObject>

@optional

- (void)keyboardWillShow:(CGFloat)keyboardH;

- (void)keyboardWillHide;

- (void)keyboardMove:(CGFloat)moveY;

- (void)keyboardDidHide;

@end

@interface BTKeyboardHelp : NSObject


/**
 初始化方法
 
 @param showView 不希望被键盘遮挡的view
 @param moveView 当键盘出现而且会遮挡住showView将会被移动的view
 @param margin showView 与键盘的间距
 @return BTKeyboardHelp
 */
- (instancetype)initWithShowView:(UIView*)showView moveView:(UIView*)moveView margin:(NSInteger)margin;

- (instancetype)initWithShowView:(UIView*)showView moveView:(UIView*)moveView;

- (instancetype)initWithShowView:(UIView*)showView;

- (instancetype)initWithShowView:(UIView*)showView margin:(NSInteger)margin;

//键盘是否打开
@property(nonatomic,assign,readonly)BOOL isKeyBoardOpen;

//代理
@property(nonatomic,weak)id<BTKeyboardDelegate> delegate;

//在界面消失的时候设置为YES,出现的时候设置为NO,以免影响其它界面的弹出
@property (nonatomic, assign) BOOL isPause;

//是否不自动移动view的坐标，只返回计算的值,默认YES
@property (nonatomic, assign) BOOL isKeyboardMoveAuto;

//需要抬高的view的约束,这个值不为空的时候则会以改变约束的值为标准执行
@property (nonatomic, strong) NSLayoutConstraint * contraintTop;

//contraintTop约束所属于的view，用于contraintTop执行动画时候的动画效果显示,如果为空则执行displayView和moveView的layoutIfNeeded方法
@property (nonatomic, strong) UIView * contraintTopView;

- (void)replaceDisplayView:(UIView*)displayView withDistance:(NSInteger)distance;

- (void)setNavTransSafeAreaStyle;

@end


@interface BTFileHelp : NSObject

/*
 默认情况下，每个沙盒含有3个文件夹：Documents, Library 和 tmp和一个应用程序文件（也是一个文件）。因为应用的沙盒机制，应用只能在几个目录下读写文件
 
 Documents：苹果建议将程序中建立的或在程序中浏览到的文件数据保存在该目录下，iTunes备份和恢复的时候会包括此目录
 
 Library：存储程序的默认设置或其它状态信息；
 
 Library/Caches：存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除
 
 tmp：提供一个即时创建临时文件的地方。
 
 iTunes在与iPhone同步时，备份所有的Documents和Library文件。
 
 iPhone在重启时，会丢弃所有的tmp文件。
 
 */

//得到沙盒的root路径
+ (NSString*)homePath;

//得到沙盒下Document文件夹的路径
+ (NSString*)documentPath;

//得到Cache文件夹的路径
+ (NSString*)cachePath;

//得到Library文件夹的路径
+ (NSString*)libraryPath;

//得到tmp文件夹的路径
+ (NSString*)tmpPath;

//获取cache目录下的图片文件夹,没有则创建
+ (NSString*)cachePicturePath;

//获取cache目录下的video文件夹,没有则创建
+ (NSString*)cacheVideoPath;

//获取cache目录下的voice文件夹,没有则创建
+ (NSString*)cacheVoicePath;

//文件是否存在
+ (BOOL)isFileExit:(NSString*)path;

//删除文件
+ (void)deleteFile:(NSString*)path;

//复制文件到某个路径
+ (void)copyFile:(NSString*)filePath toPath:(NSString*)path isOverride:(BOOL)overrid;


//创建路径
+ (void)createPath:(NSString*)path;

//在document目录下创建子文件路径
+ (void)createDocumentPath:(NSString*)path;

//保存文件到沙盒,如果存在该文件则继续写入
+ (NSString*)saveFileWithPath:(NSString*)path fileName:(NSString*)fileName data:(NSData*)data;

//保存文件到沙盒,如果存在该文件则继续写入
+ (NSString*)saveFileWithPath:(NSString*)path fileName:(NSString*)fileName data:(NSData*)data isAppend:(BOOL)isAppend;



//获取某一个文件夹下的所有文件
+ (NSArray*)getFolderAllFileName:(NSString*)folderPath fileType:(NSString*)fileType;



@end

NS_ASSUME_NONNULL_END
