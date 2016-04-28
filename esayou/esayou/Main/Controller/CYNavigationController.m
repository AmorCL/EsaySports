//
//  CYNavigationController.m
//  esayou
//
//  Created by ESAY on 16/3/3.
//  Copyright (c) 2016年 ESAY. All rights reserved.
//

#import "CYNavigationController.h"

@interface CYNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation CYNavigationController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak CYNavigationController *weakSelf = self;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }

    //    self.navigationBar.hidden = YES;
    // Do any additional setup after loading the view.
    
}

/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.navigationBarHidden = YES;

    if (self.viewControllers.count > 0) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
//        /* 设置导航栏上面的内容 */
//        // 设置左边的返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithLeftIcon:@"123.jpg" highIcon:@"" target:self action:@selector(back)];
        viewController.navigationItem.leftBarButtonItem.title = @"返回";
//
//        // 设置右边的更多按钮
//        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithLeftIcon:@"" highIcon:@"" target:self action:@selector(more)];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

//- (void)more
//{
//    [self popToRootViewControllerAnimated:YES];
//}


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
