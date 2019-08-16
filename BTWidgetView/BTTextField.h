//
//  BTTextField.h
//  live
//
//  Created by stonemover on 2019/5/7.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BTTextFieldChangeBlock)(void);

//IB_DESIGNABLE

@interface BTTextField : UITextField

@property (nonatomic, assign) IBInspectable NSInteger maxCursorH;

@property (nonatomic, assign) IBInspectable NSInteger maxContent;

@property (nonatomic, assign) IBInspectable NSInteger kern;

@property (nonatomic, assign) IBInspectable NSInteger placeHolderFontSize;

@property (nonatomic, copy) BTTextFieldChangeBlock changeBlock;

@end


