//
//  CYShareHelper.h
//  esayou
//
//  Created by ESAY on 16/3/16.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMSocial.h"

#define UMeng_AppKey @"56de74cee0f55a6d980004dd"
#define UMeng_WeChat_AppId @"wx98761cf882dd24c7"
#define UMeng_WeChat_AppSecret @"5797cfa9f5b827ac8889adc8b3e0a9c1"
#define UMeng_WeChat_Url @"http://www.umeng.com/social"
#define UMeng_QQ_AppId @"1105083886"
#define UMeng_QQ_AppSecret @"M3G0ROmf39ZSqsMd"
#define UMeng_QQ_Url @"http://www.umeng.com/social"

@interface CYShareHelper : NSObject

//appdelegate里设置友盟分享
+(void)setUpUMeng;
//分享列表加入微信及微信朋友圈
+(void)setUpWeChatToUMeng;
//分享列表加入QQ及QQZone
+(void)setUpQQToUMeng;


+(void)share;
@end
