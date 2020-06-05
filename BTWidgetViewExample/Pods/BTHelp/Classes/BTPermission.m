//
//  BTPermission.m
//  doctor
//
//  Created by stonemover on 2017/12/19.
//  Copyright © 2017年 stonemover. All rights reserved.
//

#import "BTPermission.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <CoreLocation/CLLocationManager.h>
#import "BTUtils.h"


static BTPermission * permission;



@implementation BTPermission

+(instancetype)share{
    if (!permission) {
        permission=[[BTPermission alloc]init];
    }
    
    return permission;
}

-(instancetype)init{
    self=[super init];
    return self;
}


//请求获取相机权限
- (BOOL)isCamera{
    NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
    if (authStatus!=AVAuthorizationStatusAuthorized) {
        return NO;
    }
    
    return YES;
}
- (void)getCameraPermission:(BTPermissionSuccessBlock)block{
    [self getCameraPermission:nil success:block];
}
- (void)getCameraPermission:(NSString*)meg success:(BTPermissionSuccessBlock)block{
    if (!meg) {
        meg=@"当前没有相机权限,是否前往设置?";
    }
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];//读取设备授权状态
    if (authStatus==AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!granted){
                    [self showSysAlert:@"温馨提示"
                              messages:meg?meg:@"当前没有相机权限,是否前往设置?"
                                  btns:@[@"取消",@"确定"]
                                 block:^(NSInteger index) {
                                     if (index==1) {
                                         [BTUtils openSetVc];
                                     }
                                 }];
                }else{
                    if (block) {
                        block();
                    }
                }
            });
        }];
        return;
    }
    
    
    if (!self.isCamera) {
        [self showSysAlert:@"温馨提示"
                  messages:meg
                      btns:@[@"取消",@"确定"]
                     block:^(NSInteger index) {
                         if (index==1) {
                             [BTUtils openSetVc];
                         }
                     }];
    }else{
        if (block) {
            block();
        }
    }
    
}


//请求获取相册权限
- (BOOL)isAlbum{
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    if (authStatus!=PHAuthorizationStatusAuthorized) {
        return NO;
    }
    return YES;
}

- (void)getAlbumPermission:(BTPermissionSuccessBlock)block{
    [self getAlbumPermission:nil success:block];
}

- (void)getAlbumPermission:(NSString*)meg success:(BTPermissionSuccessBlock)block{
    if (!meg) {
        meg=@"当前没有相册权限,是否前往设置?";
    }
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    
    if (authStatus==PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (status == PHAuthorizationStatusDenied || status == PHAuthorizationStatusRestricted) {
                    // 没有权限
                    [self showSysAlert:@"温馨提示"
                              messages:meg
                                  btns:@[@"取消",@"确定"]
                                 block:^(NSInteger index) {
                                     if (index==1) {
                                         [BTUtils openSetVc];
                                     }
                                 }];
                }else{
                    if (block) {
                        block();
                    }
                }
            });
            
        }];
        return;
    }
    
    if (!self.isAlbum) {
        [self showSysAlert:@"温馨提示"
                  messages:meg
                      btns:@[@"取消",@"确定"]
                     block:^(NSInteger index) {
                         if (index==1) {
                             [BTUtils openSetVc];
                         }
                     }];
    }else{
        if (block) {
            block();
        }
    }
    
    
    
}

//请求麦克风权限
- (BOOL)isMic{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (authStatus!=AVAuthorizationStatusAuthorized) {
        return NO;
    }
    
    return YES;
}
- (void)getMicPermission:(BTPermissionSuccessBlock)block{
    [self getMicPermission:nil success:block];
}
- (void)getMicPermission:(NSString*)meg success:(BTPermissionSuccessBlock)block{
    if (!meg) {
        meg=@"当前没有麦克风权限,是否前往设置?";
    }
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];//读取设备授权状态
    if (authStatus==AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!granted){
                    [self showSysAlert:@"温馨提示"
                              messages:meg
                                  btns:@[@"取消",@"确定"]
                                 block:^(NSInteger index) {
                                     if (index==1) {
                                         [BTUtils openSetVc];
                                     }
                                 }];
                }else{
                    if (block) {
                        block();
                    }
                }
            });
        }];
        
        return;
    }
    
    if (!self.isMic) {
        [self showSysAlert:@"温馨提示"
                  messages:meg
                      btns:@[@"取消",@"确定"]
                     block:^(NSInteger index) {
                         if (index==1) {
                             [BTUtils openSetVc];
                         }
                     }];
    }else{
        if (block) {
            block();
        }
    }
}



- (void)showSysAlert:(NSString*)title
            messages:(NSString*)message
                btns:(NSArray<NSString*>*)btns
               block:(BTPermissionBlock)block{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    __weak UIAlertController * weakAlerController=alertController;
    for (NSString * str in btns) {
        UIAlertAction * action =[UIAlertAction actionWithTitle:str
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           
                                                           NSInteger index=[weakAlerController.actions indexOfObject:action];
                                                           block(index);
                                                       }];
        [alertController addAction:action];
    }
    //    UIWindow * window=[[UIApplication sharedApplication] delegate].window;
    [[BTUtils getCurrentVc] presentViewController:alertController animated:YES completion:nil];
}




@end

