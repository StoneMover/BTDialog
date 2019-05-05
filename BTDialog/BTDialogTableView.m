//
//  BTDialogTableView.m
//  BTDialogExample
//
//  Created by stonemover on 2019/4/2.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "BTDialogTableView.h"
#import "BTDialogTableViewCell.h"
#import <BTHelp/BTUtils.h>

int const BT_SHOW_VIEW_MAX_H=300;

int const BT_SHOW_VIEW_PADDING=50;

int const BT_SHOW_VIEW_HEAD_H=45;

int const BT_SHOW_VIEW_CELL_H=40;


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
    
    CGFloat rootViewW=self.locationTable==BTDialogLocationCenter?[UIScreen mainScreen].bounds.size.width-BT_SHOW_VIEW_PADDING*2:[UIScreen mainScreen].bounds.size.width;
    self.rootView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, rootViewW, 0)];
    self.rootView.backgroundColor=[UIColor whiteColor];
    [self setValue:self.rootView forKey:@"showView"];
    [self addSubview:self.rootView];
    
    self.headView=[[BTDialogTableHeadView alloc] initWithFrame:CGRectMake(0, 0, self.rootView.width, BT_SHOW_VIEW_HEAD_H)];
    [self.headView.btnCancel addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView=[[UITableView alloc] init];
    self.tableView.frame=CGRectMake(0, BT_SHOW_VIEW_HEAD_H, self.rootView.width, 0);
    [self.tableView registerClass:[BTDialogTableViewCell class] forCellReuseIdentifier:@"BTDialogTableViewCellId"];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.estimatedRowHeight = BT_SHOW_VIEW_PADDING;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
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
    CGFloat footH=0;
    if (self.isNeedHead) {
        headH=BT_SHOW_VIEW_HEAD_H;
    }
    if (self.locationTable==BTDialogLocationTop) {
        self.headView.top=BTUtils.STATUS_BAR_HEIGHT;
    }
    self.headView.height=headH;
    self.tableView.top=self.headView.bottom;
    
    if (self.dataArray.count*BT_SHOW_VIEW_CELL_H>BT_SHOW_VIEW_MAX_H-headH) {
        self.tableView.height=BT_SHOW_VIEW_MAX_H-headH;
        self.rootView.height=BT_SHOW_VIEW_MAX_H;
        self.tableView.scrollEnabled=YES;
    }else{
        self.tableView.height=self.dataArray.count*BT_SHOW_VIEW_CELL_H;
        self.rootView.height=headH+self.tableView.height;
        
        if (self.rootView.height<100) {
            self.rootView.height=100;
        }
        self.tableView.scrollEnabled=NO;
    }
    if (self.locationTable==BTDialogLocationBottom) {
        self.rootView.height+=BTUtils.HOME_INDICATOR_HEIGHT;
    }else if (self.locationTable==BTDialogLocationTop){
        self.rootView.height+=BTUtils.STATUS_BAR_HEIGHT;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BT_SHOW_VIEW_CELL_H;
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
    self.labelTitle.font=[UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    self.labelTitle.textColor=[UIColor blackColor];
    self.labelTitle.frame=CGRectMake(15, 0, self.width-50-15, self.height);
    [self addSubview:self.labelTitle];
}


- (void)initBtnCancel{
    self.btnCancel=[[UIButton alloc] initWithFrame:CGRectMake(self.width-50, 0, 50, self.height)];
    [self.btnCancel setImage:[self imageBundleName:@"bt_dialog_close"] forState:UIControlStateNormal];
    [self addSubview:self.btnCancel];
}


- (void)initLineView{
    self.lineView=[[BTLineView alloc] initWithFrame:CGRectMake(0, self.height-.5, self.width, 1)];
    self.lineView.color=[UIColor lightGrayColor];
    [self addSubview:self.lineView];
}

- (UIImage*)imageBundleName:(NSString*)name{
    NSBundle * bundle = [NSBundle bundleForClass:[self class]];
    UIImage * img = [UIImage imageNamed:[NSString stringWithFormat:@"BTDialogBundle.bundle/%@",name] inBundle:bundle compatibleWithTraitCollection:nil];
    return img;
}

@end


@implementation BTDialogModel



@end

