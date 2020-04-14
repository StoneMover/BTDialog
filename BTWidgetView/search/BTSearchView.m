//
//  BTSearchView.m
//  BTWidgetViewExample
//
//  Created by apple on 2020/4/14.
//  Copyright © 2020 stone. All rights reserved.
//

#import "BTSearchView.h"

@implementation BTSearchView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    __weak BTSearchView * weakSelf=self;
    self.viewHead = [[BTSearchHeadView alloc] initSearchHead];
    self.viewHead.cancelClickBlock = ^{
        
    };
    [self addSubview:self.viewHead];
    
    return self;
}

- (void)layoutSubviews{
    
}

- (void)show:(UIView*)view{
    
}

@end
