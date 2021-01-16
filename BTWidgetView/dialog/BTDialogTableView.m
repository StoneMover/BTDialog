//
//  BTDialogTableView.m
//  BTDialogExample
//
//  Created by stonemover on 2019/4/2.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "BTDialogTableView.h"
#import <BTHelp/BTUtils.h>
#import "UIView+BTConstraint.h"
#import "BTWidgetView.h"
#import <BTHelp/UIColor+BTColor.h>
#import "UIFont+BTFont.h"

//当显示中间的时候距离屏幕两边的距离
int const BT_SHOW_VIEW_PADDING=50;

//headView 的高度
int const BT_SHOW_VIEW_HEAD_H=45;



@interface BTDialogTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIView * rootView;

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, assign) BTDialogLocation locationTable;

@end


@implementation BTDialogTableView

- (instancetype)initDialogTableView:(BTDialogLocation)location{
    self=[super init:nil withLocation:location];
    self.locationTable=location;
    [self initShowView];
    return self;
}

- (void)initShowView{
    self.maxRootHeight = 300;
    self.miniRootHeight = 300;
    self.cellHeight = 40;
    self.isNeedHead = YES;
    CGFloat rootViewW=self.locationTable==BTDialogLocationCenter?[UIScreen mainScreen].bounds.size.width-BT_SHOW_VIEW_PADDING*2:[UIScreen mainScreen].bounds.size.width;
    self.rootView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, rootViewW, 0)];
    self.rootView.backgroundColor=[UIColor whiteColor];
    [self setValue:self.rootView forKey:@"showView"];
    [self addSubview:self.rootView];
    
    self.headView=[[BTDialogTableHeadView alloc] initWithFrame:CGRectMake(0, 0, self.rootView.BTWidth, BT_SHOW_VIEW_HEAD_H)];
    [self.headView.btnCancel addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView=[[UITableView alloc] init];
    self.tableView.frame=CGRectMake(0, BT_SHOW_VIEW_HEAD_H, self.rootView.BTWidth, 0);
    [self.tableView registerClass:[BTDialogTableViewCell class] forCellReuseIdentifier:@"BTDialogTableViewCellId"];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.estimatedRowHeight = self.cellHeight;
    [self.tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    
    [self.rootView addSubview:self.headView];
    [self.rootView addSubview:self.tableView];
}


- (void)closeClick{
    [self dismiss];
}


- (void)setDataArray:(NSArray<__kindof BTDialogModel *> *)data{
    _dataArray=data;
    [self layoutRootView];
    [self.tableView reloadData];
    
}

- (void)layoutRootView{
    
    CGFloat headH=0;
    if (self.isNeedHead) {
        headH=BT_SHOW_VIEW_HEAD_H;
    }
    if (self.locationTable==BTDialogLocationTop) {
        self.headView.BTTop=BTUtils.STATUS_BAR_HEIGHT;
    }
    self.headView.BTHeight=headH;
    self.tableView.BTTop=self.headView.BTBottom;
    if (self.cellHeight==-1) {
        self.tableView.BTHeight = self.maxRootHeight;
        self.rootView.BTHeight = self.maxRootHeight;
    }else{
        if (self.dataArray.count*self.cellHeight>self.maxRootHeight-headH) {
            self.tableView.BTHeight=self.maxRootHeight-headH;
            self.rootView.BTHeight=self.maxRootHeight;
        }else{
            self.tableView.BTHeight=self.dataArray.count*self.cellHeight;
            self.rootView.BTHeight=headH+self.tableView.BTHeight;
            if (self.rootView.BTHeight<self.miniRootHeight) {
                self.rootView.BTHeight=self.miniRootHeight;
                self.tableView.BTHeight = self.miniRootHeight;
            }
            
        }
    }
    
    
    if (self.locationTable==BTDialogLocationBottom) {
        self.rootView.BTHeight+=BTUtils.HOME_INDICATOR_HEIGHT;
    }else if (self.locationTable==BTDialogLocationTop){
        self.rootView.BTHeight+=BTUtils.STATUS_BAR_HEIGHT;
    }
}

- (void)setIsNeedHead:(BOOL)isNeedHead{
    _isNeedHead=isNeedHead;
    [self layoutRootView];
}

#pragma mark tableView data delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BTDialogTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"BTDialogTableViewCellId"];
    cell.separatorInset=UIEdgeInsetsZero;
    BTDialogModel * model = self.dataArray[indexPath.row];
    cell.labelContent.text=model.title;
    cell.imgViewSelect.hidden=!model.isSelect;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeight;
}

#pragma mark tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    for (BTDialogModel * m in self.dataArray) {
        m.isSelect=NO;
    }
    BTDialogModel * model = self.dataArray[indexPath.row];
    model.isSelect=YES;
    [self.tableView reloadData];
    if (self.blockTable) {
        if (self.blockTable(indexPath.row)) {
            [self dismiss];
        }
    }
    
}




- (NSMutableArray*)createDataWithStr:(NSArray*)strArray{
    return [self createDataWithStr:strArray withSelectIndex:-1];
}


- (NSMutableArray*)createDataWithStr:(NSArray*)strArray withSelectIndex:(NSInteger)index{
    NSMutableArray * dataArray=[NSMutableArray new];
    for (int i=0; i<strArray.count; i++) {
        NSString * str=strArray[i];
        BTDialogModel * item=[BTDialogModel new];
        item.title=str;
        if (i==index) {
            item.isSelect=YES;
        }
        [dataArray addObject:item];
    }
    self.dataArray=dataArray;
    return dataArray;
}



@end




@implementation BTDialogTableHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    self.backgroundColor=[UIColor whiteColor];
    [self initLabel];
    [self initBtnCancel];
    [self initLineView];
    return self;
}

- (void)initLabel{
    self.labelTitle=[[UILabel alloc] init];
    self.labelTitle.font=[UIFont BTAutoFontWithSize:16 weight:UIFontWeightMedium];
    self.labelTitle.textColor=[UIColor blackColor];
    self.labelTitle.frame=CGRectMake(20, 0, self.BTWidth-50-20, self.BTHeight);
    [self addSubview:self.labelTitle];
}


- (void)initBtnCancel{
    self.btnCancel=[[UIButton alloc] initWithFrame:CGRectMake(self.BTWidth-50, 0, 50, self.BTHeight)];
    [self.btnCancel setImage:[BTWidgetView imageBundleName:@"bt_dialog_close"] forState:UIControlStateNormal];
    [self addSubview:self.btnCancel];
}


- (void)initLineView{
    self.lineView=[[BTLineView alloc] initWithFrame:CGRectMake(0, self.BTHeight-1, self.BTWidth, 1)];
    self.lineView.backgroundColor = [UIColor bt_RGBASame:77 A:0.25];
    [self addSubview:self.lineView];
}



@end


@implementation BTDialogModel



@end


@implementation BTDialogTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    //    self.backgroundColor=[UIColor redColor];
    [self initImgSel];
    [self initLabel];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)initLabel{
    self.labelContent=[[UILabel alloc] init];
    self.labelContent.translatesAutoresizingMaskIntoConstraints=NO;
    self.labelContent.font=[UIFont BTAutoFontWithSize:15 weight:UIFontWeightMedium];
    self.labelContent.textColor=[UIColor blackColor];
    self.labelContent.numberOfLines=0;
    [self.labelContent bt_addHeight:NSLayoutRelationGreaterThanOrEqual constant:24];
    [self addSubview:self.labelContent];
    
    [self.labelContent bt_addLeftToItemView:self constant:20];
    [self.labelContent bt_addTopToItemView:self constant:8];
    [self.labelContent bt_addBottomToItemView:self constant:-8];
    [self.labelContent bt_addRightToItemView:self constant:-10];
    
//    [self bt_addConstraintLeft:self.labelContent toItemView:self constant:20];
//    [self bt_addConstraintTop:self.labelContent toItemView:self constant:8];
//    [self bt_addConstraintBottom:self.labelContent toItemView:self constant:-8];
//    [self bt_addConstraintRight:self.labelContent toItemView:self.imgViewSelect constant:-10];
    
}

- (void)initImgSel{
    self.imgViewSelect=[[UIImageView alloc] init];
    self.imgViewSelect.contentMode=UIViewContentModeCenter;
    self.imgViewSelect.translatesAutoresizingMaskIntoConstraints=NO;
    self.imgViewSelect.image=[self imageBundleName:@"bt_dialog_select"];
    [self addSubview:self.imgViewSelect];
    
    [self.imgViewSelect bt_addRightToParent];
    [self.imgViewSelect bt_addTopToParent];
    [self.imgViewSelect bt_addBottomToParent];
    [self.imgViewSelect bt_addWidth:50];
    
//    [self bt_addConstraintRight:self.imgViewSelect toItemView:self];
//    [self bt_addConstraintTop:self.imgViewSelect toItemView:self];
//    [self bt_addConstraintBottom:self.imgViewSelect toItemView:self];
//    [self.imgViewSelect bt_addConstraintWidth:50];
}

- (UIImage*)imageBundleName:(NSString*)name{
    NSBundle * bundle = [NSBundle bundleForClass:[self class]];
    UIImage * img = [UIImage imageNamed:[NSString stringWithFormat:@"BTDialogBundle.bundle/%@",name] inBundle:bundle compatibleWithTraitCollection:nil];
    return img;
}


@end
