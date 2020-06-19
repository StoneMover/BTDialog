//
//  BTLocation.h
//  moneyMaker
//
//  Created by Motion Code on 2019/2/11.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BTLocationDelegate <NSObject>

- (void)locationSuccess:(NSString*)province city:(NSString*)city;

@end

@interface BTLocation : NSObject

//开始定位
- (void)start;

//停止定位
- (void)stop;

//是否有定位权限
- (BOOL)isHasLocationPermission;

//显示没有权限的弹框
- (void)showAlert:(UIViewController*)vc;

@property (nonatomic, weak) id<BTLocationDelegate>  delegate;

@end


