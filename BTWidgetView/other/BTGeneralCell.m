//
//  BTGeneralTableViewCell.m
//  BTWidgetViewExample
//
//  Created by apple on 2021/1/26.
//  Copyright © 2021 stone. All rights reserved.
//

#import "BTGeneralCell.h"
#import "UIView+BTViewTool.h"
#import "UIView+BTConstraint.h"
#import "UIFont+BTFont.h"
#import <BTHelp/UIColor+BTColor.h>

@interface BTGeneralCell()

@property (nonatomic, assign) BTGeneralCellStyle generalStyle;

@property (nonatomic, assign) BOOL isHadInit;

@end


@implementation BTGeneralCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




- (void)initWidget:(BTGeneralCellStyle)style{
    if (self.isHadInit) {
        return;
    }
    self.isHadInit = YES;
    self.generalStyle = style;
    switch (self.generalStyle) {
        case BTGeneralCellStyleFullText:
            [self initTitleIconImgView];
            [self initTitleLabel];
            [self initArrowImgView];
            [self initSubTitleLabel];
            break;
        case BTGeneralCellStyleFullSwitch:
            [self initTitleIconImgView];
            [self initTitleLabel];
            [self initSwitch];
            break;
        case BTGeneralCellStyleSimpleText:
            [self initTitleLabel];
            [self initArrowImgView];
            break;
        case BTGeneralCellStyleSimpleText2:
            [self initTitleLabel];
            [self initArrowImgView];
            [self initSubTitleLabel];
            break;
        case BTGeneralCellStyleSimpleText3:
            [self initTitleLabel];
            [self initSubTitleLabel];
            break;
        case BTGeneralCellStyleSimpleSwitch:
            [self initTitleLabel];
            [self initSwitch];
            break;
        case BTGeneralCellStyleJustTitle:
            [self initTitleLabel];
            break;
            
        default:
            break;
    }
    
}

- (void)initTitleIconImgView{
    self.titleIconImgView = [UIImageView new];
    self.titleIconImgView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.titleIconImgView];
    
    BTGeneralCellConfig * config = [BTGeneralCellConfig new];
    config.leftPadding = 20;
    if (self.titleIconImgViewBlock) {
        self.titleIconImgViewBlock(config);
    }
    [self.titleIconImgView bt_addLeftToParentWithPadding:config.leftPadding];
    [self.titleIconImgView bt_addCenterYToParent];
    if (config.rect.size.width != 0 && config.rect.size.height != 0) {
        [self.titleIconImgView bt_addWidth:config.rect.size.width];
        [self.titleIconImgView bt_addHeight:config.rect.size.height];
    }
}

- (void)initTitleLabel{
    self.titleLabel = [UILabel new];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.titleLabel];
    
    BTGeneralCellConfig * config = [BTGeneralCellConfig new];
    config.font = [UIFont BTAutoFontWithSize:16 weight:UIFontWeightMedium];
    config.textColor = [UIColor bt_RGBSame:51];
    if (self.titleLabelBlock) {
        self.titleLabelBlock(config);
    }
    self.titleLabel.font = config.font;
    self.titleLabel.textColor = config.textColor;
    if (self.generalStyle == BTGeneralCellStyleFullText || self.generalStyle == BTGeneralCellStyleFullSwitch) {
        [self.titleLabel bt_addLeftToItemView:self.titleIconImgView constant:config.leftPadding];
    }else{
        [self.titleLabel bt_addLeftToParentWithPadding:config.leftPadding];
    }
    
    [self.titleLabel bt_addCenterYToParent];
    
}

- (void)initSubTitleLabel{
    self.subTitleLabel = [UILabel new];
    self.subTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.subTitleLabel];
    
    BTGeneralCellConfig * config = [BTGeneralCellConfig new];
    config.font = [UIFont BTAutoFontWithSize:14 weight:UIFontWeightMedium];
    config.textColor = [UIColor bt_RGBSame:103];
    if (self.subTitleLabelBlock) {
        self.subTitleLabelBlock(config);
    }
    self.subTitleLabel.font = config.font;
    self.subTitleLabel.textColor = config.textColor;
    if (self.generalStyle == BTGeneralCellStyleSimpleText3) {
        [self.subTitleLabel bt_addRightToParentWithPadding:config.rightPadding];
    }else{
        [self.subTitleLabel bt_addRightToItemView:self.arrowImgView constant:config.rightPadding];
    }
    
    [self.subTitleLabel bt_addCenterYToParent];
}

- (void)initArrowImgView{
    self.arrowImgView = [UIImageView new];
    self.arrowImgView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.arrowImgView];
    
    BTGeneralCellConfig * config = [BTGeneralCellConfig new];
    config.rightPadding = -20;
    if (self.arrowImgViewBlock) {
        self.arrowImgViewBlock(config);
    }
    
    [self.arrowImgView bt_addRightToParentWithPadding:config.rightPadding];
    [self.arrowImgView bt_addCenterYToParent];
    if (config.rect.size.width != 0 && config.rect.size.height != 0) {
        [self.arrowImgView bt_addWidth:config.rect.size.width];
        [self.arrowImgView bt_addHeight:config.rect.size.height];
    }
    
}

- (void)initSwitch{
    self.contentSwitch = [UISwitch new];
    self.contentSwitch.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentSwitch.userInteractionEnabled = YES;
    [self.contentView addSubview:self.contentSwitch];
    
    BTGeneralCellConfig * config = [BTGeneralCellConfig new];
    config.rightPadding = -20;
    if (self.contentSwitchBlock) {
        self.contentSwitchBlock(config);
    }
    
    [self.contentSwitch bt_addRightToParentWithPadding:config.rightPadding];
    [self.contentSwitch bt_addCenterYToParent];
    
    self.switchBtn = [UIButton new];
    self.switchBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.switchBtn];
    [self.switchBtn bt_addEqualWidthToView:self.contentSwitch];
    [self.switchBtn bt_addEqualHeightToView:self.contentSwitch];
    [self.switchBtn bt_addCenterToItemView:self.contentSwitch];
}







@end

@implementation BTGeneralCellConfig



@end
