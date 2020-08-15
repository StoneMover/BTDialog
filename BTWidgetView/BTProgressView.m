//
//  BTProgressView.m
//  BTWidgetViewExample
//
//  Created by apple on 2020/4/28.
//  Copyright © 2020 stone. All rights reserved.
//

#import "BTProgressView.h"
#import "UIView+BTViewTool.h"

@implementation BTProgressView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self initSelf];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    [self initSelf];
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
}

- (void)initSelf{
    self.progressView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:self.progressView];
    [self layoutSubviews];
}

- (void)layoutSubviews{
    if (self.type == 0) {
        self.progressView.frame = CGRectMake(0, 0, self.BTWidth * self.percent, self.BTHeight);
    }else{
        self.progressView.frame = CGRectMake(0, 0, self.BTWidth, self.BTHeight * self.percent);
    }
}

- (void)setPercent:(CGFloat)percent{
    _percent = percent;
    [self layoutSubviews];
}

@end
