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

- (void)start;
- (void)stop;
- (BOOL)isHasLocationPermission;
- (void)showAlert:(UIViewController*)vc;

@property (nonatomic, weak) id<BTLocationDelegate>  delegate;

@end


