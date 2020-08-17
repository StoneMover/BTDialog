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

- (void)bt_addConstraintWidth:(CGFloat)c{
    [self bt_addConstraintWidth:NSLayoutRelationEqual constant:c];
}

- (void)bt_addConstraintWidth:(NSLayoutRelation)relation constant:(CGFloat)c{
    BTBTConstraintModel * model = [[BTBTConstraintModel alloc] initWithView:self attribute:NSLayoutAttributeWidth relation:relation];
    BTBTConstraintModel * toItemModel = [[BTBTConstraintModel alloc] initWithToItemView:nil attribute:NSLayoutAttributeNotAnAttribute];
    [self bt_addConstraint:model toItemModel:toItemModel multiplier:1 constant:c];
}

#pragma mark height

- (void)bt_addConstraintHeight:(CGFloat)c{
    [self bt_addConstraintHeight:NSLayoutRelationEqual constant:c];
}

- (void)bt_addConstraintHeight:(NSLayoutRelation)relation constant:(CGFloat)c{
    BTBTConstraintModel * model = [[BTBTConstraintModel alloc] initWithView:self attribute:NSLayoutAttributeHeight relation:relation];
    BTBTConstraintModel * toItemModel = [[BTBTConstraintModel alloc] initWithToItemView:nil attribute:NSLayoutAttributeNotAnAttribute];
    [self bt_addConstraint:model toItemModel:toItemModel multiplier:1 constant:c];
}

#pragma mark left

- (void)bt_addConstraintLeft:(UIView*)view
                  toItemView:(UIView*)toItemView{
    [self bt_addConstraintLeft:view toItemView:toItemView constant:0];
}

- (void)bt_addConstraintLeft:(UIView*)view
                  toItemView:(UIView*)toItemView
                      isSame:(BOOL)isSame
{
    [self bt_addConstraintLeft:view toItemView:toItemView constant:0 isSame:isSame];
}

- (void)bt_addConstraintLeft:(UIView*)view
                  toItemView:(UIView*)toItemView
                    constant:(CGFloat)c{
    if ([view superview]==toItemView||[toItemView superview]==view) {
        [self bt_addConstraintLeft:view toItemView:toItemView constant:c isSame:YES];
    }else{
        [self bt_addConstraintLeft:view toItemView:toItemView constant:c isSame:NO];
    }
    
}


- (void)bt_addConstraintLeft:(UIView*)view
                  toItemView:(UIView*)toItemView
                    constant:(CGFloat)c
                      isSame:(BOOL)isSame
{
    BTBTConstraintModel * model = [[BTBTConstraintModel alloc] initWithView:view attribute:NSLayoutAttributeLeading relation:NSLayoutRelationEqual];
    BTBTConstraintModel * toItemModel = [[BTBTConstraintModel alloc] initWithToItemView:toItemView attribute:isSame?NSLayoutAttributeLeading:NSLayoutAttributeTrailing];
    [self bt_addConstraint:model toItemModel:toItemModel multiplier:1 constant:c];
    
}





#pragma mark right

- (void)bt_addConstraintRight:(UIView*)view
                   toItemView:(UIView*)toItemView{
    [self bt_addConstraintRight:view toItemView:toItemView constant:0];
}

- (void)bt_addConstraintRight:(UIView*)view
                   toItemView:(UIView*)toItemView
                       isSame:(BOOL)isSame
{
    [self bt_addConstraintRight:view toItemView:toItemView constant:0 isSame:isSame];
}

- (void)bt_addConstraintRight:(UIView*)view
                   toItemView:(UIView*)toItemView
                     constant:(CGFloat)c{
    if ([view superview]==toItemView||[toItemView superview]==view) {
        [self bt_addConstraintRight:view toItemView:toItemView constant:c isSame:YES];
    }else{
        [self bt_addConstraintRight:view toItemView:toItemView constant:c isSame:NO];
    }
    
}


- (void)bt_addConstraintRight:(UIView*)view
                   toItemView:(UIView*)toItemView
                     constant:(CGFloat)c
                       isSame:(BOOL)isSame
{
    
    BTBTConstraintModel * model = [[BTBTConstraintModel alloc] initWithView:view attribute:NSLayoutAttributeTrailing relation:NSLayoutRelationEqual];
    BTBTConstraintModel * toItemModel = [[BTBTConstraintModel alloc] initWithToItemView:toItemView attribute:isSame?NSLayoutAttributeTrailing:NSLayoutAttributeLeading];
    [self bt_addConstraint:model toItemModel:toItemModel multiplier:1 constant:c];
}
#pragma mark top
- (void)bt_addConstraintTop:(UIView*)view
                 toItemView:(UIView*)toItemView{
    [self bt_addConstraintTop:view toItemView:toItemView constant:0];
}

- (void)bt_addConstraintTop:(UIView*)view
                 toItemView:(UIView*)toItemView
                     isSame:(BOOL)isSame
{
    [self bt_addConstraintTop:view toItemView:toItemView constant:0 isSame:isSame];
}

- (void)bt_addConstraintTop:(UIView*)view
                 toItemView:(UIView*)toItemView
                   constant:(CGFloat)c{
    if ([view superview]==toItemView||[toItemView superview]==view) {
        [self bt_addConstraintTop:view toItemView:toItemView constant:c isSame:YES];
    }else{
        [self bt_addConstraintTop:view toItemView:toItemView constant:c isSame:NO];
    }
    
}


- (void)bt_addConstraintTop:(UIView*)view
                 toItemView:(UIView*)toItemView
                   constant:(CGFloat)c
                     isSame:(BOOL)isSame
{
    BTBTConstraintModel * model = [[BTBTConstraintModel alloc] initWithView:view attribute:NSLayoutAttributeTop relation:NSLayoutRelationEqual];
    BTBTConstraintModel * toItemModel = [[BTBTConstraintModel alloc] initWithToItemView:toItemView attribute:isSame?NSLayoutAttributeTop:NSLayoutAttributeBottom];
    [self bt_addConstraint:model toItemModel:toItemModel multiplier:1 constant:c];
    
}


#pragma mark bottom
- (void)bt_addConstraintBottom:(UIView*)view
              toItemView:(UIView*)toItemView{
    [self bt_addConstraintBottom:view toItemView:toItemView constant:0];
}

- (void)bt_addConstraintBottom:(UIView*)view
              toItemView:(UIView*)toItemView
                  isSame:(BOOL)isSame
{
    [self bt_addConstraintBottom:view toItemView:toItemView constant:0 isSame:isSame];
}

- (void)bt_addConstraintBottom:(UIView*)view
              toItemView:(UIView*)toItemView
                constant:(CGFloat)c{
    if ([view superview]==toItemView||[toItemView superview]==view) {
        [self bt_addConstraintBottom:view toItemView:toItemView constant:c isSame:YES];
    }else{
        [self bt_addConstraintBottom:view toItemView:toItemView constant:c isSame:NO];
    }
    
}


- (void)bt_addConstraintBottom:(UIView*)view
              toItemView:(UIView*)toItemView
                constant:(CGFloat)c
                  isSame:(BOOL)isSame
{
    BTBTConstraintModel * model = [[BTBTConstraintModel alloc] initWithView:view attribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual];
    BTBTConstraintModel * toItemModel = [[BTBTConstraintModel alloc] initWithToItemView:toItemView attribute:isSame?NSLayoutAttributeBottom:NSLayoutAttributeTop];
    [self bt_addConstraint:model toItemModel:toItemModel multiplier:1 constant:c];
}

#pragma mark center

- (void)bt_addConstraintCenterX:(UIView*)view toItemView:(UIView*)toItemView{
    [self bt_addConstraintCenterX:view toItemView:toItemView constant:0];
}

- (void)bt_addConstraintCenterX:(UIView*)view toItemView:(UIView*)toItemView  constant:(CGFloat)c{
    
    BTBTConstraintModel * model = [[BTBTConstraintModel alloc] initWithView:view attribute:NSLayoutAttributeCenterX relation:NSLayoutRelationEqual];
    BTBTConstraintModel * toItemModel = [[BTBTConstraintModel alloc] initWithToItemView:toItemView attribute:NSLayoutAttributeCenterX];
    [self bt_addConstraint:model toItemModel:toItemModel multiplier:1 constant:c];
}

- (void)bt_addConstraintCenterY:(UIView*)view toItemView:(UIView*)toItemView{
    [self bt_addConstraintCenterY:view toItemView:toItemView constant:0];
}

- (void)bt_addConstraintCenterY:(UIView*)view toItemView:(UIView*)toItemView  constant:(CGFloat)c{
    BTBTConstraintModel * model = [[BTBTConstraintModel alloc] initWithView:view attribute:NSLayoutAttributeCenterY relation:NSLayoutRelationEqual];
    BTBTConstraintModel * toItemModel = [[BTBTConstraintModel alloc] initWithToItemView:toItemView attribute:NSLayoutAttributeCenterY];
    [self bt_addConstraint:model toItemModel:toItemModel multiplier:1 constant:c];
}


- (void)bt_addConstraintCenter:(UIView*)view toItemView:(UIView*)toItemView{
    [self bt_addConstraintCenterX:view toItemView:toItemView];
    [self bt_addConstraintCenterY:view toItemView:toItemView];
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
    [self addConstraint:constraint];
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
