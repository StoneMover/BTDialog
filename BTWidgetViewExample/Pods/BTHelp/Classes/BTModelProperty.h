//
//  BaseModelProperty.h
//  framework
//
//  Created by whbt_mac on 16/5/18.
//  Copyright © 2016年 StoneMover. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,BaseModelType) {
    BaseModelTypeString=0,
    BaseModelTypeInt,
    BaseModelTypeFloat,
    BaseModelTypeDouble,
    BaseModelTypeBool,
    BaseModelTypeArray,
    BaseModelTypeMutableArray,
    BaseModelTypeBase
};

@interface BTModelProperty : NSObject

@property(nonatomic,strong) NSString * propertyName;

@property (nonatomic, strong) NSString * aliasName;

@property (nonatomic, assign) BaseModelType type;

-(void)autoType:(NSString*)typeStr;

@end
