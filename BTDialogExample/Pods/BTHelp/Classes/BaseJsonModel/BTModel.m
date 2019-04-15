//
//  BaseModel.m
//  freeuse
//
//  Created by whbt_mac on 16/4/25.
//  Copyright © 2016年 StoneMover. All rights reserved.
//

#import "BTModel.h"
#import "BTModelAnalisys.h"


@implementation BTModel

+(instancetype)modelWithDict:(NSDictionary*)dict{
    return [[self alloc]initWithDict:dict];
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
