//
//  BaseModel.h
//  freeuse
//
//  Created by whbt_mac on 16/4/25.
//  Copyright © 2016年 StoneMover. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BTModel : NSObject

+(instancetype)modelWithDict:(NSDictionary*)dict;

+(NSMutableArray*)modelWithArray:(NSArray*)array;

-(instancetype)initWithDict:(NSDictionary*)dict;

-(void)analisys:(NSDictionary*)dict;

-(void)initSelf;

-(NSDictionary*)autoDataToDictionary;

//别名设置，当放回的key和你设定好的不一样的时候,比如你叫uid，返回的未userId，@{@"uid":@"userId"}
@property (nonatomic, strong) NSDictionary * aliasDict;

//对应的数组中的model类名，比如解析的数据中的数组类为UserModel，则设置@{@"userList":@"userModel"}
//userList为需要解析的数组key名称，userModel为数组中放的对象
//如果你有别名的设置，比如你的key为userArray，而后台返回的为userList，则需要设置别名为@{@"userArray":@"userList"}，那么设置classDict就以别名为基准
@property (nonatomic, strong) NSDictionary * classDict;

//需要忽略的解析字段,如果你不想解析一个字段例如title,那个将其加入就不会解析.如果后台返回的数据中没有该字段,也不会解析,就不用添加.
@property (nonatomic, strong) NSSet * ignoreAnalisysField;

//需要将model转换为字典的时候，需要忽略的字段
@property (nonatomic, strong) NSSet * ignoreUnAnalisysField;

@end


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


@interface BTModelAnalisys : NSObject

-(void)analysisDict:(NSDictionary*)dict withModel:(BTModel*)model;

-(NSDictionary*)autoDataToDictionary:(BTModel*)model;

@end
