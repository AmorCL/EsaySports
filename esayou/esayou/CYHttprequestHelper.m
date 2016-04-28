//
//  CYHttprequestHelper.m
//  esayou
//
//  Created by ESAY on 16/3/10.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYHttprequestHelper.h"

@implementation CYHttprequestHelper

+(void)requestData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://api.6tennis.com/Demot" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

/**
 *  登陆
 *
 */
+ (void)PostGetDataWithPhpUrl:(NSString *)path andParams:(NSMutableDictionary *)paramDic success:(mSuccessBlock)success failure:(mErrorBlock)failure{
    NSLog(@"%@",path);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    [manager POST:path parameters:paramDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"登陆成功返回的：%@",json);
        
        success(operation,json);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"登陆失败返回的：%@",error);
        failure(operation,error);
    }];
}

/**
 *  Get请求数据
 *
 */
+(void)GetDataWithPhpUrl:(NSString *)path andParams:(NSMutableDictionary *)paramDic success:(mSuccessBlock)success failure:(mErrorBlock)failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:path parameters:paramDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        success(operation,responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(operation,error);
    }];
}

/**
 *  上传文件，视频，图片
 *
 */
+(void)post:(NSString *)url typeCount:(NSInteger)typeCount andPath:(NSURL *)path orImages:(NSMutableArray *)imageDatas andParams:(NSMutableDictionary *)paramDic success:(mSuccessBlock)success failure:(mErrorBlock)failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    

    [manager POST:url parameters:paramDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (typeCount == 0) {
            NSInteger imgCount = 0;
            for (NSData *imageData in imageDatas) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyy-MM-ddHH:mm:ss:SSS";
                NSString *fileName = [NSString stringWithFormat:@"%@%@.png",[formatter stringFromDate:[NSDate date]],@(imgCount)];
                [formData appendPartWithFileData:imageData name:@"upfile[]" fileName:fileName mimeType:@"image/png"];
                imgCount++;
            }
        }else if (typeCount == 1){
            NSData *videoData = [NSData dataWithContentsOfURL:path];
            [formData appendPartWithFileData:videoData name:@"upfile" fileName:@"video1.mp4" mimeType:@"video/quicktime"];
        }
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        //接收服务器的响应信息
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //        NSLog(@"fanhui:%@",responseObject);
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];

        success(operation,obj);
        NSMutableDictionary *dic = (NSMutableDictionary *)obj;
       NSMutableDictionary *dict = dic[@"code"];
        NSLog(@"sucess:   %@  %@",str,dict[@"error_message"]);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"faile:%@",error);
        failure(operation,error);
    }];
}

@end
