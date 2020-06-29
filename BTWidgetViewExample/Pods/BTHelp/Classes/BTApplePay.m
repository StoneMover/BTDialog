//
//  ApplePay.m
//  live
//
//  Created by stonemover on 2019/7/17.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "BTApplePay.h"
#import "NSString+BTString.h"

static BTApplePay * help =nil;


@interface BTApplePay()<SKPaymentTransactionObserver,SKProductsRequestDelegate>

// 所有商品
@property (nonatomic, strong)NSArray *products;

@property (nonatomic, strong)SKProductsRequest *request;

@property (nonatomic, strong) NSMutableArray * dataArrayDict;

@property (nonatomic, assign) BOOL isLoading;

@property (nonatomic, assign) BOOL isRequesting;

@property (nonatomic, assign) BOOL isBuying;

@end


@implementation BTApplePay


+ (instancetype)share{
    if (!help) {
        help=[[BTApplePay alloc] init];
        [[SKPaymentQueue defaultQueue] addTransactionObserver:help];
    }
    
    return help;
}

- (instancetype)init{
    self=[super init];
    self.dataArrayDict=[NSMutableArray new];
    return self;
}

- (void)dealloc {
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

- (BOOL)isCanMakePayments{
    // 您的手机没有打开程序内付费购买
    return [SKPaymentQueue canMakePayments];
}

// 请求可卖的商品
- (void)requestProducts;
{
    if (![self isCanMakePayments]) {
        return;
    }
    
    if (self.products) {
        [self requestProductSuccess];
        return;
    }
    
    if (self.isRequesting) {
        return;
    }
    self.isRequesting=YES;
    NSSet *set = [NSSet setWithArray:self.productId];
    self.request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
    self.request.delegate = self;
    [self.request start];
}

- (BOOL)isGetProduct{
    if (self.products) {
        return YES;
    }
    
    return NO;
}

#pragma mark SKProductsRequestDelegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    self.isRequesting=NO;
    
    
    for (SKProduct *product in response.products) {
        // 用来保存价格
        NSMutableDictionary *priceDic = @{}.mutableCopy;
        // 货币单位
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
        [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [numberFormatter setLocale:product.priceLocale];
        // 带有货币单位的价格
        NSString *formattedPrice = [numberFormatter stringFromNumber:product.price];
        [priceDic setObject:formattedPrice forKey:product.productIdentifier];
//        BTLog(@"价格:%@，标题:%@，描述:%@，productid:%@", product.price,product.localizedTitle,product.localizedDescription,product.productIdentifier);
    }
    
    self.products = response.products;
    self.products = [self.products sortedArrayWithOptions:NSSortConcurrent usingComparator:^NSComparisonResult(SKProduct *obj1, SKProduct *obj2) {
        return [obj1.price compare:obj2.price];
    }];
    for (SKProduct *product in self.products) {
        NSMutableDictionary * dict =[NSMutableDictionary new];
        [dict setValue:product.price forKey:@"price"];
        [dict setValue:product.localizedTitle forKey:@"title"];
        [dict setValue:product.localizedDescription forKey:@"localizedDescription"];
        [dict setValue:product.productIdentifier forKey:@"productIdentifier"];
        [self.dataArrayDict addObject:dict];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self requestProductSuccess];
    });
    
}

- (void)requestDidFinish:(SKRequest *)request{
    self.isRequesting=NO;
    dispatch_async(dispatch_get_main_queue(), ^{
       if (self.delegate && [self.delegate respondsToSelector:@selector(BTApplePayRequestFinish)]) {
           [self.delegate BTApplePayRequestFinish];
       }
    });
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    self.isRequesting=NO;
    
    dispatch_async(dispatch_get_main_queue(), ^{
       if (self.delegate && [self.delegate respondsToSelector:@selector(BTApplePayRequestFail:)]) {
           [self.delegate BTApplePayRequestFail:error];
       }
    });
    
    
    
}

#pragma mark 逻辑方法
- (void)requestProductSuccess{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(BTApplePayRequestSuccess:)]) {
        [self.delegate BTApplePayRequestSuccess:self.dataArrayDict];
    }
}

- (SKProduct*)productWithId:(NSString*)productId{
    for (SKProduct *product in self.products) {
        if ([product.productIdentifier isEqualToString:productId]) {
            return product;
        }
    }
    
    return nil;
}


#pragma mark 购买相关
- (void)buy:(NSString*)productId applicationUsername:(NSString*)applicationUsername{
    if (self.isBuying) {
        return;
    }
    
    if (!productId||productId.length==0) {
        return;
    }
    
    SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:[self productWithId:productId]];
    if (applicationUsername) {
        payment.applicationUsername=applicationUsername;
    }
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    /*
     SKPaymentTransactionStatePurchasing, 正在购买
     SKPaymentTransactionStatePurchased, 购买完成(销毁交易)
     SKPaymentTransactionStateFailed, 购买失败(销毁交易)
     SKPaymentTransactionStateRestored, 恢复购买(销毁交易)
     SKPaymentTransactionStateDeferred 最终状态未确定
     */
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"用户正在购买");
                break;
                
            case SKPaymentTransactionStatePurchased:
            {
                NSURL * receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
                NSData * receipt = [NSData dataWithContentsOfURL:receiptURL];
                NSString * transactionReceiptString = [receipt base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                if ([BTUtils isEmpty:transactionReceiptString]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                       if (self.delegate&&[self.delegate respondsToSelector:@selector(BTApplePayBuyFail:)]) {
                           [self.delegate BTApplePayBuyFail:@"购买失败:凭证获取失败,重启应用后将重新获取凭证"];
                       }
                    });
                    
                }else{
                    //将凭证、用户id、applicationUsername、存储为一条数据，在与服务器验证成功之后删除
                    BTApplePayReceiptModel * receiptModel =[BTApplePayReceiptModel new];
                    receiptModel.receipt=transactionReceiptString;
                    receiptModel.applicationUsername=transaction.payment.applicationUsername;
                    receiptModel.userId=self.userId;
                    [self saveReceiptModel:receiptModel];
                    dispatch_async(dispatch_get_main_queue(), ^{
                       if (self.delegate&&[self.delegate respondsToSelector:@selector(BTApplePayBuySuccess:)]) {
                           [self.delegate BTApplePayBuySuccess:transactionReceiptString];
                       }
                    });
                    
                    [queue finishTransaction:transaction];
                    NSLog(@"购买成功-票据：%@,productIdentifier,%@,applicationUsername%@，userId:%@",receiptModel.receipt,transaction.payment.productIdentifier,receiptModel.applicationUsername,self.userId);
                }
                
            }
                break;
                
            case SKPaymentTransactionStateFailed:
            {
                NSLog(@"购买失败");
                [queue finishTransaction:transaction];
                dispatch_async(dispatch_get_main_queue(), ^{
                   
                    if (self.delegate&&[self.delegate respondsToSelector:@selector(BTApplePayBuyFail:)]) {
                        [self.delegate BTApplePayBuyFail:@"购买失败"];
                    }
                    
                });
            }
                break;
                
            case SKPaymentTransactionStateRestored:
            {
                NSLog(@"恢复购买");
                [queue finishTransaction:transaction];
            }
                break;
                
            case SKPaymentTransactionStateDeferred:
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                   
                    if (self.delegate&&[self.delegate respondsToSelector:@selector(BTApplePayBuyFail:)]) {
                        [self.delegate BTApplePayBuyFail:@"购买失败:最终状态未确定"];
                    }
                    
                });

                NSLog(@"最终状态未确定");
                
            }
                break;
                
            default:
                break;
        }
    }
}


// 恢复购买
- (void)restore
{
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error {
    // 恢复失败
    
}

- (void)saveReceiptModel:(BTApplePayReceiptModel*)model{
    [self removeReceiptModel:model.receipt];
    NSDictionary * dict =[model autoDataToDictionary];
    NSArray * cacheArray=[[NSUserDefaults standardUserDefaults] objectForKey:@"BT_APPLE_PAY_CACHE"];
    if (!cacheArray) {
        [[NSUserDefaults standardUserDefaults]setObject:@[dict] forKey:@"BT_APPLE_PAY_CACHE"];
    }else{
        NSMutableArray * dataArray=[[NSMutableArray alloc] initWithArray:cacheArray];
        [dataArray addObject:dict];
        [[NSUserDefaults standardUserDefaults]setObject:[NSArray arrayWithArray:dataArray] forKey:@"BT_APPLE_PAY_CACHE"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)removeReceiptModel:(NSString*)receipt{
    NSArray * cacheArray=[[NSUserDefaults standardUserDefaults] objectForKey:@"BT_APPLE_PAY_CACHE"];
    if (!cacheArray) {
        return;
    }
    
    NSMutableArray * dataArray=[[NSMutableArray alloc] initWithArray:cacheArray];
    
    for (NSDictionary * dict in dataArray) {
        BTApplePayReceiptModel * m =[BTApplePayReceiptModel modelWithDict:dict];
        if ([m.receipt isEqualToString:receipt]) {
            [dataArray removeObject:dict];
            break;
        }
    }
    
    [[NSUserDefaults standardUserDefaults]setObject:[NSArray arrayWithArray:dataArray] forKey:@"BT_APPLE_PAY_CACHE"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BTApplePayReceiptModel*)checkLostReceiptModel{
    NSArray * cacheArray=[[NSUserDefaults standardUserDefaults] objectForKey:@"BT_APPLE_PAY_CACHE"];
    if (!cacheArray) {
        return nil;
    }
    
    NSMutableArray * dataArray=[[NSMutableArray alloc] initWithArray:cacheArray];
    
    for (NSDictionary * dict in dataArray) {
        BTApplePayReceiptModel * m =[BTApplePayReceiptModel modelWithDict:dict];
        if ([m.userId isEqualToString:self.userId]) {
            return m;
        }
    }
    
    return nil;
}


@end

@implementation BTApplePayReceiptModel

@end
