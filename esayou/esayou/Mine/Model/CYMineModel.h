//
//  CYMineModel.h
//  esayou
//
//  Created by ESAY on 16/3/29.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYMineModel : NSObject
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *title;
+ (id)initWithDict:(NSDictionary *)dict;

@end
