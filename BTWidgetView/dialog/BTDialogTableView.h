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

//返回bool值来表明是否关闭view
typedef BOOL (^BTDialogTableViewBlock)(NSInteger index);

@interface BTDialogTableView : BTDialogView

//头部view
@property(strong, nonatomic) BTDialogTableHeadView * headView;

//数据源
@property (strong, nonatomic) NSArray * dataArray;


@property (nonatomic, copy) BTDialogTableViewBlock blockTable;


@property (nonatomic, assign) BOOL isNeedHead;


//@property (nonatomic, assign) BOOL isNeedFoot;


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

