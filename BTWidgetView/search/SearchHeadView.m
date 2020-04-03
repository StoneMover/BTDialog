//
//  SearchHeadView.m
//  BTWidgetViewExample
//
//  Created by apple on 2020/4/3.
//  Copyright © 2020 stone. All rights reserved.
//

#import "SearchHeadView.h"
#import "UIView+BTViewTool.h"
#import <BTHelp/BTUtils.h>

@implementation SearchHeadView

- (instancetype)initSearchHead{
    self = [super initWithFrame:CGRectMake(0, 0, BTUtils.SCREEN_W, BTUtils.UI_IS_IPHONEX?88:44)];
    
    return self;
}

@end
