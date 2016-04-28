//
//  CYRootViewController.m
//  esayou
//
//  Created by ESAY on 16/3/4.
//  Copyright (c) 2016年 ESAY. All rights reserved.
//

#import "CYRootViewController.h"

@interface CYRootViewController ()

@end

@implementation CYRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    self.wifiView = [[UIView alloc]initWithFrame:self.view.bounds];
    self.wifiView.backgroundColor = GetColor(lightGrayColor);
    [self.view addSubview:self.wifiView];
    
    _navBarView =[QuickControl imageViewWithFrame:CGRectMake(0, 0, kScreenWidth, 64) imageFile:nil tag:0];
    //    navBarView.alpha = 0.9f;
    _navBarView.backgroundColor = RGB(255, 255, 255);
    [self addLeftBtnWithTitle:nil imageFile:@"" selector:@selector(leftBtnClick)];
    [self.view addSubview:_navBarView];
    
    UIView *view = [QuickControl viewWithFrame:CGRectMake(0, _navBarView.height-0.5, _navBarView.width, 0.5) backgroundColor:GetColor(lightGrayColor) tag:0];
    [_navBarView addSubview:view];

    self.noWifiView = [[CYWithoutWifiView alloc]initWithFrame:CGRectMake(0, 1, kScreenWidth, kScreenHeight)];
    self.noWifiView.backgroundColor = GetColor(whiteColor);
    self.noWifiView.alpha = 0;
    self.noWifiView.delegate = self;
    [self.view addSubview:self.noWifiView];

        // Do any additional setup after loading the view.
}

-(void)leftBtnClick{
    NSLog(@"左边导航栏按钮点击");
}

- (void)addTitleViewWithTitle:(NSString *)title
{
    _titleLable =[QuickControl labelWithFrame:CGRectMake(kScreenWidth/2-110, 27, 220, 30) title:title tag:0];
    _titleLable.backgroundColor =GetColor(clearColor);
    _titleLable.textAlignment =NSTextAlignmentCenter;
    _titleLable.font =[UIFont fontWithName:@"Arial Rounded MT Bold" size:18];
    _titleLable.textColor =GetColor(redColor);
    //titleLabel.text = @"shabi";
    [_navBarView addSubview:_titleLable];
}

- (void)addLeftBtnWithTitle:(NSString *)title imageFile:(NSString *)file selector:(SEL)selector
{
    _navLeftBtn =[QuickControl imageButtonWithFrame:CGRectMake(5, 22, 40, 40) title:title imageFile:file target:self action:selector tag:0];
    [_navBarView addSubview:_navLeftBtn];
}

- (void)addRightBtnWithTitle:(NSString *)title imageFile:(NSString *)file selector:(SEL)selector
{
    _navRightBtn =[QuickControl imageButtonWithFrame:CGRectMake(kScreenWidth-49, 20, 44, 44) title:title imageFile:file target:self action:selector tag:0];
    //[navRightBtn setBackgroundColor:GetColor(redColor)];
    [_navBarView addSubview:_navRightBtn];
}

- (void)showWaiting:(BOOL)isShow
{
    if (isShow) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }else{
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }
}
- (void)showInfoView:(NSString *)info
{
    [InfoAlertView showInfo:info inView:self.view duration:1.0];
}

-(void)addHeaderRefresh{
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
