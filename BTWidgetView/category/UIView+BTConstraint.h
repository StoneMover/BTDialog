//
//  UIView+BTConstraint.h
//  BTDialogExample
//
//  Created by stonemover on 2019/4/13.
//  Copyright © 2019 stonemover. All rights reserved.
//  isSame参数表示是否和依赖的对象使用同一个方位参数,比如添加左边距依赖关系的时候,如果isSame为YES则
//  基于依赖对象的left,不相同则基于依赖对象的right,如果itemView与view是父子关系,则isSame默认为YES

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BTBTConstraintModel;

@interface UIView (BTConstraint)

#pragma mark width

- (void)bt_addConstraintWidth:(CGFloat)c;

- (void)bt_addConstraintWidth:(NSLayoutRelation)relation constant:(CGFloat)c;

#pragma mark height

- (void)bt_addConstraintHeight:(CGFloat)c;

- (void)bt_addConstraintHeight:(NSLayoutRelation)relation constant:(CGFloat)c;

#pragma mark left

- (void)bt_addConstraintLeft:(UIView*)view
                  toItemView:(UIView*)toItemView;

- (void)bt_addConstraintLeft:(UIView*)view
                  toItemView:(UIView*)toItemView
                      isSame:(BOOL)isSame;

- (void)bt_addConstraintLeft:(UIView*)view
                  toItemView:(UIView*)toItemView
                    constant:(CGFloat)c;

/*
 
 */
- (void)bt_addConstraintLeft:(UIView*)view
                  toItemView:(UIView*)toItemView
                    constant:(CGFloat)c
                      isSame:(BOOL)isSame;

#pragma mark right
- (void)bt_addConstraintRight:(UIView*)view
                   toItemView:(UIView*)toItemView;

- (void)bt_addConstraintRight:(UIView*)view
                   toItemView:(UIView*)toItemView
                       isSame:(BOOL)isSame;

- (void)bt_addConstraintRight:(UIView*)view
                   toItemView:(UIView*)toItemView
                     constant:(CGFloat)c;


- (void)bt_addConstraintRight:(UIView*)view
                   toItemView:(UIView*)toItemView
                     constant:(CGFloat)c
                       isSame:(BOOL)isSame;

#pragma mark top
- (void)bt_addConstraintTop:(UIView*)view
                 toItemView:(UIView*)toItemView;

- (void)bt_addConstraintTop:(UIView*)view
                 toItemView:(UIView*)toItemView
                     isSame:(BOOL)isSame;

- (void)bt_addConstraintTop:(UIView*)view
                 toItemView:(UIView*)toItemView
                   constant:(CGFloat)c;


- (void)bt_addConstraintTop:(UIView*)view
                 toItemView:(UIView*)toItemView
                   constant:(CGFloat)c
                     isSame:(BOOL)isSame;

#pragma mark bottom
- (void)bt_addConstraintBottom:(UIView*)view
                    toItemView:(UIView*)toItemView;

- (void)bt_addConstraintBottom:(UIView*)view
                    toItemView:(UIView*)toItemView
                        isSame:(BOOL)isSame;

- (void)bt_addConstraintBottom:(UIView*)view
                    toItemView:(UIView*)toItemView
                      constant:(CGFloat)c;


- (void)bt_addConstraintBottom:(UIView*)view
                    toItemView:(UIView*)toItemView
                      constant:(CGFloat)c
                        isSame:(BOOL)isSame;


#pragma mark center

- (void)bt_addConstraintCenterX:(UIView*)view toItemView:(UIView*)toItemView;
- (void)bt_addConstraintCenterX:(UIView*)view toItemView:(UIView*)toItemView  constant:(CGFloat)c;

- (void)bt_addConstraintCenterY:(UIView*)view toItemView:(UIView*)toItemView;
- (void)bt_addConstraintCenterY:(UIView*)view toItemView:(UIView*)toItemView  constant:(CGFloat)c;

- (void)bt_addConstraintCenter:(UIView*)view toItemView:(UIView*)toItemView;


#pragma mark 用model创建
- (void)bt_addConstraint:(BTBTConstraintModel*)model
             toItemModel:(BTBTConstraintModel*)toItemModel
              multiplier:(CGFloat)multiplier
                constant:(CGFloat)c;

- (void)bt_addConstraint:(BTBTConstraintModel*)model
             toItemModel:(BTBTConstraintModel*)toItemModel;

- (void)bt_addConstraint:(BTBTConstraintModel*)model
             toItemModel:(BTBTConstraintModel*)toItemModel
                constant:(CGFloat)c;


@end


@interface BTBTConstraintModel : NSObject

- (instancetype)initWithView:(UIView*)view attribute:(NSLayoutAttribute)attribute relation:(NSLayoutRelation)relation;

- (instancetype)initWithToItemView:(nullable UIView*)view attribute:(NSLayoutAttribute)attribute;

@property (nonatomic, strong) UIView * view;

@property (nonatomic, assign) NSLayoutAttribute attribute;

@property (nonatomic, assign) NSLayoutRelation relation;

@end


NS_ASSUME_NONNULL_END
