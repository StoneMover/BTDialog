//
//  BTPermission.h
//  doctor
//
//  Created by stonemover on 2017/12/19.
//  Copyright © 2017年 stonemover. All rights reserved.
//  直接调用每个权限的获取方法即可，未选择权限的情况下会弹出权限请求框，被拒绝则会提示用户去开启
//  已经拒绝情况会直接提示用户打开权限
//  已经获得授权的会直接在block中回调，isCamera等参数只是提供外部判断的一个方便的途径

#import <Foundation/Foundation.h>

#define BTPermissionObj [BTPermission share]

typedef void(^BTPermissionSuccessBlock)(void);
typedef void(^BTPermissionBlock)(NSInteger index);

@interface BTPermission : NSObject



+ (instancetype)share;


//请求获取相机权限
@property (nonatomic, assign) BOOL isCamera;
- (void)getCameraPermission:(BTPermissionSuccessBlock)block;
- (void)getCameraPermission:(NSString*)meg success:(BTPermissionSuccessBlock)block;


//请求获取相册权限
@property (nonatomic, assign) BOOL isAlbum;
- (void)getAlbumPermission:(BTPermissionSuccessBlock)block;
- (void)getAlbumPermission:(NSString*)meg success:(BTPermissionSuccessBlock)block;



//请求麦克风权限
@property (nonatomic, assign) BOOL isMic;
- (void)getMicPermission:(BTPermissionSuccessBlock)block;
- (void)getMicPermission:(NSString*)meg success:(BTPermissionSuccessBlock)block;



@end

