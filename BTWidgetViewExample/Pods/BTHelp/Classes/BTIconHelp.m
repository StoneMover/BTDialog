//
//  SMIconHelp.m
//  Base
//
//  Created by whbt_mac on 15/11/9.
//  Copyright © 2015年 StoneMover. All rights reserved.
//

#import "BTIconHelp.h"
#import "BTPermission.h"

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
    
    if (index==0&&!BTPermissionObj.isCamera) {
        [BTPermissionObj getCameraPermission:^{
            [self actionClick:index];
        }];
        return;
    }
    
    if (index==1&&!BTPermissionObj.isAlbum) {
        [BTPermissionObj getAlbumPermission:^{
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
