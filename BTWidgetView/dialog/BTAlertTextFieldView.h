//
//  BTAlertTextFieldView.h
//  BTWidgetViewExample
//
//  Created by liao on 2019/12/27.
//  Copyright © 2019 stone. All rights reserved.
//

#import "BTAlertView.h"
#import "BTTextField.h"

@interface BTAlertTextFieldView : BTAlertView

- (instancetype)initWithContent:(NSString*)content placeholder:(NSString*)placeholder;

@property (nonatomic, strong) BTTextField * textField;

@end


