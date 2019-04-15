//
//  BTLocation.m
//  moneyMaker
//
//  Created by Motion Code on 2019/2/11.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "BTLocation.h"
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface BTLocation()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager * mananger;

@property (nonatomic, strong) CLGeocoder * geocoder;

@end


@implementation BTLocation

- (instancetype)init{
    self=[super init];
    self.mananger=[[CLLocationManager alloc] init];
    self.mananger.delegate=self;
    self.mananger.desiredAccuracy = kCLLocationAccuracyBest;
    self.mananger.distanceFilter = kCLDistanceFilterNone;
    return self;
}


- (BOOL)isHasLocationPermission{
    if ([CLLocationManager locationServicesEnabled]) {
        switch ([CLLocationManager authorizationStatus]) {
            case kCLAuthorizationStatusNotDetermined:
                [self.mananger requestWhenInUseAuthorization];
                return YES;
            case kCLAuthorizationStatusRestricted:
                return NO;
            case kCLAuthorizationStatusAuthorizedAlways:
            case kCLAuthorizationStatusAuthorizedWhenInUse:
                return YES;
            case kCLAuthorizationStatusDenied:
                return NO;
        }
    }
    
    return NO;
}

- (void)start{
    [self.mananger startUpdatingLocation];
}

- (void)stop{
    [self.mananger stopUpdatingLocation];
}



- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if(error.code == kCLErrorLocationUnknown) {
        NSLog(@"无法检索位置");
    }
    else if(error.code == kCLErrorNetwork) {
        NSLog(@"网络问题");
    }
    else if(error.code == kCLErrorDenied) {
        NSLog(@"定位权限的问题");
        [self.mananger stopUpdatingLocation];
//        [self showAlert];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation * location=[locations lastObject];
    if (!self.geocoder) {
        self.geocoder=[[CLGeocoder alloc] init];
    }
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark * k=[placemarks lastObject];
        if (self.delegate) {
            [self.delegate locationSuccess:k.administrativeArea city:k.locality];
        }
    }];
}

- (void)showAlert:(UIViewController*)vc{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"当前暂无定位权限是否前往设置？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * actionCancel =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction * actionOk =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:^(BOOL success) {
            
        }];
    }];
    
    [alertController addAction:actionCancel];
    [alertController addAction:actionOk];
    [vc presentViewController:alertController animated:YES completion:nil];
}

@end
