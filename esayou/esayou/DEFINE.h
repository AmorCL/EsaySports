//
//  DEFINE.h
//  esayou
//
//  Created by ESAY on 16/3/4.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#ifndef DEFINE_h
#define DEFINE_h

//屏幕宽高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
//颜色
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBAlpha(r, g, b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define GetColor(color) [UIColor color]
#define GetImage(imageName)  [UIImage imageNamed:imageName]
#define GetFont(x) [UIFont systemFontOfSize:x]
#endif /* DEFINE_h */
//登陆和注册 表格高度
#define LOGIN_REGIST_HEIGHT 50


//1.屏幕尺寸
#define screenRect [[UIScreen mainScreen] bounds]
#define IPHONE4  (([UIScreen mainScreen].bounds.size.width == 320) && ([UIScreen mainScreen].bounds.size.height == 480))
#define IPHONE5  (([UIScreen mainScreen].bounds.size.width == 320) && ([UIScreen mainScreen].bounds.size.height == 568))
#define IPHONE6  ([UIScreen mainScreen].bounds.size.width == 375) && ([UIScreen mainScreen].bounds.size.height == 667)
#define IPHONE6P  ([UIScreen mainScreen].bounds.size.width == 414) && ([UIScreen mainScreen].bounds.size.height == 736)

#define PLUS_HEIGHT(height) kScreenWidth * height / 375

#define TimeLineCellHighlightedColor [UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0]

#define return_code @"ceode"
#define return_error_code @"error_code"
#define return_error_nessage @"error_message"
#define CYNotificationCenter [NSNotificationCenter defaultCenter]

//接口

//登录注册
#define ESAYOU_LOGIN_URL @"http://ceshi.6tennis.com/User/user_login/"
#define ESAYOU_REGISTER_URL @"http://ceshi.6tennis.com/User/user_register/"
#define ESAYOU_SMS_URL @"http://ceshi.6tennis.com/User/user_sms/"
#define ESAYOU_CHANGEPASSWD_URL @"http://ceshi.6tennis.com/User/user_cpwd/"

#define ESAYOU_HOME_LIVE_ADD_URL @"http://ceshi.6tennis.com/Live/live_add/"
#define ESAYOU_HOME_LIVE_LIST_URL @"http://ceshi.6tennis.com/Live/live_list/"
#define ESAYOU_NOTE_LIST_URL @"http://ceshi.6tennis.com/Travel/travel_list/"
#define ESAYOU_TRAVEL_LIST_URL @"http://ceshi.6tennis.com/Travel/travel_list/"
