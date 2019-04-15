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

-(instancetype)initWithDict:(NSDictionary*)dict;

-(void)analisys:(NSDictionary*)dict;

-(void)initSelf;

-(NSDictionary*)autoDataToDictionary;


@property (nonatomic, strong) NSDictionary * aliasDict;

@property (nonatomic, strong) NSDictionary * classDict;

//需要忽略的解析字段,如果你不想解析一个字段例如title,那个将其加入就不会解析.如果后台返回的数据中没有该字段,也不会解析,就不用添加.
@property (nonatomic, strong) NSSet * ignoreAnalisysField;

@property (nonatomic, strong) NSSet * ignoreUnAnalisysField;

@end
