//
//  AccountModel.h
//  framework
//
//  Created by stonemover on 2017/12/30.
//  Copyright © 2017年 StoneMover. All rights reserved.
//

#import "BTModel.h"

@interface BTUserModel : BTModel

@property(nonatomic,strong) NSString * userName;//用户名

@property(nonatomic,strong) NSString * userToken;//用户token

@property(nonatomic,strong) NSString * userId;//用户id

@property(nonatomic,strong) NSString * userNickName;//用户昵称

@property(nonatomic,strong) NSString * userSex;//用户性别,默认为男

@property(nonatomic,strong) NSString * userPassWord;//用户密码

@property(nonatomic,strong) NSString * userIconUrl;//用户头像

@property(nonatomic,strong) NSString * userMobilePhone;//用户手机号码

@property(nonatomic,strong) NSString * userEmail;//用户邮箱

@property (nonatomic, strong) NSString * sessionID;//会话id

@property (nonatomic, strong) NSString * city;//城市

@property (nonatomic, strong) NSString * country;//国家

@property (nonatomic, strong) NSString * province;//省份

#pragma mark 项目添加


@end
