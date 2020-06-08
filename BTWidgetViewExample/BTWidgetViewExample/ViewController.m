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
#import "DataModel.h"
#import "SearchTestViewController.h"
#import "SlideTestViewController.h"
#import "InputTestViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray * titles;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent=NO;
    self.title=@"BTWidget";
    self.titles=@[@"BTPageViewTest",@"BTPageVcTest",@"BTDialogView&BTAlertView",@"BTSearchTest",@"SlideTestViewController",@"BTInputView"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeTableViewCellId"];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self test:@"when i get old " str:@"you when will i get old and"];
}

- (void)test:(NSString*)strOri str:(NSString*)changeStr{
    if ([strOri isEqualToString:changeStr]) {
        NSLog(@"没有不同");
        return;
    }
    
    NSMutableArray * array = [NSMutableArray new];
    
    for (NSInteger startIndex = 0; startIndex<strOri.length; startIndex) {
        NSInteger len = 1;
        NSString * headStr = [strOri substringWithRange:NSMakeRange(startIndex, len)];
        BOOL isHad = NO;
        while ([changeStr containsString:headStr]&&len<strOri.length-startIndex) {
            isHad = YES;
            len++;
            headStr = [strOri substringWithRange:NSMakeRange(startIndex, len)];
        }
        if (isHad) {
            NSString * resultStr = nil;
            if (startIndex + len == strOri.length && [changeStr containsString:headStr]) {
                resultStr = headStr;
                startIndex = startIndex + len;
            }else{
                resultStr = [strOri substringWithRange:NSMakeRange(startIndex, len-1)];
                startIndex = startIndex + len-1;
            }
            
            NSRange range = [changeStr rangeOfString:resultStr];
            NSLog(@"开始位置:%ld, 长度:%ld,相同字符串:%@",range.location,range.length,resultStr);
            
           
            DataModel * model = [DataModel new];
            model.start = range.location;
            model.end = range.location + range.length;
            model.lenth = range.length;
            model.str = resultStr;
            
            NSMutableArray * dataRemove = [NSMutableArray new];
            for (DataModel * m in array) {
                if (m.start>= model.start&&m.end <= model.end) {
                    [dataRemove addObject:m];
                }
            }
            if (dataRemove.count != 0) {
                [array removeObjectsInArray:dataRemove];
            }
            
            [array addObject:model];
            if ([resultStr isEqualToString:changeStr]) {
                break;
            }
        }else{
            startIndex++;
        }
    }
    
    
    NSLog(@"----------------------------------去重复后相同字符串----------------------------------------------");
    
    NSMutableArray * dataResult = [NSMutableArray new];
    NSInteger startIndex = 0;
    for (DataModel * m in array) {
        NSLog(@"开始位置:%ld, 长度:%ld,结束位置:%ld,相同字符串:%@",m.start,m.lenth,m.end,m.str);
        DataModel * model = [DataModel new];
        if (array.firstObject == m && m.start!= 0) {
            model.start = 0;
            model.lenth = m.start;
            [dataResult addObject:model];
            if (array.lastObject != m) {
                NSInteger index = [array indexOfObject:m];
                DataModel * nextModel = [array objectAtIndex:index+1];
                DataModel * anotherModel = [DataModel new];
                anotherModel.start = m.end;
                anotherModel.lenth = nextModel.start - m.end;
                [dataResult addObject:anotherModel];
            }
        }else if(array.lastObject == m){
            if (m.end != changeStr.length) {
                model.start = m.end;
                model.lenth = changeStr.length - model.start;
                [dataResult addObject:model];
            }
        }else{
            model.start = m.end;
            NSInteger index = [array indexOfObject:m];
            DataModel * nextModel = [array objectAtIndex:index+1];
            model.lenth = nextModel.start - m.end;
            if (model.lenth>0) {
                [dataResult addObject:model];
            }
            
        }
        
    }
    
    NSLog(@"--------------------------------不同字符串------------------------------------------------");
    for (DataModel * m in dataResult) {
        NSLog(@"开始位置:%ld, 长度:%ld,结束位置:%ld,不同字符串:%@",m.start,m.lenth,m.end,[changeStr substringWithRange:NSMakeRange(m.start, m.lenth)]);
    }
    
    
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
        case 3:
        {
            SearchTestViewController * vc=[SearchTestViewController new];
            vc.title = self.titles[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            SlideTestViewController * vc=[SlideTestViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
            InputTestViewController * vc=[InputTestViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

@end
