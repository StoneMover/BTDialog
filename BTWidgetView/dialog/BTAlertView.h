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

//标题label
@property (nonatomic, strong) UILabel * labelTitle;

//取消按钮
@property (nonatomic, strong) UIButton * btnCancel;

//确定按钮
@property (nonatomic, strong) UIButton * btnOk;

//横向的线
@property (nonatomic, strong) UIView * viewLineHoz;

//竖向的线
@property (nonatomic, strong) UIView * viewLineVertical;

//需要展示的内容
@property (nonatomic, strong) UIView * contentView;

//取消回调
@property (nonatomic, copy) BOOL(^cancelBlock)(void);

//确定回调
@property (nonatomic, copy) BOOL(^okBlock)(void);

//是否只需要确定按钮
@property (nonatomic, assign) BOOL isJustOkBtn;

@end


