//
//  AccountMananger.m
//  Base
//
//  Created by whbt_mac on 15/9/17.
//  Copyright (c) 2015年 StoneMover. All rights reserved.
//

#import "BTUserMananger.h"
//#import "LoginViewController.h"

//指针和内容都不允许改变,如果写成 const NSString * str的形式,则只表示指针不可修改
NSString * const KEY_IS_FIRST_OPEN_APP =@"KEY_IS_FIRST_OPEN_APP";
NSString * const KEY_ACCOUNT_CACHE =@"KEY_ACCOUNT_CACHE";
NSString * const KEY_AUTO_LOGIN =@"KEY_AUTO_LOGIN";
NSString * const KEY_REMERBER_PWD=@"KEY_REMERBER_PWD";
NSString * const KEY_PWD=@"KEY_PWD";
NSString * const KEY_USER_INFO=@"KEY_USER_INFO";


NSString * const KEY_IS_NO_WIFI_DOWNLOAD=@"KEY_IS_NO_WIFI_DOWNLOAD";


static BTUserMananger*mananger=nil;

NSUserDefaults * defaults;



@implementation BTUserMananger


-(instancetype)init{
    self=[super init];
    defaults = [NSUserDefaults standardUserDefaults];
    //设置默认值
    NSDictionary *defaultValues = @{KEY_IS_FIRST_OPEN_APP:@YES};
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
    
    self.isFirstOpenApp=[defaults boolForKey:KEY_IS_FIRST_OPEN_APP];
    self.isAllowNoWifiDownload=[defaults boolForKey:KEY_IS_NO_WIFI_DOWNLOAD];
    self.accountCache=[defaults objectForKey:KEY_ACCOUNT_CACHE];
    self.isAutoLogin=[defaults boolForKey:KEY_AUTO_LOGIN];
    self.isRemerberPwd=[defaults boolForKey:KEY_REMERBER_PWD];
    self.model=[BTUserModel modelWithDict:[defaults dictionaryForKey:KEY_USER_INFO]];
    self.isNeedUpdateInfoView=YES;
    return self;
}


+(BTUserMananger*)share{
    if (mananger==nil) {
        mananger=[[BTUserMananger alloc] init];
    }
    return mananger;
}

-(void)setIsFirstOpenApp:(BOOL)isFirstOpenApp{
    _isFirstOpenApp=isFirstOpenApp;
    [defaults setBool:isFirstOpenApp forKey:KEY_IS_FIRST_OPEN_APP];
}

-(void)setAccountCache:(NSString *)accountCache{
    _accountCache=accountCache;
    [defaults setValue:accountCache forKey:KEY_ACCOUNT_CACHE];
}

-(void)setIsAutoLogin:(BOOL)isAutoLogin{
    _isAutoLogin=isAutoLogin;
    [defaults setBool:isAutoLogin forKey:KEY_AUTO_LOGIN];
}

-(void)setIsRemerberPwd:(BOOL)isRemerberPwd{
    _isRemerberPwd=isRemerberPwd;
    [defaults setBool:isRemerberPwd forKey:KEY_REMERBER_PWD];
}

- (void)updateUserInfo{
    NSDictionary * dic=[self.model autoDataToDictionary];
    [defaults setObject:dic forKey:KEY_USER_INFO];
    [defaults synchronize];
}


-(void)clearUserData{
    self.isAllowNoWifiDownload=NO;
    self.isAutoLogin=NO;
    self.isRemerberPwd=NO;
    
    NSDictionary * dic=[[NSDictionary alloc]init];
    [defaults setObject:dic forKey:KEY_USER_INFO];
    self.model=[BTUserModel modelWithDict:dic];
}

-(BOOL)isLogin{
    if (self.model&&self.model.userId&&self.model.userId.length>0) {
        return YES;
    }
    return NO;
}


- (BOOL)isLoginPush:(UIViewController*)rootVc{
    BOOL islogin=[self isLogin];
    if (self.loginVcName) {
        Class cls = NSClassFromString(self.loginVcName);
        UIViewController *vc = [[cls alloc] init];
        if ([vc isKindOfClass:[UIViewController class]]) {
            [rootVc.navigationController pushViewController:vc animated:YES];
        }
    }
    return islogin;
}

@end
