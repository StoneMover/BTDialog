//
//  UIView+BTConstraint.m
//  BTDialogExample
//
//  Created by stonemover on 2019/4/13.
//  Copyright © 2019 stonemover. All rights reserved.
//  translatesAutoresizingMaskIntoConstraints 属性需要设置NO

#import "UIView+BTConstraint.h"

@implementation UIView (BTConstraint)

#pragma mark width

- (NSLayoutConstraint *)bt_addWidth:(CGFloat)c{
    return [self bt_addWidth:NSLayoutRelationEqual constant:c];
}

- (NSLayoutConstraint *)bt_addWidth:(NSLayoutRelation)relation constant:(CGFloat)c{
    BTBTConstraintModel * model = [[BTBTConstraintModel alloc] initWithView:self attribute:NSLayoutAttributeWidth relation:relation];
    BTBTConstraintModel * toItemModel = [[BTBTConstraintModel alloc] initWithToItemView:nil attribute:NSLayoutAttributeNotAnAttribute];
    return [self bt_addConstraint:model toItemModel:toItemModel multiplier:1 constant:c];
}

- (NSLayoutConstraint *)bt_addEqualWidthToView:(UIView*)toView{
    BTBTConstraintModel * model = [[BTBTConstraintModel alloc] initWithView:self attribute:NSLayoutAttributeWidth relation:NSLayoutRelationEqual];
    BTBTConstraintModel * toItemModel = [[BTBTConstraintModel alloc] initWithToItemView:toView attribute:NSLayoutAttributeWidth];
    return [self bt_addConstraint:model toItemModel:toItemModel multiplier:1 constant:0];
}

#pragma mark height

- (NSLayoutConstraint *)bt_addHeight:(CGFloat)c{
    return [self bt_addHeight:NSLayoutRelationEqual constant:c];
}

- (NSLayoutConstraint *)bt_addHeight:(NSLayoutRelation)relation constant:(CGFloat)c{
    BTBTConstraintModel * model = [[BTBTConstraintModel alloc] initWithView:self attribute:NSLayoutAttributeHeight relation:relation];
    BTBTConstraintModel * toItemModel = [[BTBTConstraintModel alloc] initWithToItemView:nil attribute:NSLayoutAttributeNotAnAttribute];
    return [self bt_addConstraint:model toItemModel:toItemModel multiplier:1 constant:c];
}

- (NSLayoutConstraint *)bt_addEqualHeightToView:(UIView*)toView{
    BTBTConstraintModel * model = [[BTBTConstraintModel alloc] initWithView:self attribute:NSLayoutAttributeHeight relation:NSLayoutRelationEqual];
    BTBTConstraintModel * toItemModel = [[BTBTConstraintModel alloc] initWithToItemView:toView attribute:NSLayoutAttributeHeight];
    return [self bt_addConstraint:model toItemModel:toItemModel multiplier:1 constant:0];
}

#pragma mark left

- (NSLayoutConstraint *)bt_addLeftToParent{
    return [self bt_addLeftToItemView:self.superview];
}

- (NSLayoutConstraint *)bt_addLeftToParentWithPadding:(CGFloat)padding{
    return [self bt_addLeftToItemView:self.superview constant:padding];
}

- (NSLayoutConstraint *)bt_addLeftToItemView:(UIView*)toItemView{
    return [self bt_addLeftToItemView:toItemView constant:0];
}

- (NSLayoutConstraint *)bt_addLeftToItemView:(UIView*)toItemView isSame:(BOOL)isSame
{
    return [self bt_addLeftToItemView:toItemView constant:0 isSame:isSame];
}

- (NSLayoutConstraint *)bt_addLeftToItemView:(UIView*)toItemView  constant:(CGFloat)c{
    if ([self superview]==toItemView||[toItemView superview]==self) {
        return [self bt_addLeftToItemView:toItemView constant:c isSame:YES];
    }else{
        return [self bt_addLeftToItemView:toItemView constant:c isSame:NO];
    }
    
}


- (NSLayoutConstraint *)bt_addLeftToItemView:(UIView*)toItemView
                    constant:(CGFloat)c
                      isSame:(BOOL)isSame
{
    BTBTConstraintModel * model = [[BTBTConstraintModel alloc] initWithView:self attribute:NSLayoutAttributeLeading relation:NSLayoutRelationEqual];
    BTBTConstraintModel * toItemModel = [[BTBTConstraintModel alloc] initWithToItemView:toItemView attribute:isSame?NSLayoutAttributeLeading:NSLayoutAttributeTrailing];
    return [self bt_addConstraint:model toItemModel:toItemModel multiplier:1 constant:c];
    
}





#pragma mark right

- (NSLayoutConstraint *)bt_addRightToParent{
    return [self bt_addRightToItemView:self.superview];
}

- (NSLayoutConstraint *)bt_addRightToParentWithPadding:(CGFloat)padding{
    return [self bt_addRightToItemView:self.superview constant:padding];
}

- (NSLayoutConstraint *)bt_addRightToItemView:(UIView*)toItemView{
    return [self bt_addRightToItemView:toItemView constant:0];
}

- (NSLayoutConstraint *)bt_addRightToItemView:(UIView*)toItemView isSame:(BOOL)isSame
{
    return [self bt_addRightToItemView:toItemView constant:0 isSame:isSame];
}

- (NSLayoutConstraint *)bt_addRightToItemView:(UIView*)toItemView constant:(CGFloat)c{
    if ([self superview]==toItemView||[toItemView superview]==self) {
        return [self bt_addRightToItemView:toItemView constant:c isSame:YES];
    }else{
        return [self bt_addRightToItemView:toItemView constant:c isSame:NO];
    }
    
}


- (NSLayoutConstraint *)bt_addRightToItemView:(UIView*)toItemView constant:(CGFloat)c isSame:(BOOL)isSame
{
    
    BTBTConstraintModel * model = [[BTBTConstraintModel alloc] initWithView:self attribute:NSLayoutAttributeTrailing relation:NSLayoutRelationEqual];
    BTBTConstraintModel * toItemModel = [[BTBTConstraintModel alloc] initWithToItemView:toItemView attribute:isSame?NSLayoutAttributeTrailing:NSLayoutAttributeLeading];
    return [self bt_addConstraint:model toItemModel:toItemModel multiplier:1 constant:c];
}
#pragma mark top

- (NSLayoutConstraint *)bt_addTopToParent{
    return [self bt_addTopToItemView:self.superview];
}

- (NSLayoutConstraint *)bt_addTopToParentWithPadding:(CGFloat)padding{
    return [self bt_addTopToItemView:self.superview constant:padding];
}

- (NSLayoutConstraint *)bt_addTopToItemView:(UIView*)toItemView{
    return [self bt_addTopToItemView:toItemView constant:0];
}

- (NSLayoutConstraint *)bt_addTopToItemView:(UIView*)toItemView isSame:(BOOL)isSame
{
    return [self bt_addTopToItemView:toItemView constant:0 isSame:isSame];
}

- (NSLayoutConstraint *)bt_addTopToItemView:(UIView*)toItemView constant:(CGFloat)c{
    if ([self superview]==toItemView||[toItemView superview]==self) {
        return [self bt_addTopToItemView:toItemView constant:c isSame:YES];
    }else{
        return [self bt_addTopToItemView:toItemView constant:c isSame:NO];
    }
    
}


- (NSLayoutConstraint *)bt_addTopToItemView:(UIView*)toItemView constant:(CGFloat)c isSame:(BOOL)isSame
{
    BTBTConstraintModel * model = [[BTBTConstraintModel alloc] initWithView:self attribute:NSLayoutAttributeTop relation:NSLayoutRelationEqual];
    BTBTConstraintModel * toItemModel = [[BTBTConstraintModel alloc] initWithToItemView:toItemView attribute:isSame?NSLayoutAttributeTop:NSLayoutAttributeBottom];
    return [self bt_addConstraint:model toItemModel:toItemModel multiplier:1 constant:c];
    
}


#pragma mark bottom

- (NSLayoutConstraint *)bt_addBottomToParent{
    return [self bt_addBottomToItemView:self.superview];
}

- (NSLayoutConstraint *)bt_addBottomToParentWithPadding:(CGFloat)padding{
    return [self bt_addBottomToItemView:self.superview constant:padding];
}

- (NSLayoutConstraint *)bt_addBottomToItemView:(UIView*)toItemView{
    return [self bt_addBottomToItemView:toItemView constant:0];
}

- (NSLayoutConstraint *)bt_addBottomToItemView:(UIView*)toItemView isSame:(BOOL)isSame
{
    return [self bt_addBottomToItemView:toItemView constant:0 isSame:isSame];
}

- (NSLayoutConstraint *)bt_addBottomToItemView:(UIView*)toItemView constant:(CGFloat)c{
    if ([self superview]==toItemView||[toItemView superview]==self) {
        return [self bt_addBottomToItemView:toItemView constant:c isSame:YES];
    }else{
        return [self bt_addBottomToItemView:toItemView constant:c isSame:NO];
    }
    
}


- (NSLayoutConstraint *)bt_addBottomToItemView:(UIView*)toItemView constant:(CGFloat)c isSame:(BOOL)isSame
{
    BTBTConstraintModel * model = [[BTBTConstraintModel alloc] initWithView:self attribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual];
    BTBTConstraintModel * toItemModel = [[BTBTConstraintModel alloc] initWithToItemView:toItemView attribute:isSame?NSLayoutAttributeBottom:NSLayoutAttributeTop];
    return [self bt_addConstraint:model toItemModel:toItemModel multiplier:1 constant:c];
}

#pragma mark center

- (NSLayoutConstraint *)bt_addCenterXToParent{
    return [self bt_addCenterXToItemView:self.superview];
}

- (NSLayoutConstraint *)bt_addCenterXToItemView:(UIView*)toItemView{
    return [self bt_addCenterXToItemView:toItemView constant:0];
}

- (NSLayoutConstraint *)bt_addCenterXToItemView:(UIView*)toItemView  constant:(CGFloat)c{
    
    BTBTConstraintModel * model = [[BTBTConstraintModel alloc] initWithView:self attribute:NSLayoutAttributeCenterX relation:NSLayoutRelationEqual];
    BTBTConstraintModel * toItemModel = [[BTBTConstraintModel alloc] initWithToItemView:toItemView attribute:NSLayoutAttributeCenterX];
    return [self bt_addConstraint:model toItemModel:toItemModel multiplier:1 constant:c];
}


- (NSLayoutConstraint *)bt_addCenterYToParent{
    return [self bt_addCenterYToItemView:self.superview];
}

- (NSLayoutConstraint *)bt_addCenterYToItemView:(UIView*)toItemView{
    return [self bt_addCenterYToItemView:toItemView constant:0];
}

- (NSLayoutConstraint *)bt_addCenterYToItemView:(UIView*)toItemView  constant:(CGFloat)c{
    BTBTConstraintModel * model = [[BTBTConstraintModel alloc] initWithView:self attribute:NSLayoutAttributeCenterY relation:NSLayoutRelationEqual];
    BTBTConstraintModel * toItemModel = [[BTBTConstraintModel alloc] initWithToItemView:toItemView attribute:NSLayoutAttributeCenterY];
    return [self bt_addConstraint:model toItemModel:toItemModel multiplier:1 constant:c];
}


- (NSArray<NSLayoutConstraint*> *)bt_addCenterToParent{
    return [self bt_addCenterToItemView:self.superview];
}

- (NSArray<NSLayoutConstraint*> *)bt_addCenterToItemView:(UIView*)toItemView{
    NSArray<NSLayoutConstraint*> * array = [NSArray arrayWithObjects:[self bt_addCenterXToItemView:toItemView],[self bt_addCenterYToItemView:toItemView], nil];
    return array;
}

- (NSArray<NSLayoutConstraint*> *)bt_addToParentWithPadding:(BTPadding)padding{
    NSArray<NSLayoutConstraint*> * array = [NSArray arrayWithObjects:
                                            [self bt_addTopToItemView:self.superview constant:padding.top],
                                            [self bt_addBottomToItemView:self.superview constant:padding.bottom],
                                            [self bt_addLeftToItemView:self.superview constant:padding.left],
                                            [self bt_addRightToItemView:self.superview constant:padding.right],
                                            
                                            nil];
    return array;
}

- (NSLayoutConstraint *)bt_addConstraint:(BTBTConstraintModel*)model
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
    BOOL isHadRemoveConstraint = NO;
    if (model.view.superview != nil && model.view.superview == toItemModel.view) {
        isHadRemoveConstraint = [self autoRemoveConstraint:constraint inView:toItemModel.view];
        [toItemModel.view addConstraint:constraint];
    }else if (toItemModel.view.superview != nil && toItemModel.view.superview == model.view){
        isHadRemoveConstraint = [self autoRemoveConstraint:constraint inView:model.view];
        [model.view addConstraint:constraint];
    }else if (model.view.superview != nil && model.view.superview == toItemModel.view.superview){
        isHadRemoveConstraint = [self autoRemoveConstraint:constraint inView:model.view.superview];
        [model.view.superview addConstraint:constraint];
    }else{
        isHadRemoveConstraint = [self autoRemoveConstraint:constraint inView:self];
        [self addConstraint:constraint];
    }
    return constraint;
}

- (NSLayoutConstraint *)bt_addConstraint:(BTBTConstraintModel*)model
             toItemModel:(BTBTConstraintModel*)toItemModel{
    return [self bt_addConstraint:model toItemModel:toItemModel multiplier:1 constant:0];
}

- (NSLayoutConstraint *)bt_addConstraint:(BTBTConstraintModel*)model
             toItemModel:(BTBTConstraintModel*)toItemModel
                constant:(CGFloat)c{
    return [self bt_addConstraint:model toItemModel:toItemModel multiplier:1 constant:c];
}

- (BOOL)autoRemoveConstraint:(NSLayoutConstraint *)createConstraint inView:(UIView*)inView{
    for (NSLayoutConstraint * c in inView.constraints) {
        if (c.firstItem == createConstraint.firstItem && c.firstAttribute == createConstraint.firstAttribute) {
            [inView removeConstraint:c];
            return YES;
        }
    }
    
    return NO;
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
