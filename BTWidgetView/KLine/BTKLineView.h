//
//  BTKLineView.h
//  BTWidgetViewExample
//
//  Created by apple on 2020/12/30.
//  Copyright © 2020 stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTKLineModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BTKLineView : UIView

@property (nonatomic, strong) NSMutableArray<BTKLineModel*> * dataArray;

@end

NS_ASSUME_NONNULL_END
