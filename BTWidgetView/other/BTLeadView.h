//
//  BTLeadView.h
//  BTWidgetViewExample
//
//  Created by apple on 2021/4/8.
//  Copyright © 2021 stone. All rights reserved.
//  用来展示镂空的引导页面，传入需要镂空的view，自动显示镂空效果，自己在本view中加入额外需要展示的view并且自己设置frame进行展示

#import <UIKit/UIKit.h>
#import "UIView+BTConstraint.h"
#import "UIView+BTViewTool.h"
#import <BTHelp/BTUtils.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,BTLeadEmptyType) {
    BTLeadEmptyTypeRectangle = 0, //矩形
    BTLeadEmptyTypeOval, //椭圆形
    BTLeadEmptyTypeArc  //圆形
};

@interface BTLeadModel : NSObject

- (instancetype)initWithView:(UIView*)view type:(BTLeadEmptyType)type padding:(BTPadding)padding;

- (instancetype)initWithView:(UIView*)view type:(BTLeadEmptyType)type;

+ (instancetype)modelWithView:(UIView*)view type:(BTLeadEmptyType)type padding:(BTPadding)padding;

+ (instancetype)modelWithView:(UIView*)view type:(BTLeadEmptyType)type;

//需要镂空显示的view对象，在布局完成后生成，否则坐标可能转换不成功
@property (nonatomic, strong) UIView * view;

//转换后的坐标
@property (nonatomic, assign) CGRect rect;

//镂空的间距
@property (nonatomic, assign) BTPadding padding;

//镂空的类型，
@property (nonatomic, assign) BTLeadEmptyType type;

//点击view回调
@property (nonatomic, copy, nullable) void(^blockClick)(void);


//BTLeadEmptyTypeArc,原点的偏移量
@property (nonatomic, assign) CGPoint arcMovePoint;

@end

@interface BTLeadView : UIView

- (instancetype)initWithShowView:(NSArray<BTLeadModel*>*)dataArray;

@property (nonatomic, strong, readonly) NSArray<BTLeadModel*> * dataArray;

@property (nonatomic, copy, nullable) void(^blockClick)(void);

- (void)show;

- (void)showWithOutAnim;

- (void)dismiss;

@end





NS_ASSUME_NONNULL_END
