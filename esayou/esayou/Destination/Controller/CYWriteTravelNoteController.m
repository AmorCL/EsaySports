//
//  CYWriteTravelNoteController.m
//  esayou
//
//  Created by ESAY on 16/3/15.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYWriteTravelNoteController.h"
#import "CYWriteHeadView.h"
@interface CYWriteTravelNoteController ()

@end

@implementation CYWriteTravelNoteController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRightNavButton];
    [self addtableViewHeader];
    
        // Do any additional setup after loading the view.
}

//添加导航栏右边的地址
-(void)addRightNavButton{
    self.navigationItem.title = @"发帖";
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem = item;
    item.tintColor = [UIColor redColor];
}
-(void)addtableViewHeader{
    CYWriteHeadView *headV = [[CYWriteHeadView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 60)];
    headV.backgroundColor = GetColor(lightGrayColor);
    [self.view addSubview:headV];
}
#pragma mark --发帖子--
-(void)send{
    NSLog(@"帖子发布");
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
    
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
