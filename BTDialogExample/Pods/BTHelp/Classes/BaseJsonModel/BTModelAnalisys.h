//
//  BaseModelAnalisys.h
//  framework
//
//  Created by whbt_mac on 16/5/19.
//  Copyright © 2016年 StoneMover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTModel.h"

@interface BTModelAnalisys : NSObject

-(void)analysisDict:(NSDictionary*)dict withModel:(BTModel*)model;


-(NSDictionary*)autoDataToDictionary:(BTModel*)model;
@end
