//
//  BTAlertLabelView.h
//  BTWidgetViewExample
//
//  Created by liao on 2019/12/27.
//  Copyright © 2019 stone. All rights reserved.
//

#import "BTAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BTAlertLabelView : BTAlertView

- (instancetype)initWithTitle:(NSString*)title msg:(NSString*)msg;

- (instancetype)initWithTitle:(NSString*)title msg:(NSString*)msg msgFont:(UIFont*)font lineSpeace:(CGFloat)lineSpeace;

@property (nonatomic, strong) UILabel * labelContent;

@end

NS_ASSUME_NONNULL_END
