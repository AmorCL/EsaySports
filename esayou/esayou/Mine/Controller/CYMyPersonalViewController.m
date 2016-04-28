//
//  CYMyPersonalViewController.m
//  esayou
//
//  Created by ESAY on 16/4/13.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYMyPersonalViewController.h"
#import "CYMinePersonalHeadView.h"
@interface CYMyPersonalViewController ()
@property(nonatomic,strong)CYMinePersonalHeadView *personalHeadView;

@end

@implementation CYMyPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarView.backgroundColor = GetColor(clearColor);
    self.view.backgroundColor = GetColor(lightGrayColor);
    [self creatUI];
    // Do any additional setup after loading the view.
}
-(void)creatUI{
    self.personalHeadView = [[CYMinePersonalHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *strId = @"strId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strId];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
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
