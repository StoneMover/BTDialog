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

- (void)addConstraintWidth:(CGFloat)c{
    [self addConstraintWidth:NSLayoutRelationEqual constant:c];
}

- (void)addConstraintWidth:(NSLayoutRelation)relation constant:(CGFloat)c{
    NSLayoutConstraint * constraint=[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:relation toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:c];
    [self addConstraint:constraint];
}

#pragma mark height

- (void)addConstraintHeight:(CGFloat)c{
    [self addConstraintHeight:NSLayoutRelationEqual constant:c];
}

- (void)addConstraintHeight:(NSLayoutRelation)relation constant:(CGFloat)c{
    NSLayoutConstraint * constraint=[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:relation toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:c];
    [self addConstraint:constraint];
}

#pragma mark left

- (void)addConstraintLeft:(UIView*)view
               toItemView:(UIView*)toItemView{
    [self addConstraintLeft:view toItemView:toItemView constant:0];
}

- (void)addConstraintLeft:(UIView*)view
               toItemView:(UIView*)toItemView
                   isSame:(BOOL)isSame
{
    [self addConstraintLeft:view toItemView:toItemView constant:0 isSame:isSame];
}

- (void)addConstraintLeft:(UIView*)view
               toItemView:(UIView*)toItemView
                 constant:(CGFloat)c{
    if ([view superview]==toItemView||[toItemView superview]==view) {
        [self addConstraintLeft:view toItemView:toItemView constant:c isSame:YES];
    }else{
        [self addConstraintLeft:view toItemView:toItemView constant:c isSame:NO];
    }
    
}


- (void)addConstraintLeft:(UIView*)view
               toItemView:(UIView*)toItemView
                 constant:(CGFloat)c
                   isSame:(BOOL)isSame
{
    if (isSame) {
        NSLayoutConstraint * constraint=[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:toItemView attribute:NSLayoutAttributeLeading multiplier:1 constant:c];
        [self addConstraint:constraint];
    }else{
        NSLayoutConstraint * constraint=[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:toItemView attribute:NSLayoutAttributeTrailing multiplier:1 constant:c];
        [self addConstraint:constraint];
    }
    
}





#pragma mark right

- (void)addConstraintRight:(UIView*)view
               toItemView:(UIView*)toItemView{
    [self addConstraintRight:view toItemView:toItemView constant:0];
}

- (void)addConstraintRight:(UIView*)view
               toItemView:(UIView*)toItemView
                   isSame:(BOOL)isSame
{
    [self addConstraintRight:view toItemView:toItemView constant:0 isSame:isSame];
}

- (void)addConstraintRight:(UIView*)view
               toItemView:(UIView*)toItemView
                 constant:(CGFloat)c{
    if ([view superview]==toItemView||[toItemView superview]==view) {
        [self addConstraintRight:view toItemView:toItemView constant:c isSame:YES];
    }else{
        [self addConstraintRight:view toItemView:toItemView constant:c isSame:NO];
    }
    
}


- (void)addConstraintRight:(UIView*)view
               toItemView:(UIView*)toItemView
                 constant:(CGFloat)c
                   isSame:(BOOL)isSame
{
    if (isSame) {
        NSLayoutConstraint * constraint=[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:toItemView attribute:NSLayoutAttributeTrailing multiplier:1 constant:c];
        [self addConstraint:constraint];
    }else{
        NSLayoutConstraint * constraint=[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:toItemView attribute:NSLayoutAttributeLeading multiplier:1 constant:c];
        [self addConstraint:constraint];
    }
    
}
#pragma mark top
- (void)addConstraintTop:(UIView*)view
                toItemView:(UIView*)toItemView{
    [self addConstraintTop:view toItemView:toItemView constant:0];
}

- (void)addConstraintTop:(UIView*)view
                toItemView:(UIView*)toItemView
                    isSame:(BOOL)isSame
{
    [self addConstraintTop:view toItemView:toItemView constant:0 isSame:isSame];
}

- (void)addConstraintTop:(UIView*)view
                toItemView:(UIView*)toItemView
                  constant:(CGFloat)c{
    if ([view superview]==toItemView||[toItemView superview]==view) {
        [self addConstraintTop:view toItemView:toItemView constant:c isSame:YES];
    }else{
        [self addConstraintTop:view toItemView:toItemView constant:c isSame:NO];
    }
    
}


- (void)addConstraintTop:(UIView*)view
                toItemView:(UIView*)toItemView
                  constant:(CGFloat)c
                    isSame:(BOOL)isSame
{
    if (isSame) {
        NSLayoutConstraint * constraint=[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:toItemView attribute:NSLayoutAttributeTop multiplier:1 constant:c];
        [self addConstraint:constraint];
    }else{
        NSLayoutConstraint * constraint=[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:toItemView attribute:NSLayoutAttributeBottom multiplier:1 constant:c];
        [self addConstraint:constraint];
    }
    
}


#pragma mark bottom
- (void)addConstraintBottom:(UIView*)view
              toItemView:(UIView*)toItemView{
    [self addConstraintBottom:view toItemView:toItemView constant:0];
}

- (void)addConstraintBottom:(UIView*)view
              toItemView:(UIView*)toItemView
                  isSame:(BOOL)isSame
{
    [self addConstraintBottom:view toItemView:toItemView constant:0 isSame:isSame];
}

- (void)addConstraintBottom:(UIView*)view
              toItemView:(UIView*)toItemView
                constant:(CGFloat)c{
    if ([view superview]==toItemView||[toItemView superview]==view) {
        [self addConstraintBottom:view toItemView:toItemView constant:c isSame:YES];
    }else{
        [self addConstraintBottom:view toItemView:toItemView constant:c isSame:NO];
    }
    
}


- (void)addConstraintBottom:(UIView*)view
              toItemView:(UIView*)toItemView
                constant:(CGFloat)c
                  isSame:(BOOL)isSame
{
    if (isSame) {
        NSLayoutConstraint * constraint=[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:toItemView attribute:NSLayoutAttributeBottom multiplier:1 constant:c];
        [self addConstraint:constraint];
    }else{
        NSLayoutConstraint * constraint=[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:toItemView attribute:NSLayoutAttributeTop multiplier:1 constant:c];
        [self addConstraint:constraint];
    }
    
}

#pragma mark center

- (void)addConstraintCenterX:(UIView*)view toItemView:(UIView*)toItemView{
    [self addConstraintCenterX:view toItemView:toItemView constant:0];
}

- (void)addConstraintCenterX:(UIView*)view toItemView:(UIView*)toItemView  constant:(CGFloat)c{
    NSLayoutConstraint * constraint=[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:toItemView attribute:NSLayoutAttributeCenterX multiplier:1 constant:c];
    [self addConstraint:constraint];
}

- (void)addConstraintCenterY:(UIView*)view toItemView:(UIView*)toItemView{
    [self addConstraintCenterY:view toItemView:toItemView constant:0];
}

- (void)addConstraintCenterY:(UIView*)view toItemView:(UIView*)toItemView  constant:(CGFloat)c{
    NSLayoutConstraint * constraint=[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:toItemView attribute:NSLayoutAttributeCenterY multiplier:1 constant:c];
    [self addConstraint:constraint];
}


- (void)addConstraintCenter:(UIView*)view toItemView:(UIView*)toItemView{
    [self addConstraintCenterX:view toItemView:toItemView];
    [self addConstraintCenterY:view toItemView:toItemView];
}


@end
