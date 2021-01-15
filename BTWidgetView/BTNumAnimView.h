//
//  BTNumAnimView.h
//  BTWidgetViewExample
//
//  Created by apple on 2021/1/13.
//  Copyright © 2021 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BTNumAnimView : UIView

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor*)color font:(UIFont*)font;

- (void)startAnimTo:(NSInteger)index time:(CGFloat)time;

@end

NS_ASSUME_NONNULL_END
