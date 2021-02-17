//
//  UIView+BTConstraint.h
//  BTDialogExample
//
//  Created by stonemover on 2019/4/13.
//  Copyright © 2019 stonemover. All rights reserved.
//  isSame参数表示是否和依赖的对象使用同一个方位参数,比如添加左边距依赖关系的时候,如果isSame为YES则
//  基于依赖对象的left,不相同则基于依赖对象的right,如果itemView与view是父子关系,则isSame默认为YES


/**
 
 Content Hugging Priority：直译成中文就是“内容拥抱优先级”，从字面意思上来看就是两个视图，谁的“内容拥抱优先级”高，谁就优先环绕其内容。稍后我们会根据一些示例进行介绍。

 Content Compression Resistance Priority：该优先级直译成中文就是“内容压缩阻力优先级”。也就是视图的“内容压缩阻力优先级”越大，那么该视图中的内容越难被压缩。而该优先级小的视图，则内容优先被压缩。稍后我们也会通过相应的实例来看一下这个优先级的具体表现。


 例如 图片+文字，宽度都不确定
 设置图片的Content Hugging 水平为251
 设置图片的Content Compression Resistance 水平为751
 
 */

#import <UIKit/UIKit.h>

struct BTPadding {
    CGFloat top;
    CGFloat bottom;
    CGFloat left;
    CGFloat right;
};

typedef struct CG_BOXABLE BTPadding BTPadding;

CG_INLINE BTPadding
BTPaddingMake(CGFloat top, CGFloat bottom,CGFloat left,CGFloat right)
{
    struct BTPadding p; p.top = top; p.bottom = bottom;p.left = left;p.right = right; return p;
}

NS_ASSUME_NONNULL_BEGIN

@class BTBTConstraintModel;

@interface UIView (BTConstraint)

#pragma mark width

- (NSLayoutConstraint *)bt_addWidth:(CGFloat)c;

- (NSLayoutConstraint *)bt_addWidth:(NSLayoutRelation)relation constant:(CGFloat)c;

- (NSLayoutConstraint *)bt_addEqualWidthToView:(UIView*)toView;

#pragma mark height

- (NSLayoutConstraint *)bt_addHeight:(CGFloat)c;

- (NSLayoutConstraint *)bt_addHeight:(NSLayoutRelation)relation constant:(CGFloat)c;

- (NSLayoutConstraint *)bt_addEqualHeightToView:(UIView*)toView;

#pragma mark left

- (NSLayoutConstraint *)bt_addLeftToParent;

- (NSLayoutConstraint *)bt_addLeftToParentWithPadding:(CGFloat)padding;

- (NSLayoutConstraint *)bt_addLeftToItemView:(UIView*)toItemView;

- (NSLayoutConstraint *)bt_addLeftToItemView:(UIView*)toItemView isSame:(BOOL)isSame;

- (NSLayoutConstraint *)bt_addLeftToItemView:(UIView*)toItemView constant:(CGFloat)c;

- (NSLayoutConstraint *)bt_addLeftToItemView:(UIView*)toItemView constant:(CGFloat)c isSame:(BOOL)isSame;

#pragma mark right

- (NSLayoutConstraint *)bt_addRightToParent;

- (NSLayoutConstraint *)bt_addRightToParentWithPadding:(CGFloat)padding;

- (NSLayoutConstraint *)bt_addRightToItemView:(UIView*)toItemView;

- (NSLayoutConstraint *)bt_addRightToItemView:(UIView*)toItemView isSame:(BOOL)isSame;

- (NSLayoutConstraint *)bt_addRightToItemView:(UIView*)toItemView constant:(CGFloat)c;

- (NSLayoutConstraint *)bt_addRightToItemView:(UIView*)toItemView constant:(CGFloat)c isSame:(BOOL)isSame;

#pragma mark top

- (NSLayoutConstraint *)bt_addTopToParent;

- (NSLayoutConstraint *)bt_addTopToParentWithPadding:(CGFloat)padding;

- (NSLayoutConstraint *)bt_addTopToItemView:(UIView*)toItemView;

- (NSLayoutConstraint *)bt_addTopToItemView:(UIView*)toItemView isSame:(BOOL)isSame;

- (NSLayoutConstraint *)bt_addTopToItemView:(UIView*)toItemView constant:(CGFloat)c;

- (NSLayoutConstraint *)bt_addTopToItemView:(UIView*)toItemView constant:(CGFloat)c isSame:(BOOL)isSame;

#pragma mark bottom

- (NSLayoutConstraint *)bt_addBottomToParent;

- (NSLayoutConstraint *)bt_addBottomToParentWithPadding:(CGFloat)padding;

- (NSLayoutConstraint *)bt_addBottomToItemView:(UIView*)toItemView;

- (NSLayoutConstraint *)bt_addBottomToItemView:(UIView*)toItemView isSame:(BOOL)isSame;

- (NSLayoutConstraint *)bt_addBottomToItemView:(UIView*)toItemView constant:(CGFloat)c;

- (NSLayoutConstraint *)bt_addBottomToItemView:(UIView*)toItemView constant:(CGFloat)c isSame:(BOOL)isSame;


#pragma mark center

- (NSLayoutConstraint *)bt_addCenterXToParent;
- (NSLayoutConstraint *)bt_addCenterXToItemView:(UIView*)toItemView;
- (NSLayoutConstraint *)bt_addCenterXToItemView:(UIView*)toItemView constant:(CGFloat)c;

- (NSLayoutConstraint *)bt_addCenterYToParent;
- (NSLayoutConstraint *)bt_addCenterYToItemView:(UIView*)toItemView;
- (NSLayoutConstraint *)bt_addCenterYToItemView:(UIView*)toItemView  constant:(CGFloat)c;

//第一个为X约束，第二个为Y约束
- (NSArray<NSLayoutConstraint*> *)bt_addCenterToParent;
- (NSArray<NSLayoutConstraint*> *)bt_addCenterToItemView:(UIView*)toItemView;

#pragma mark 其它
//约束顺序为上下左右
- (NSArray<NSLayoutConstraint*> *)bt_addToParentWithPadding:(BTPadding)padding;

#pragma mark 用model创建
- (NSLayoutConstraint *)bt_addConstraint:(BTBTConstraintModel*)model
             toItemModel:(BTBTConstraintModel*)toItemModel
              multiplier:(CGFloat)multiplier
                constant:(CGFloat)c;

- (NSLayoutConstraint *)bt_addConstraint:(BTBTConstraintModel*)model
             toItemModel:(BTBTConstraintModel*)toItemModel;

- (NSLayoutConstraint *)bt_addConstraint:(BTBTConstraintModel*)model
             toItemModel:(BTBTConstraintModel*)toItemModel
                constant:(CGFloat)c;

//- (void)bt_removeAllCon


@end


@interface BTBTConstraintModel : NSObject

- (instancetype)initWithView:(UIView*)view attribute:(NSLayoutAttribute)attribute relation:(NSLayoutRelation)relation;

- (instancetype)initWithToItemView:(nullable UIView*)view attribute:(NSLayoutAttribute)attribute;

@property (nonatomic, strong) UIView * view;

@property (nonatomic, assign) NSLayoutAttribute attribute;

@property (nonatomic, assign) NSLayoutRelation relation;

@end


NS_ASSUME_NONNULL_END
