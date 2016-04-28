//
//  CYTabBarController.m
//  esayou
//
//  Created by ESAY on 16/3/3.
//  Copyright (c) 2016年 ESAY. All rights reserved.
//

#import "CYTabBarController.h"
#import "CYHomeViewController.h"
#import "CYDestinationViewController.h"
#import "CYCommunityViewController.h"
#import "CYMineViewController.h"
#import "CYNavigationController.h"

#import "CYTabbar.h"
@interface CYTabBarController ()<CYTabBarDelegate>
@property(nonatomic,strong)CYTabbar *cyTabbar;

@end

@implementation CYTabBarController
- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    //2.添加子控制器
    [self addChildVc];
}


-(void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    
    for (UIView *child in self.tabBar.subviews) {
        
        if ([child isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            [child removeFromSuperview];
            
        }
        
    }
    
}

- (void)viewWillAppear:(BOOL)animated

{
    
    // 删除系统自动生成的UITabBarButton
    
    for (UIView *child in self.tabBar.subviews) {
        
        if ([child isKindOfClass:[UIControl class]]) {
            
            [child removeFromSuperview];
            
        }
        
    }
    [self setUpTabbar];
    [super viewWillAppear:animated];
    
}

-(void)setUpTabbar{
    if (!_cyTabbar) {
        _cyTabbar = [[CYTabbar alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        _cyTabbar.controllers = self.childViewControllers;
        _cyTabbar.delegate = self;
        [self.tabBar addSubview:_cyTabbar];
        
    }
}
#pragma mark 添加子控制器
-(void)addChildVc{
    
    //1.添加首页控制器
    CYHomeViewController  *home=[[CYHomeViewController alloc]init];
    [self addChildViewController:home title:@"易直播" image:@"" selectedImage:@""];
    //2.目的地
    CYDestinationViewController *destination=[[CYDestinationViewController alloc]init];
    [self addChildViewController:destination title:@"赛游记" image:@"" selectedImage:@""];
    //3.社区
    CYCommunityViewController *community=[[CYCommunityViewController alloc]init];
    [self addChildViewController:community title:@"游世界" image:@"" selectedImage:@""];
    //4.我的
    CYMineViewController *mine=[[CYMineViewController alloc]init];
    [self addChildViewController:mine title:@"我的" image:@"" selectedImage:@""];
    
}
#pragma mark 添加子控制器的方法

-(void)addChildViewController:(UIViewController *)childVc title:(NSString*)title image:(NSString*)image selectedImage:(NSString*)selectedImage
{
    childVc.title=title;
    childVc.tabBarItem.image=[UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage=[UIImage imageNamed:selectedImage];
    
    CYNavigationController *nav=[[CYNavigationController alloc]initWithRootViewController:childVc];
    nav.navigationBarHidden = YES;
    [self addChildViewController:nav];
}
- (void)tabBarDidSelected:(NSInteger)index
{
    self.selectedIndex = index;
    if (self.selectedIndex == 0) {
        NSLog(@"首页");
//        [_firstVc.pageMenu moveToPage:0];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
