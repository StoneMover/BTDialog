//
//  BTAlertTextView.h
//  BTWidgetViewExample
//
//  Created by liao on 2019/12/28.
//  Copyright © 2019 stone. All rights reserved.
//

#import "BTAlertView.h"
#import "BTTextView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BTAlertTextView : BTAlertView

- (instancetype)initWithContent:(NSString*)content placeholder:(NSString*)placeholder;

- (instancetype)initWithContent:(NSString*)content placeholder:(NSString*)placeholder height:(CGFloat)height;

@property (nonatomic, strong) BTTextView * textView;

@property (nonatomic, assign) BOOL isJustShowText;

@end

NS_ASSUME_NONNULL_END
