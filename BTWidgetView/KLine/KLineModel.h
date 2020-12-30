//
//  KLineModel.h
//  BTWidgetViewExample
//
//  Created by apple on 2020/12/30.
//  Copyright © 2020 stone. All rights reserved.
//

#import <BTHelp/BTHelp.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLineModel : BTModel

// 成交量
@property (nonatomic) NSString * curvol;

//时间
@property (nonatomic) NSString * times;

//最高
@property (nonatomic) CGFloat highp;

//最低
@property (nonatomic) CGFloat lowp;

//开盘
@property (nonatomic) CGFloat openp;

//收盘价
@property (nonatomic) CGFloat nowv;

//前一天的收盘价
@property (nonatomic) CGFloat preclose;


@end

NS_ASSUME_NONNULL_END
