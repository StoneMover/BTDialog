//
//  BTTextView.h
//  word
//
//  Created by stonemover on 2019/3/13.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BTTextViewMaxBlock)(void);
typedef void(^BTTextViewHeightChangeBlock)(CGFloat height);
typedef void(^BTTextViewTextChangeBlock)(void);

IB_DESIGNABLE

@interface BTTextView : UITextView

@property (nonatomic, strong) IBInspectable NSString * placeHolder;

@property (nonatomic, strong) IBInspectable UIColor * placeHolderColor;

@property (nonatomic, assign) IBInspectable NSInteger maxStrNum;

@property (nonatomic, assign) IBInspectable NSInteger lineSpeac;

@property (nonatomic, strong) UILabel * labelPlaceHolder;

@property (nonatomic, copy) BTTextViewMaxBlock blockMax;

@property (nonatomic, copy) BTTextViewHeightChangeBlock blockHeightChange;

@property (nonatomic, copy) BTTextViewTextChangeBlock blockContentChange;

@end


