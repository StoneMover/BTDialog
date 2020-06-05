//
//  ApplePay.h
//  live
//
//  Created by stonemover on 2019/7/17.
//  Copyright © 2019 stonemover. All rights reserved.
//  1.设置用户id
//  2.检查该用户是否有丢失的凭证存在本地，如果有则自己处理，处理完成后调用移除凭证的方法removeReceiptModel
//  3.设置需要请求的requestProducts，在内购中自己设置的数据->请求内购数据requestProducts->传入产品id进行购买->购买成功后会自动存储一条凭证，自己与服务器确认后移除凭证


#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "BTModel.h"
#import "BTUtils.h"

@class BTApplePayReceiptModel;

@protocol ApplePayDelegate <NSObject>

//获取商品信息成功回调
- (void)BTApplePayRequestSuccess:(NSArray*)dictArray;
- (void)BTApplePayRequestFail:(NSError*)error;

//请求完成回调，可以不用处理，如果成功会先调用BTApplePayRequestSuccess再调用此方法
- (void)BTApplePayRequestFinish;

//购买失败回调
- (void)BTApplePayBuyFail:(NSString*)failInfo;

//购买成功回调
- (void)BTApplePayBuySuccess:(NSString*)payment;


@end


@interface BTApplePay : NSObject



+ (instancetype)share;

//用户的ID,用来存储丢失凭证，在下次登录后重新获取对应的数据，在使用类的时候需要优先设置
@property (nonatomic, strong) NSString * userId;

//需要查询的商品id数组
@property (nonatomic, strong) NSArray * productId;

@property (nonatomic, weak) id<ApplePayDelegate> delegate;

//是否开启了内购
- (BOOL)isCanMakePayments;

//请求前先设置商品id数组：productId
- (void)requestProducts;

//是否已经获取了商品
- (BOOL)isGetProduct;

//购买某个商品，外部调用需保证一个购买流程完成后才能进行下一个，即只能有一个购买在同一时间进行
- (void)buy:(NSString*)productId applicationUsername:(NSString*)applicationUsername;

//保存凭证，每次购买完成后会直接存储，自己在与服务器确认购买后自己移除
- (void)saveReceiptModel:(BTApplePayReceiptModel*)model;

//移除本地的缓存，传入凭证
- (void)removeReceiptModel:(NSString*)receipt;

//检查是否有本地缓存凭证，先设置用户ID
- (BTApplePayReceiptModel*)checkLostReceiptModel;

@end


@interface BTApplePayReceiptModel : BTModel

@property (nonatomic, strong) NSString * receipt;

@property (nonatomic, strong) NSString * userId;

@property (nonatomic, strong) NSString * applicationUsername;

@end
