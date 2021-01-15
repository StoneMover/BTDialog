//
//  BTNumAnimView.m
//  BTWidgetViewExample
//
//  Created by apple on 2021/1/13.
//  Copyright © 2021 stone. All rights reserved.
//

#import "BTNumAnimView.h"
#import "UIView+BTViewTool.h"

@interface BTNumAnimView()

@property (nonatomic, strong) UIView * parentView;

@property (nonatomic, strong) UIColor * color;

@property (nonatomic, strong) UIFont * font;

@property (nonatomic, assign) NSInteger nowIndex;

@property (nonatomic, assign) CGFloat oriBottom;

@end


@implementation BTNumAnimView

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor*)color font:(UIFont*)font{
    self = [super initWithFrame:frame];
    self.nowIndex = -1;
    self.color = color;
    self.font = font;
    self.clipsToBounds = YES;
    [self initChildView];
    return self;
}

- (void)initChildView{
    self.parentView = [[UIView alloc] initWithFrame:CGRectMake(0, -self.BTHeight * 10, self.BTWidth, self.BTHeight * 10)];
    for (int i=0; i<10; i++) {
        UILabel * label = [UILabel new];
        label.textColor = self.color;
        label.font = self.font;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"%d",9 - i];
        label.frame = CGRectMake(0, self.BTHeight * i, self.BTWidth, self.BTHeight);
        [self.parentView addSubview:label];
    }
    [self addSubview:self.parentView];
    self.oriBottom = self.parentView.BTBottom;
}

- (void)startAnimTo:(NSInteger)index time:(CGFloat)time{
    if (index == self.nowIndex) {
        return;
    }
    self.nowIndex = index;
    
    [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.parentView.BTBottom = self.oriBottom + (index + 1) * self.BTHeight;
    } completion:nil];
}

@end
