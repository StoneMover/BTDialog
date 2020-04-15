//
//  BTWidgetView.m
//  BTWidgetViewExample
//
//  Created by apple on 2020/4/15.
//  Copyright © 2020 stone. All rights reserved.
//

#import "BTWidgetView.h"

@implementation BTWidgetView

+ (UIImage*)imageBundleName:(NSString*)name{
    NSBundle * bundle = [NSBundle bundleForClass:[self class]];
    UIImage * img = [UIImage imageNamed:[NSString stringWithFormat:@"BTDialogBundle.bundle/%@",name] inBundle:bundle compatibleWithTraitCollection:nil];
    return img;
}

@end
