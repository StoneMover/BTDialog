//
//  AccountModel.m
//  framework
//
//  Created by stonemover on 2017/12/30.
//  Copyright © 2017年 StoneMover. All rights reserved.
//

#import "BTUserModel.h"

@implementation BTUserModel

-(void)initSelf{
    [super initSelf];
    self.aliasDict=@{@"userId":@"id",
                     @"userNickName":@"nick",
                     @"userMobilePhone":@"phone",
                     @"userIconUrl":@"avatar"};
}

@end
