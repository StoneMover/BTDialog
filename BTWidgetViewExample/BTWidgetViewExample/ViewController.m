//
//  ViewController.m
//  BTWidgetViewExample
//
//  Created by zanyu on 2019/8/16.
//  Copyright © 2019 stone. All rights reserved.
//

#import "ViewController.h"
#import "PageViewTestViewController.h"
#import "PageVcTestViewController.h"
#import "HomeTableViewCell.h"
#import "DialogTestViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray * titles;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent=NO;
    self.title=@"BTWidget";
    self.titles=@[@"BTPageViewTest",@"BTPageVcTest",@"BTDialogView&BTAlertView"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeTableViewCellId"];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
}

#pragma mark tableView data delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCellId"];
    cell.labelTitle.text=self.titles[indexPath.row];
    return cell;
}


#pragma mark tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            PageViewTestViewController * vc=[PageViewTestViewController new];
            vc.title=self.titles[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            PageVcTestViewController * vc=[PageVcTestViewController new];
            vc.title=self.titles[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            DialogTestViewController * vc=[DialogTestViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

@end
