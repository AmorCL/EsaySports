//
//  CYMineViewController.m
//  esayou
//
//  Created by ESAY on 16/3/4.
//  Copyright (c) 2016年 ESAY. All rights reserved.
//

#import "CYMineViewController.h"
#import "CYMineTableCell.h"
#import "CYMineModel.h"
#import "CYMineHeaderView.h"
#import "CYLoginViewController.h"
#import "CYMyPersonalViewController.h"
#import "CYMySettingViewController.h"
#import "CYMyMesageViewController.h"
#import "CYMyFocusViewController.h"
#import "CYMyFansViewController.h"
@interface CYMineViewController ()<UITableViewDelegate,UITableViewDataSource,CYMineHeaderViewDelegate>
@property (nonatomic, strong) NSMutableArray *modelsArray;
@property(nonatomic,strong)CYMineHeaderView *tableHeader;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CYMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatData];
    [self creatTableView];
    [self creatTableHeader];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    //设置导航栏为透明
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
////    [UIApplication sharedApplication].delegate = self;
//    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"]) {
//        dispatch_async(dispatch_get_main_queue(), ^{
////            [self login];
//        });
//    }else{
//        
//    }
}
-(void)login{
    CYLoginViewController *loginVc = [[CYLoginViewController alloc]init];
    loginVc.titleString = @"登录";
    [self.navigationController pushViewController:loginVc animated:YES];
}
-(void)creatData{
    if (!_modelsArray) {
        _modelsArray = [NSMutableArray new];
            _modelsArray = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"MineList.plist" ofType:nil]];
        _dataArray = [NSMutableArray new];
        for (NSArray *array in _modelsArray) {
            NSMutableArray *temparray = [NSMutableArray new];
            for (NSMutableDictionary *dic in array) {
                CYMineModel *model = [CYMineModel initWithDict:dic];
                [temparray addObject:model];
            }
            [_dataArray addObject:temparray];
        }
    }
    
//    [self creatArr:2];
//    [self creatArr:3];
//    [self creatArr:1];
}
-(void)creatArr:(int)count{
    NSArray *iconImageNamesArray = @[@"v.jpg",
                                     @"123.jpg",
                                     @"v.jpg",
                                     @"123.jpg",
                                     @"v.jpg",
                                     ];
    NSArray *namesArray = @[@"GSD_iOS",
                            @"风口上的猪",
                            @"当今世界网名都不好起了",
                            @"我叫郭德纲",
                            @"Hello Kitty"];
    NSMutableArray *array = [NSMutableArray new];
    for (int i = 0; i < count; i++) {
        int iconRandomIndex = arc4random_uniform(5);
        int nameRandomIndex = arc4random_uniform(5);
        
        CYMineModel *model = [CYMineModel new];
        model.pic = iconImageNamesArray[iconRandomIndex];
        model.title = namesArray[nameRandomIndex];
        [array addObject:model];
    }
    [self.modelsArray addObject:array];


}
-(void)creatTableView{
    self.tableView = [UITableView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = GetColor(redColor);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:self.tableView
     ];
    
    self.tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,50);
}
-(void)creatTableHeader{
    self.tableHeader = [[CYMineHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    self.tableHeader.backgroundColor = RGB(137, 177, 232);
    self.tableHeader.delegate = self;
    self.tableView.tableHeaderView = self.tableHeader;
}
#pragma mark--CYMineHeaderViewDelegate--
//消息
-(void)mesageBtned{
    CYMyMesageViewController *mesage = [[CYMyMesageViewController alloc]init];
    [self.navigationController pushViewController:mesage animated:YES];
}
//设置
-(void)settingBtned{
    CYMySettingViewController *setting = [[CYMySettingViewController alloc]init];
    [self.navigationController pushViewController:setting animated:YES];
}
//头像
-(void)headImageBtned{
    
}
//关注
-(void)myFocusBtned{
    CYMyFocusViewController *focus = [[CYMyFocusViewController alloc]init];
    [self.navigationController pushViewController:focus animated:YES];
}
//粉丝
-(void)myFansBtned{
    CYMyFansViewController *fans = [[CYMyFansViewController alloc]init];
    [self.navigationController pushViewController:fans animated:YES];
}
//个人主页
-(void)myPersonalBtned{
    CYMyPersonalViewController *person = [[CYMyPersonalViewController alloc]init];
    [self.navigationController pushViewController:person animated:YES];
}
-(void)loginButton{
    NSLog(@"登陆");
    CYLoginViewController *loginVc = [[CYLoginViewController alloc]init];
    [self.navigationController pushViewController:loginVc animated:YES];
}


#pragma mark--UITableViewDelegate,UITableViewDataSource--
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu",(unsigned long)[[self.modelsArray objectAtIndex:section] count]);
    return [[self.dataArray objectAtIndex:section] count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  
    NSLog(@"%lu",(unsigned long)self.modelsArray.count);
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   CYMineModel *model = [[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    CYMineTableCell *cell = [CYMineTableCell cellWithTableView:tableView reuseIdentifier:@"Mindetable"];
    [cell fillDataWith:model];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
//    CYMineModel *model = [[self.modelsArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
//    
//    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[CYMineTableCell class] contentViewWidth:[self cellContentViewWith]];
}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.000000000001;
    }
    return 20;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    view.backgroundColor = GetColor(lightGrayColor);
    return view;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self login];
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
