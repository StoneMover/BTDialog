//
//  BaseModel.m
//  freeuse
//
//  Created by whbt_mac on 16/4/25.
//  Copyright © 2016年 StoneMover. All rights reserved.
//

#import "BTModel.h"
#import <objc/runtime.h>


@implementation BTModel

+(instancetype)modelWithDict:(NSDictionary*)dict{
    return [[self alloc]initWithDict:dict];
}

+(NSMutableArray*)modelWithArray:(NSArray*)array{
    NSMutableArray * dataArray =[NSMutableArray new];
    for (NSDictionary * dict in array) {
        [dataArray addObject:[self modelWithDict:dict]];
    }
    
    return dataArray;
}

-(instancetype)init{
    self=[super init];
    [self initSelf];
    return self;
}

-(instancetype)initWithDict:(NSDictionary*)dict{
    self=[self init];
    [self analisys:dict];
    return self;
}



-(void)initSelf{
    
}

-(void)analisys:(NSDictionary*)dict{
    BTModelAnalisys * analysis=[[BTModelAnalisys alloc]init];
    [analysis analysisDict:dict withModel:self];
}


-(NSDictionary*)autoDataToDictionary{
    BTModelAnalisys * analysis=[[BTModelAnalisys alloc]init];
    return [analysis autoDataToDictionary:self];
}

@end


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
                    if (![dictArray isKindOfClass:[NSArray class]]||dictArray.count==0) {
                        break;
                    }
                    
                    //这里判断数组里面是否为字典类型,如果为字典类型则进行类的进一步解析,如果不是则直接赋值即可
                    if ([dictArray[0] isKindOfClass:[NSDictionary class]]){
                        Class  className=[model.classDict objectForKey:dictKey];
                        if (!className) {
                            [self LogError:@"empty class error!"];
                            break;
                        }
                        
                        NSMutableArray * mutableArray=[[NSMutableArray alloc]init];
                        for (NSDictionary * dictChild in dictArray) {
                            Class child=className;
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
                    
                    Class className=[model.classDict objectForKey:dictKey];
                    if (!className) {
                        [self LogError:@"empty class name error!"];
                        break;
                    }
                    
                    Class child=className;
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
                    if ([childModel isKindOfClass:[BTModel class]]) {
                        NSDictionary * dictChild=[self autoDataToDictionary:childModel];
                        [array addObject:dictChild];
                    }else{
                        [array addObject:childModel];
                    }
                    
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
    
    NSMutableArray * array =[NSMutableArray new];
    [array addObjectsFromArray:[self propertyKey:[baseModel class] aliasDict:baseModel.aliasDict ignoreAnalisysField:baseModel.ignoreAnalisysField ignoreUnAnalisysField:baseModel.ignoreUnAnalisysField isAnalisys:isAnalisys]];
    
    Class claSuper =[baseModel superclass];
    while (claSuper !=[BTModel class]) {
        [array addObjectsFromArray:[self propertyKey:claSuper aliasDict:baseModel.aliasDict ignoreAnalisysField:baseModel.ignoreAnalisysField ignoreUnAnalisysField:baseModel.ignoreUnAnalisysField isAnalisys:isAnalisys]];
        claSuper=[claSuper superclass];
    }
    
    return array;
}

- (NSArray*)propertyKey:(Class)cla
              aliasDict:(NSDictionary*)aliasDict
    ignoreAnalisysField:(NSSet*)ignoreAnalisysField
  ignoreUnAnalisysField:(NSSet*)ignoreUnAnalisysField
             isAnalisys:(BOOL)isAnalisys
{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(cla, &outCount);
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:outCount];
    NSSet * aliasKeys=[[NSSet alloc]initWithArray:aliasDict.allKeys];
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        //如果有配置别名信息,则取出别名赋值
        NSString * aliasName=propertyName;
        if ([aliasKeys containsObject:propertyName]) {
            aliasName=[aliasDict objectForKey:propertyName];
        }
        
        //如果不是被忽略的解析字段则加入解析数组中
        if (isAnalisys) {
            if (![ignoreAnalisysField containsObject:propertyName]) {
                NSString * propertyType=[[NSString alloc]initWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
                BTModelProperty * model=[[BTModelProperty alloc]init];
                model.propertyName=propertyName;
                model.aliasName=aliasName;
                [model autoType:propertyType];
                [keys addObject:model];
            }
        }else{
            if (![ignoreUnAnalisysField containsObject:propertyName]) {
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
