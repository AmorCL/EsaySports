//
//  AppDelegate.m
//  esayou
//
//  Created by ESAY on 16/3/3.
//  Copyright (c) 2016年 ESAY. All rights reserved.
//

#import "AppDelegate.h"
#import "CYTabBarController.h"
#import "CYAdsViewController.h"
#import "UMSocial.h"
#import "MobClick.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    

    // Override point for customization after application launch.
    [self getUMeng];
    //设置根视图
    [self setRootWindow];
    //加载广告页面
    [self launch];
    return YES;
}
-(void)setRootWindow{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    CYTabBarController *tabbarController = [[CYTabBarController alloc]init];
    self.window.rootViewController = tabbarController;
    [self.window makeKeyAndVisible];//设置主窗口 并可见
}
-(void)launch{
    CYAdsViewController *adsVc = [[CYAdsViewController alloc]init];
    [self.window addSubview:adsVc.view];
}




#pragma mark---集成友盟分享登陆等功能 ---
-(void)getUMeng{
    [CYShareHelper setUpUMeng];
    [CYShareHelper setUpWeChatToUMeng];
    [CYShareHelper setUpQQToUMeng];
    
    //    //友盟统计
    //    [MobClick startWithAppkey:@"56de74cee0f55a6d980004dd" reportPolicy:BATCH   channelId:@""];

}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UMSocialSnsService  applicationDidBecomeActive];
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
