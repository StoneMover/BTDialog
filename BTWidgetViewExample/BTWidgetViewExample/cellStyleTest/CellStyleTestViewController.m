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
            cell.generalView.titleIconImgViewBlock = ^(BTGeneralCellConfig * _Nonnull config) {
                config.rect = CGRectMake(0, 0, 25, 25);
            };
            cell.generalView.titleLabelBlock = ^(BTGeneralCellConfig * _Nonnull config) {
                config.leftPadding = 10;
            };
            cell.generalView.subTitleLabelBlock = ^(BTGeneralCellConfig * _Nonnull config) {
                config.rightPadding = -10;
            };
            [cell.generalView initWidget:BTGeneralCellStyleFullText];
            cell.generalView.titleIconImgView.image = [UIImage bt_imageWithColor:UIColor.redColor size:CGSizeMake(25, 25)];
            cell.generalView.titleLabel.text = @"FullText";
            cell.generalView.subTitleLabel.text = @"你只用这样配置";
            cell.generalView.arrowImgView.image = [UIImage imageNamed:@"arrow"];
        }
            break;
        case 1:
        {
            cell.generalView.titleIconImgViewBlock = ^(BTGeneralCellConfig * _Nonnull config) {
                config.rect = CGRectMake(0, 0, 25, 25);
            };
            cell.generalView.titleLabelBlock = ^(BTGeneralCellConfig * _Nonnull config) {
                config.leftPadding = 10;
            };
            [cell.generalView initWidget:BTGeneralCellStyleFullSwitch];
            cell.generalView.titleIconImgView.image = [UIImage bt_imageWithColor:UIColor.redColor size:CGSizeMake(25, 25)];
            cell.generalView.titleLabel.text = @"FullSwitch";
        }
            break;
        case 2:
        {
            cell.generalView.titleLabelBlock = ^(BTGeneralCellConfig * _Nonnull config) {
                config.leftPadding = 20;
                config.textColor = UIColor.redColor;
            };
            [cell.generalView initWidget:BTGeneralCellStyleSimpleText];
            cell.generalView.titleLabel.text = @"SimpleText";
            cell.generalView.arrowImgView.image = [UIImage imageNamed:@"arrow"];
        }
            break;
        case 3:
        {
            cell.generalView.titleLabelBlock = ^(BTGeneralCellConfig * _Nonnull config) {
                config.leftPadding = 20;
            };
            
            cell.generalView.subTitleLabelBlock = ^(BTGeneralCellConfig * _Nonnull config) {
                config.rightPadding = -10;
                config.textColor = UIColor.redColor;
            };
            
            [cell.generalView initWidget:BTGeneralCellStyleSimpleText2];
            cell.generalView.titleLabel.text = @"SimpleText2";
            cell.generalView.subTitleLabel.text = @"还不错吧";
            cell.generalView.arrowImgView.image = [UIImage imageNamed:@"arrow"];
        }
            break;
        case 4:
        {
            cell.generalView.titleLabelBlock = ^(BTGeneralCellConfig * _Nonnull config) {
                config.leftPadding = 20;
            };
            [cell.generalView initWidget:BTGeneralCellStyleSimpleSwitch];
            cell.generalView.titleLabel.text = @"SimpleSwitch";
        }
            break;
        case 5:
        {
            cell.generalView.titleLabelBlock = ^(BTGeneralCellConfig * _Nonnull config) {
                config.leftPadding = 20;
            };
            [cell.generalView initWidget:BTGeneralCellStyleJustTitle];
            cell.generalView.titleLabel.text = @"JustTitle";
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
