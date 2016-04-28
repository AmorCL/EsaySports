//
//  CYHttprequestHelper.h
//  esayou
//
//  Created by ESAY on 16/3/10.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import"AFNetworking.h"
//回调 成功的方法
typedef void (^mSuccessBlock)(AFHTTPRequestOperation *operation,id jsonObj);
typedef void (^mErrorBlock)(AFHTTPRequestOperation *operation,NSError *error);

@interface CYHttprequestHelper : NSObject
+(void)requestData;

//POST请求
+ (void)PostGetDataWithPhpUrl:(NSString *)path andParams:(NSMutableDictionary *)paramDic success:(mSuccessBlock)success failure:(mErrorBlock)failure;
+(void)post:(NSString *)url typeCount:(NSInteger)typeCount andPath:(NSURL *)path orImages:(NSMutableArray *)imageDatas andParams:(NSMutableDictionary *)paramDic success:(mSuccessBlock)success failure:(mErrorBlock)failure;
//Get请求数据
+(void)GetDataWithPhpUrl:(NSString *)path andParams:(NSMutableDictionary *)paramDic success:(mSuccessBlock)success failure:(mErrorBlock)failure;
@end
