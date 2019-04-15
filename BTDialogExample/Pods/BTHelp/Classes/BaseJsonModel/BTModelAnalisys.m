//
//  BaseModelAnalisys.m
//  framework
//
//  Created by whbt_mac on 16/5/19.
//  Copyright © 2016年 StoneMover. All rights reserved.
//

#import "BTModelAnalisys.h"
#import "BTModelProperty.h"
#import <objc/runtime.h>

@implementation BTModelAnalisys

-(void)analysisDict:(NSDictionary*)dict withModel:(BTModel*)model{
    
    NSArray * attributes=[self propertyKeys:model isAnalisys:YES];
    
    for (BTModelProperty * key in attributes) {
        NSString * dictKey=key.aliasName;
        if ([dict valueForKey:dictKey]) {
            //当字典中存在该key的时候
            switch (key.type) {
                case BaseModelTypeString:
                {
                    id result=[NSString stringWithFormat:@"%@",[dict objectForKey:dictKey]];
                    if ([result class]==[NSNull class]||[result isEqualToString:@"<null>"]){
                        result=@"";
                    }
                    [model setValue:result forKey:key.propertyName];
                }
                    break;
                case BaseModelTypeInt:
                case BaseModelTypeFloat:
                case BaseModelTypeDouble:
                case BaseModelTypeBool:
                {
                    id result=[dict objectForKey:dictKey];
                    if ([result class]==[NSNull class]){
                        result=@"";
                    }
                    [model setValue:result forKey:key.propertyName];
                    break;
                }

                case BaseModelTypeArray:
                case BaseModelTypeMutableArray:
                {
                    //判断数组是否为0
                    NSArray * dictArray=[dict objectForKey:dictKey];
                    if (dictArray.count==0) {
                        break;
                    }
                    
                    //这里判断数组里面是否为字典类型,如果为字典类型则进行类的进一步解析,如果不是则直接赋值即可
                    if ([dictArray[0] isKindOfClass:[NSDictionary class]]){
                        NSString * className=[model.classDict objectForKey:dictKey];
                        if (!className) {
                            [self LogError:@"empty class name error!"];
                            break;
                        }
                        NSMutableArray * mutableArray=[[NSMutableArray alloc]init];
                        for (NSDictionary * dictChild in dictArray) {
                            Class child=NSClassFromString(className);
                            BTModel * modelChild=[[child alloc]init];
                            [self analysisDict:dictChild withModel:modelChild];
                            [mutableArray addObject:modelChild];
                        }
                        
                        if (key.type==BaseModelTypeArray) {
                            NSArray * array=[NSArray arrayWithArray:mutableArray];
                            [model setValue:array forKey:key.propertyName];
                        }else{
                            [model setValue:mutableArray forKey:key.propertyName];
                        }
                        
                    }else{
                        [model setValue:dictArray forKey:key.propertyName];
                    }
                    break;
                }

                case BaseModelTypeBase:{
                    NSDictionary * dictChild=[dict objectForKey:dictKey];
                    if (![dictChild isKindOfClass:[NSDictionary class]]) {
                        [self LogError:@"return data type error,there is need dictionary,but get other."];
                        break;
                    }
                    
                    NSString * className=[model.classDict objectForKey:dictKey];
                    if (!className) {
                        [self LogError:@"empty class name error!"];
                        break;
                    }
                    
                    Class child=NSClassFromString(className);
                    BTModel * modelChild=[[child alloc]init];
                    [self analysisDict:dictChild withModel:modelChild];
                    [model setValue:modelChild forKey:key.propertyName];
                    break;
                }
   
                default:
                    break;
            }
        }
    }
}

-(NSDictionary*)autoDataToDictionary:(BTModel*)model{
    NSDictionary * dict=[[NSMutableDictionary alloc]init];
    NSArray * attributes=[self propertyKeys:model isAnalisys:NO];
    for (BTModelProperty * property in attributes) {
        switch (property.type) {
            case BaseModelTypeString:
            case BaseModelTypeInt:
            case BaseModelTypeFloat:
            case BaseModelTypeDouble:
            case BaseModelTypeBool:
            {
                id value=[model valueForKey:property.propertyName];
                [dict setValue:value forKey:property.aliasName];
                break;
            }
                
            case BaseModelTypeArray:
            case BaseModelTypeMutableArray:
            {
                NSMutableArray * array=[[NSMutableArray alloc]init];
                NSArray * arrayData=[model valueForKey:property.propertyName];
                for (BTModel * childModel in arrayData) {
                    NSDictionary * dictChild=[self autoDataToDictionary:childModel];
                    [array addObject:dictChild];
                }
                
                [dict setValue:array forKey:property.aliasName];
                
                break;
            }
                
            case BaseModelTypeBase:{
                BTModel * childModel=[model valueForKey:property.propertyName];
                NSDictionary * dictValue=[self autoDataToDictionary:childModel];
                [dict setValue:dictValue forKey:property.aliasName];
                break;
            }
                
            default:
                break;
        }
        
    }
    return dict;
}

- (NSArray*)propertyKeys:(BTModel*)baseModel isAnalisys:(BOOL)isAnalisys
{
    if (![baseModel isKindOfClass:[BTModel class]]) {
        [self LogError:@"data is not kind of BaseModel"];
        return @[];
    }
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([baseModel class], &outCount);
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:outCount];
    NSSet * aliasKeys=[[NSSet alloc]initWithArray:baseModel.aliasDict.allKeys];
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        //如果有配置别名信息,则取出别名赋值
        NSString * aliasName=propertyName;
        if ([aliasKeys containsObject:propertyName]) {
            aliasName=[baseModel.aliasDict objectForKey:propertyName];
        }
        
        //如果不是被忽略的解析字段则加入解析数组中
        if (isAnalisys) {
            if (![baseModel.ignoreAnalisysField containsObject:propertyName]) {
                NSString * propertyType=[[NSString alloc]initWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
                BTModelProperty * model=[[BTModelProperty alloc]init];
                model.propertyName=propertyName;
                model.aliasName=aliasName;
                [model autoType:propertyType];
                [keys addObject:model];
            }
        }else{
            if (![baseModel.ignoreUnAnalisysField containsObject:propertyName]) {
                NSString * propertyType=[[NSString alloc]initWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
                BTModelProperty * model=[[BTModelProperty alloc]init];
                model.propertyName=propertyName;
                model.aliasName=aliasName;
                [model autoType:propertyType];
                [keys addObject:model];
            }
        }
        
    }
    free(properties);
    return keys;
}



-(void)LogError:(NSString*)errorInfo{
    NSLog(@"BaseModelAnalisys %@",errorInfo);
}

@end
