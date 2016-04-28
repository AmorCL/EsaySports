//
//  CYMineModel.m
//  esayou
//
//  Created by ESAY on 16/3/29.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYMineModel.h"

@implementation CYMineModel
-(id)initWithDict:(NSDictionary *)dict{
    if ([super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
    }
    return self;
}
+(id)initWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end
