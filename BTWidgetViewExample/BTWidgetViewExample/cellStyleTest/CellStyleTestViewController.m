//
//  CellStyleTestViewController.m
//  BTWidgetViewExample
//
//  Created by apple on 2021/1/28.
//  Copyright © 2021 stone. All rights reserved.
//

#import "CellStyleTestViewController.h"
#import "BTGeneralCell.h"
#import <BTHelp/UIColor+BTColor.h>
#import <BTHelp/UIImage+BTImage.h>

@interface CellStyleTestViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CellStyleTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"BTGeneralCell";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[BTGeneralCell class] forCellReuseIdentifier:@"BTGeneralCell"];
}

#pragma mark tableView data delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BTGeneralCell * cell=[tableView dequeueReusableCellWithIdentifier:@"BTGeneralCell"];
    switch (indexPath.row) {
        case 0:
        {
            cell.titleIconImgViewBlock = ^(BTGeneralCellConfig * _Nonnull config) {
                config.rect = CGRectMake(0, 0, 25, 25);
            };
            cell.titleLabelBlock = ^(BTGeneralCellConfig * _Nonnull config) {
                config.leftPadding = 10;
            };
            cell.subTitleLabelBlock = ^(BTGeneralCellConfig * _Nonnull config) {
                config.rightPadding = -10;
            };
            [cell initWidget:BTGeneralCellStyleFullText];
            cell.titleIconImgView.image = [UIImage bt_imageWithColor:UIColor.redColor size:CGSizeMake(25, 25)];
            cell.titleLabel.text = @"FullText";
            cell.subTitleLabel.text = @"你只用这样配置";
            cell.arrowImgView.image = [UIImage imageNamed:@"arrow"];
        }
            break;
        case 1:
        {
            cell.titleIconImgViewBlock = ^(BTGeneralCellConfig * _Nonnull config) {
                config.rect = CGRectMake(0, 0, 25, 25);
            };
            cell.titleLabelBlock = ^(BTGeneralCellConfig * _Nonnull config) {
                config.leftPadding = 10;
            };
            [cell initWidget:BTGeneralCellStyleFullSwitch];
            cell.titleIconImgView.image = [UIImage bt_imageWithColor:UIColor.redColor size:CGSizeMake(25, 25)];
            cell.titleLabel.text = @"FullSwitch";
        }
            break;
        case 2:
        {
            cell.titleLabelBlock = ^(BTGeneralCellConfig * _Nonnull config) {
                config.leftPadding = 20;
                config.textColor = UIColor.redColor;
            };
            [cell initWidget:BTGeneralCellStyleSimpleText];
            cell.titleLabel.text = @"SimpleText";
            cell.arrowImgView.image = [UIImage imageNamed:@"arrow"];
        }
            break;
        case 3:
        {
            cell.titleLabelBlock = ^(BTGeneralCellConfig * _Nonnull config) {
                config.leftPadding = 20;
            };
            
            cell.subTitleLabelBlock = ^(BTGeneralCellConfig * _Nonnull config) {
                config.rightPadding = -10;
                config.textColor = UIColor.redColor;
            };
            
            [cell initWidget:BTGeneralCellStyleSimpleText2];
            cell.titleLabel.text = @"SimpleText2";
            cell.subTitleLabel.text = @"还不错吧";
            cell.arrowImgView.image = [UIImage imageNamed:@"arrow"];
        }
            break;
        case 4:
        {
            cell.titleLabelBlock = ^(BTGeneralCellConfig * _Nonnull config) {
                config.leftPadding = 20;
            };
            [cell initWidget:BTGeneralCellStyleSimpleSwitch];
            cell.titleLabel.text = @"SimpleSwitch";
        }
            break;
        case 5:
        {
            cell.titleLabelBlock = ^(BTGeneralCellConfig * _Nonnull config) {
                config.leftPadding = 20;
            };
            [cell initWidget:BTGeneralCellStyleJustTitle];
            cell.titleLabel.text = @"JustTitle";
        }
            break;
            
        default:
            break;
    }
    return cell;
}


#pragma mark tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45;
}


@end
