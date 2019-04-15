//
//  UIView+BTConstraint.h
//  BTDialogExample
//
//  Created by stonemover on 2019/4/13.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (BTConstraint)

#pragma mark width

- (void)addConstraintWidth:(CGFloat)c;

- (void)addConstraintWidth:(NSLayoutRelation)relation constant:(CGFloat)c;

#pragma mark height

- (void)addConstraintHeight:(CGFloat)c;

- (void)addConstraintHeight:(NSLayoutRelation)relation constant:(CGFloat)c;

#pragma mark left

- (void)addConstraintLeft:(UIView*)view
               toItemView:(UIView*)toItemView;

- (void)addConstraintLeft:(UIView*)view
               toItemView:(UIView*)toItemView
                   isSame:(BOOL)isSame;

- (void)addConstraintLeft:(UIView*)view
               toItemView:(UIView*)toItemView
                 constant:(CGFloat)c;


- (void)addConstraintLeft:(UIView*)view
               toItemView:(UIView*)toItemView
                 constant:(CGFloat)c
                   isSame:(BOOL)isSame;

#pragma mark right
- (void)addConstraintRight:(UIView*)view
                toItemView:(UIView*)toItemView;

- (void)addConstraintRight:(UIView*)view
                toItemView:(UIView*)toItemView
                    isSame:(BOOL)isSame;

- (void)addConstraintRight:(UIView*)view
                toItemView:(UIView*)toItemView
                  constant:(CGFloat)c;


- (void)addConstraintRight:(UIView*)view
                toItemView:(UIView*)toItemView
                  constant:(CGFloat)c
                    isSame:(BOOL)isSame;

#pragma mark top
- (void)addConstraintTop:(UIView*)view
              toItemView:(UIView*)toItemView;

- (void)addConstraintTop:(UIView*)view
              toItemView:(UIView*)toItemView
                  isSame:(BOOL)isSame;

- (void)addConstraintTop:(UIView*)view
              toItemView:(UIView*)toItemView
                constant:(CGFloat)c;


- (void)addConstraintTop:(UIView*)view
              toItemView:(UIView*)toItemView
                constant:(CGFloat)c
                  isSame:(BOOL)isSame;

#pragma mark bottom
- (void)addConstraintBottom:(UIView*)view
                 toItemView:(UIView*)toItemView;

- (void)addConstraintBottom:(UIView*)view
                 toItemView:(UIView*)toItemView
                     isSame:(BOOL)isSame;

- (void)addConstraintBottom:(UIView*)view
                 toItemView:(UIView*)toItemView
                   constant:(CGFloat)c;


- (void)addConstraintBottom:(UIView*)view
                 toItemView:(UIView*)toItemView
                   constant:(CGFloat)c
                     isSame:(BOOL)isSame;


#pragma mark center

- (void)addConstraintCenterX:(UIView*)view toItemView:(UIView*)toItemView;
- (void)addConstraintCenterX:(UIView*)view toItemView:(UIView*)toItemView  constant:(CGFloat)c;

- (void)addConstraintCenterY:(UIView*)view toItemView:(UIView*)toItemView;
- (void)addConstraintCenterY:(UIView*)view toItemView:(UIView*)toItemView  constant:(CGFloat)c;

- (void)addConstraintCenter:(UIView*)view toItemView:(UIView*)toItemView;

@end


