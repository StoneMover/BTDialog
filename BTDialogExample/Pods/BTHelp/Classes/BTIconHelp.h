//
//  SMIconHelp.h
//  Base
//
//  Created by whbt_mac on 15/11/9.
//  Copyright © 2015年 StoneMover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void(^BTIconBlock)(UIImage*image);


@interface BTIconHelp : NSObject

//初始化方法,传入当前页面的ViewController,将基于该界面弹出相机拍照和图片选择
-(instancetype)init:(UIViewController*)vc;

//是否进行图片的裁剪
@property (nonatomic, assign) BOOL isClip;


//显示头像修改UIActionSheet
-(void)go;

@property (nonatomic, copy) BTIconBlock block;

@property (nonatomic, strong) NSString * actionTitle;

//图片的最大长宽,为0不限制
@property (nonatomic, assign) CGFloat imgSize;

//是否需要长宽相等,在isClip=YES的时候,系统返回的才将可能不是正方形,如果为YES则会裁剪出中间的正方形部分
@property (nonatomic, assign) BOOL isNeedWidthEqualsHeight;

@end
