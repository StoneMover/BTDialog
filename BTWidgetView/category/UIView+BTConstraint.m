//
//  UIView+BTConstraint.m
//  BTDialogExample
//
//  Created by stonemover on 2019/4/13.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "UIView+BTConstraint.h"

@implementation UIView (BTConstraint)

#pragma mark width

- (void)bt_addWidth:(CGFloat)c{
    [self bt_addWidth:NSLayoutRelationEqual constant:c];
}

- (void)bt_addWidth:(NSLayoutRelation)relation constant:(CGFloat)c{
    BTBTConstraintModel * model = [[BTBTConstraintModel alloc] initWithView:self attribute:NSLayoutAttributeWidth relation:relation];
    BTBTConstraintModel * toItemModel = [[BTBTConstraintModel alloc] initWithToItemView:nil attribute:NSLayoutAttributeNotAnAttribute];
    [self bt_addConstraint:model toItemModel:toItemModel multiplier:1 constant:c];
}

#pragma mark height

- (void)bt_addHeight:(CGFloat)c{
    [self bt_addHeight:NSLayoutRelationEqual constant:c];
}

- (void)bt_addHeight:(NSLayoutRelation)relation constant:(CGFloat)c{
    BTBTConstraintModel * model = [[BTBTConstraintModel alloc] initWithView:self attribute:NSLayoutAttributeHeight relation:relation];
    BTBTConstraintModel * toItemModel = [[BTBTConstraintModel alloc] initWithToItemView:nil attribute:NSLayoutAttributeNotAnAttribute];
    [self bt_addConstraint:model toItemModel:toItemModel multiplier:1 constant:c];
}

#pragma mark left

- (void)bt_addLeftToParent{
    [self bt_addLeftToItemView:self.superview];
}

- (void)bt_addLeftToItemView:(UIView*)toItemView{
    [self bt_addLeftToItemView:toItemView constant:0];
}

- (void)bt_addLeftToItemView:(UIView*)toItemView isSame:(BOOL)isSame
{
    [self bt_addLeftToItemView:toItemView constant:0 isSame:isSame];
}

- (void)bt_addLeftToItemView:(UIView*)toItemView  constant:(CGFloat)c{
    if ([self superview]==toItemView||[toItemView superview]==self) {
        [self bt_addLeftToItemView:toItemView constant:c isSame:YES];
    }else{
        [self bt_addLeftToItemView:toItemView constant:c isSame:NO];
    }
    
}


- (void)bt_addLeftToItemView:(UIView*)toItemView
                    constant:(CGFloat)c
                      isSame:(BOOL)isSame
{
    BTBTConstraintModel * model = [[BTBTConstraintModel alloc] initWithView:self attribute:NSLayoutAttributeLeading relation:NSLayoutRelationEqual];
    BTBTConstraintModel * toItemModel = [[BTBTConstraintModel alloc] initWithToItemView:toItemView attribute:isSame?NSLayoutAttributeLeading:NSLayoutAttributeTrailing];
    [self bt_addConstraint:model toItemModel:toItemModel multiplier:1 constant:c];
    
}





#pragma mark right

- (void)bt_addRightToParent{
    [self bt_addRightToItemView:self.superview];
}

- (void)bt_addRightToItemView:(UIView*)toItemView{
    [self bt_addRightToItemView:toItemView constant:0];
}

- (void)bt_addRightToItemView:(UIView*)toItemView isSame:(BOOL)isSame
{
    [self bt_addRightToItemView:toItemView constant:0 isSame:isSame];
}

- (void)bt_addRightToItemView:(UIView*)toItemView constant:(CGFloat)c{
    if ([self superview]==toItemView||[toItemView superview]==self) {
        [self bt_addRightToItemView:toItemView constant:c isSame:YES];
    }else{
        [self bt_addRightToItemView:toItemView constant:c isSame:NO];
    }
    
}


- (void)bt_addRightToItemView:(UIView*)toItemView constant:(CGFloat)c isSame:(BOOL)isSame
{
    
    BTBTConstraintModel * model = [[BTBTConstraintModel alloc] initWithView:self attribute:NSLayoutAttributeTrailing relation:NSLayoutRelationEqual];
    BTBTConstraintModel * toItemModel = [[BTBTConstraintModel alloc] initWithToItemView:toItemView attribute:isSame?NSLayoutAttributeTrailing:NSLayoutAttributeLeading];
    [self bt_addConstraint:model toItemModel:toItemModel multiplier:1 constant:c];
}
#pragma mark top

- (void)bt_addTopToParent{
    [self bt_addTopToItemView:self.superview];
}

- (void)bt_addTopToItemView:(UIView*)toItemView{
    [self bt_addTopToItemView:toItemView constant:0];
}

- (void)bt_addTopToItemView:(UIView*)toItemView isSame:(BOOL)isSame
{
    [self bt_addTopToItemView:toItemView constant:0 isSame:isSame];
}

- (void)bt_addTopToItemView:(UIView*)toItemView constant:(CGFloat)c{
    if ([self superview]==toItemView||[toItemView superview]==self) {
        [self bt_addTopToItemView:toItemView constant:c isSame:YES];
    }else{
        [self bt_addTopToItemView:toItemView constant:c isSame:NO];
    }
    
}


- (void)bt_addTopToItemView:(UIView*)toItemView constant:(CGFloat)c isSame:(BOOL)isSame
{
    BTBTConstraintModel * model = [[BTBTConstraintModel alloc] initWithView:self attribute:NSLayoutAttributeTop relation:NSLayoutRelationEqual];
    BTBTConstraintModel * toItemModel = [[BTBTConstraintModel alloc] initWithToItemView:toItemView attribute:isSame?NSLayoutAttributeTop:NSLayoutAttributeBottom];
    [self bt_addConstraint:model toItemModel:toItemModel multiplier:1 constant:c];
    
}


#pragma mark bottom

- (void)bt_addBottomToParent{
    [self bt_addBottomToItemView:self.superview];
}

- (void)bt_addBottomToItemView:(UIView*)toItemView{
    [self bt_addBottomToItemView:toItemView constant:0];
}

- (void)bt_addBottomToItemView:(UIView*)toItemView isSame:(BOOL)isSame
{
    [self bt_addBottomToItemView:toItemView constant:0 isSame:isSame];
}

- (void)bt_addBottomToItemView:(UIView*)toItemView constant:(CGFloat)c{
    if ([self superview]==toItemView||[toItemView superview]==self) {
        [self bt_addBottomToItemView:toItemView constant:c isSame:YES];
    }else{
        [self bt_addBottomToItemView:toItemView constant:c isSame:NO];
    }
    
}


- (void)bt_addBottomToItemView:(UIView*)toItemView constant:(CGFloat)c isSame:(BOOL)isSame
{
    BTBTConstraintModel * model = [[BTBTConstraintModel alloc] initWithView:self attribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual];
    BTBTConstraintModel * toItemModel = [[BTBTConstraintModel alloc] initWithToItemView:toItemView attribute:isSame?NSLayoutAttributeBottom:NSLayoutAttributeTop];
    [self bt_addConstraint:model toItemModel:toItemModel multiplier:1 constant:c];
}

#pragma mark center

- (void)bt_addCenterXToParent{
    [self bt_addCenterXToItemView:self.superview];
}

- (void)bt_addCenterXToItemView:(UIView*)toItemView{
    [self bt_addCenterXToItemView:toItemView constant:0];
}

- (void)bt_addCenterXToItemView:(UIView*)toItemView  constant:(CGFloat)c{
    
    BTBTConstraintModel * model = [[BTBTConstraintModel alloc] initWithView:self attribute:NSLayoutAttributeCenterX relation:NSLayoutRelationEqual];
    BTBTConstraintModel * toItemModel = [[BTBTConstraintModel alloc] initWithToItemView:toItemView attribute:NSLayoutAttributeCenterX];
    [self bt_addConstraint:model toItemModel:toItemModel multiplier:1 constant:c];
}


- (void)bt_addCenterYToParent{
    [self bt_addCenterYToItemView:self.superview];
}

- (void)bt_addCenterYToItemView:(UIView*)toItemView{
    [self bt_addCenterYToItemView:toItemView constant:0];
}

- (void)bt_addCenterYToItemView:(UIView*)toItemView  constant:(CGFloat)c{
    BTBTConstraintModel * model = [[BTBTConstraintModel alloc] initWithView:self attribute:NSLayoutAttributeCenterY relation:NSLayoutRelationEqual];
    BTBTConstraintModel * toItemModel = [[BTBTConstraintModel alloc] initWithToItemView:toItemView attribute:NSLayoutAttributeCenterY];
    [self bt_addConstraint:model toItemModel:toItemModel multiplier:1 constant:c];
}


- (void)bt_addCenterToParent:(UIView*)toItemView{
    [self bt_addCenterToItemView:self.superview];
}

- (void)bt_addCenterToItemView:(UIView*)toItemView{
    [self bt_addCenterXToItemView:toItemView];
    [self bt_addCenterYToItemView:toItemView];
}

- (void)bt_addConstraint:(BTBTConstraintModel*)model
             toItemModel:(BTBTConstraintModel*)toItemModel
              multiplier:(CGFloat)multiplier
                constant:(CGFloat)c{
    NSLayoutConstraint * constraint=[NSLayoutConstraint constraintWithItem:model.view
                                                                 attribute:model.attribute
                                                                 relatedBy:model.relation
                                                                    toItem:toItemModel.view
                                                                 attribute:toItemModel.attribute
                                                                multiplier:multiplier
                                                                  constant:c];
    //增加空判断，去除两个果两个都为nil的情况
    if (model.view.superview != nil && model.view.superview == toItemModel.view) {
        [toItemModel.view addConstraint:constraint];
    }else if (toItemModel.view.superview != nil && toItemModel.view.superview == model.view){
        [model.view addConstraint:constraint];
    }else if (model.view.superview != nil && model.view.superview == toItemModel.view.superview){
        [model.view.superview addConstraint:constraint];
    }else{
        [self addConstraint:constraint];
    }
    
}

- (void)bt_addConstraint:(BTBTConstraintModel*)model
             toItemModel:(BTBTConstraintModel*)toItemModel{
    [self bt_addConstraint:model toItemModel:toItemModel multiplier:1 constant:0];
}

- (void)bt_addConstraint:(BTBTConstraintModel*)model
             toItemModel:(BTBTConstraintModel*)toItemModel
                constant:(CGFloat)c{
    [self bt_addConstraint:model toItemModel:toItemModel multiplier:1 constant:c];
}


@end



@implementation BTBTConstraintModel

- (instancetype)initWithView:(UIView*)view attribute:(NSLayoutAttribute)attribute relation:(NSLayoutRelation)relation{
    self = [super init];
    self.view = view;
    self.attribute = attribute;
    self.relation = relation;
    return self;
}

- (instancetype)initWithToItemView:(nullable UIView*)view attribute:(NSLayoutAttribute)attribute{
    self = [super init];
    self.view = view;
    self.attribute = attribute;
    return self;
}

@end
