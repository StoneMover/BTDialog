//
//  BaseModelProperty.m
//  framework
//
//  Created by whbt_mac on 16/5/18.
//  Copyright © 2016年 StoneMover. All rights reserved.
//

#import "BTModelProperty.h"

@implementation BTModelProperty


-(void)autoType:(NSString*)typeStr{
    if ([typeStr hasPrefix:@"Ti"]||[typeStr hasPrefix:@"Tq"]) {
        self.type=BaseModelTypeInt;
    }else if ([typeStr hasPrefix:@"Tf"]){
        self.type=BaseModelTypeFloat;
    }else if ([typeStr hasPrefix:@"Td"]){
        self.type=BaseModelTypeDouble;
    }else if ([typeStr hasPrefix:@"TB"]){
        self.type=BaseModelTypeBool;
    }else if ([typeStr hasPrefix:@"T@\"NSMutableArray\""]){
        self.type=BaseModelTypeMutableArray;
    }else if ([typeStr hasPrefix:@"T@\"NSString\""]){
        self.type=BaseModelTypeString;
    }else if ([typeStr hasPrefix:@"T@\"NSArray\""]){
        self.type=BaseModelTypeArray;
    }else{
        self.type=BaseModelTypeBase;
    }
}

@end
