//
//  LabelTestViewController.m
//  BTWidgetViewExample
//
//  Created by apple on 2020/6/16.
//  Copyright © 2020 stone. All rights reserved.
//

#import "LabelTestViewController.h"
#import "UILabel+BTLabel.h"

@interface LabelTestViewController ()

@property (nonatomic, strong) UILabel * label;

@end

@implementation LabelTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.label = [[UILabel alloc] init];
    self.label.text = @"春天的花开秋天的风，以及冬天的落阳。忧郁的青春，年少的我，曾经无知的这么想";
    [self.label sizeToFit];
    [self.view addSubview:self.label];
    
    [self.label bt_AttributedColor:UIColor.redColor str:@"秋天的风"];
    [self.label bt_AttributedFont:[UIFont systemFontOfSize:22 weight:UIFontWeightBold] str:@"的落阳"];
    [self.label bt_AttributedUnderLine:UIColor.yellowColor str:@"春天的花开秋天的风"];
    [self.label bt_AttributedLink:[NSURL URLWithString:@"http://www.baidu.com"] str:@"冬天"];
}


@end
