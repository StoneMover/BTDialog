//
//  BTAlertView.h
//  word
//
//  Created by liao on 2019/12/21.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface BTAlertView : UIView

- (instancetype)initWithcontentView:(UIView*)contentView;

@property (nonatomic, strong) UILabel * labelTitle;

@property (nonatomic, strong) UIButton * btnCancel;

@property (nonatomic, strong) UIButton * btnOk;

@property (nonatomic, strong) UIView * viewLineHoz;

@property (nonatomic, strong) UIView * viewLineVertical;

@property (nonatomic, strong) UIView * contentView;

@property (nonatomic, copy) BOOL(^cancelBlock)(void);

@property (nonatomic, copy) BOOL(^okBlock)(void);


@property (nonatomic, assign) BOOL isJustOkBtn;

@end


