//
//  CYShareHelper.m
//  esayou
//
//  Created by ESAY on 16/3/16.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYShareHelper.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"

@implementation CYShareHelper
+(void)setUpUMeng{
    [UMSocialData setAppKey:UMeng_AppKey];
}
+(void)setUpWeChatToUMeng{
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:UMeng_WeChat_AppId appSecret:UMeng_WeChat_AppSecret url:UMeng_WeChat_Url];
}
+(void)setUpQQToUMeng{
    //设置QQ AppId appKey
    [UMSocialQQHandler setQQWithAppId:UMeng_QQ_AppId appKey:UMeng_QQ_AppSecret url:UMeng_QQ_Url];
}
+(void)share{
    
}

@end
