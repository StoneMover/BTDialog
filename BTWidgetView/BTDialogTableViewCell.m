//
//  SMListDialogTableViewCell.m
//  Base
//
//  Created by whbt_mac on 16/1/5.
//  Copyright © 2016年 StoneMover. All rights reserved.
//

#import "BTDialogTableViewCell.h"
#import "UIView+BTConstraint.h"

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
    self.labelContent.font=[UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    self.labelContent.textColor=[UIColor blackColor];
    self.labelContent.numberOfLines=0;
    [self addSubview:self.labelContent];
    [self addConstraintLeft:self.labelContent toItemView:self constant:20];
    [self addConstraintTop:self.labelContent toItemView:self];
    [self addConstraintBottom:self.labelContent toItemView:self];
    [self addConstraintRight:self.labelContent toItemView:self.imgViewSelect constant:-10];
}

- (void)initImgSel{
    self.imgViewSelect=[[UIImageView alloc] init];
    self.imgViewSelect.contentMode=UIViewContentModeCenter;
    self.imgViewSelect.translatesAutoresizingMaskIntoConstraints=NO;
    self.imgViewSelect.image=[self imageBundleName:@"bt_dialog_select"];
    [self addSubview:self.imgViewSelect];
    
    [self addConstraintRight:self.imgViewSelect toItemView:self];
    [self addConstraintTop:self.imgViewSelect toItemView:self];
    [self addConstraintBottom:self.imgViewSelect toItemView:self];
    [self.imgViewSelect addConstraintWidth:50];
}

- (UIImage*)imageBundleName:(NSString*)name{
    NSBundle * bundle = [NSBundle bundleForClass:[self class]];
    UIImage * img = [UIImage imageNamed:[NSString stringWithFormat:@"BTDialogBundle.bundle/%@",name] inBundle:bundle compatibleWithTraitCollection:nil];
    return img;
}


@end
