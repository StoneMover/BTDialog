//
//  BTDialogTableView.h
//  BTDialogExample
//
//  Created by stonemover on 2019/4/2.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "BTDialogView.h"
#import "BTLineView.h"


@class BTDialogTableHeadView;

@interface BTDialogTableView : BTDialogView

//头部view
@property(strong, nonatomic) BTDialogTableHeadView * headView;

//数据源
@property (strong, nonatomic) NSArray * dataArray;

//返回bool值来表明是否关闭view
@property (nonatomic, copy) BOOL(^blockTable)(NSInteger index);

//是否需要头部,默认为true
@property (nonatomic, assign) BOOL isNeedHead;

//rootView 最小的高度,默认300
@property (nonatomic, assign) CGFloat miniRootHeight;

//rootView 的最大高度,默认300
@property (nonatomic, assign) CGFloat maxRootHeight;

//cell的高度，默认45，如果为-1则为高度自适应，如果是高度自适应的话rootView、tableView的高度会被设置为maxRootHeight
@property (nonatomic, assign) CGFloat cellHeight;


//初始化方法
- (instancetype)initDialogTableView:(BTDialogLocation)location;



//根据传入的字符串生成数据
-(NSMutableArray*)createDataWithStr:(NSArray*)strArray;
-(NSMutableArray*)createDataWithStr:(NSArray*)strArray
                    withSelectIndex:(NSInteger)index;

@end



@interface BTDialogTableHeadView:UIView

@property(strong, nonatomic) UIButton * btnCancel;//取消按钮

@property(strong, nonatomic) UILabel * labelTitle;//头部label

@property(strong, nonatomic) BTLineView * lineView;//头部分割线

@end


@interface BTDialogModel:NSObject

@property (nonatomic, strong) NSString * title; //需要显示的标题

@property (nonatomic, assign) BOOL isSelect;

@end

@interface BTDialogTableViewCell : UITableViewCell

@property (strong, nonatomic)  UILabel * labelContent;

@property (strong, nonatomic)  UIImageView * imgViewSelect;

@end

