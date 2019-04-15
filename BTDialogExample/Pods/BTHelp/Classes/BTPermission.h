//
//  BTPermission.h
//  doctor
//
//  Created by stonemover on 2017/12/19.
//  Copyright © 2017年 stonemover. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BTPermissionObj [BTPermission share]

typedef void(^BTPermissionSuccessBlock)(void);
typedef void(^BTPermissionBlock)(NSInteger index);

@interface BTPermission : NSObject



+ (instancetype)share;




@property (nonatomic, assign) BOOL isLocation;



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

