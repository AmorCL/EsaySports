//
//  CYTravelDetailViewController.m
//  esayou
//
//  Created by ESAY on 16/4/16.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYTravelDetailViewController.h"

@interface CYTravelDetailViewController ()

@end

@implementation CYTravelDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    // Do any additional setup after loading the view.
}
-(void)creatUI{
    [self addLeftBtnWithTitle:@"返回" imageFile:@"" selector:@selector(back)];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
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