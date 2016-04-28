//
//  CYCommunityViewController.m
//  esayou
//
//  Created by ESAY on 16/3/4.
//  Copyright (c) 2016年 ESAY. All rights reserved.
//

#import "CYCommunityViewController.h"
#import "CYTravelWoldTableViewCell.h"
#import "CYTravelModel.h"
#import "CYTravelHeadView.h"
#import "CYTravelTableHeaderV.h"
#import "CYTravelTypeViewController.h"
#import "CYTravelDetailViewController.h"
#import "PictureCycleModel.h"


@interface CYCommunityViewController ()<CYTravelHeadViewDelegate>
@property(nonatomic,strong)NSMutableArray *datasArr;
@property(nonatomic,strong)CYTravelHeadView *headerView;

@end

@implementation CYCommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    [self creatData];
    [self creatUI];
    // Do any additional setup after loading the view.
}
//请求数据
-(void)getData{
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:@"122" forKey:@"uid"];
    [dic setValue:@"1" forKey:@"p"];
    [dic setValue:@"1" forKey:@"type"];
    [dic setValue:@"" forKey:@""];
    
    [CYHttprequestHelper GetDataWithPhpUrl:@"http://ceshi.6tennis.com/World/World_list/" andParams:dic success:^(AFHTTPRequestOperation *operation, id jsonObj) {
        NSDictionary *dict = [XYString getObjectFromJsonString:operation.responseString];
        NSLog(@"%@",dict);
        NSMutableDictionary *returnDic = [dict objectForKey:@"code"];
        NSNumber *error_code = [returnDic objectForKey:@"error_code"];
        NSLog(@"%@ %@",error_code,returnDic);
        if ([error_code intValue] == 0) {
            
            
        }else{
            [self showInfoView:returnDic[return_error_nessage]];
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
-(void)creatData{
    if (!_datasArr) {
        _datasArr = [NSMutableArray new];
    }
    NSArray *iconImageNamesArray = @[@"pic0.jpg",
                                     @"pic1.jpg",
                                     @"pic2.jpg",
                                     @"pic3.jpg",
                                     @"pic4.jpg",
                                     @"pic5.jpg",
                                     @"pic6.jpg"                               ];
    
    NSArray *titleArray = @[@"英国8日经典行程",
                            @"琴麻岛",
                            @"桦木垒",
                            @"我叫郭德纲",
                            @"Hello Kitty"];
    NSArray *timeArray = @[@"2016/03/20-03/26",@"2016/03/20-03/26",@"2016/03/20-03/26",@"2016/03/20-03/26",@"2016/03/20-03/26"];
    
    NSArray *adressArray = @[@"伦敦·大本钟·伦敦眼·维斯姆斯特教堂",
                           @"唐人街·温哥华水族馆·卡皮拉罗吊桥公园·斯坦利公园",
                           @"当你的 app 没有提供 3x 的 LaunchImage 时",
                           @"唐人街·温哥华水族馆·卡皮拉罗吊桥公园·斯坦利公园",
                           @"唐人街·温哥华水族馆·卡皮拉罗吊桥公园·斯坦利公园"
                           ];
    
    NSArray *priceArray = @[ @"¥3800起",
                                     @"¥13800起",
                                     @"¥23800起",
                                     @"¥33800起",
                                     @"¥43800起",
                                     @"¥13800起",
                                     @"¥1233800起"];
    
    for (int i = 0; i < 10; i++) {
        int imgRandomIndex = arc4random_uniform(5);
        int titleRandomIndex = arc4random_uniform(5);
        int adressRandomIndex = arc4random_uniform(5);
        int timeRandomIndex = arc4random_uniform(5);
        int priceRandomIndex = arc4random_uniform(5);
        
        CYTravelModel *model = [CYTravelModel new];
        model.bigImageView = iconImageNamesArray[imgRandomIndex];
        model.title = titleArray[titleRandomIndex];
        model.adress = adressArray[adressRandomIndex];
        model.time = timeArray[timeRandomIndex];
        model.price = priceArray[priceRandomIndex];

        [_datasArr addObject:model];
    }
    

}

-(void)creatUI{
    self.navBarView.hidden = YES;
    NSLog(@"%@",self.datasArr);
//    [self addTitleViewWithTitle:@"游世界"];
    //列表
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight-50)];
    self.tableView.delegate = self;
    self.tableView.dataSource  =self;
    [self.view addSubview:self.tableView];
    
    //头部控件
    self.headerView = [[CYTravelHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    self.headerView.delegate = self;
    self.headerView.backgroundColor = GetColor(whiteColor);
    self.tableView.tableHeaderView = self.headerView;
    
    self.headerView.adsCycleView.selectedPictureBlock = ^(PictureCycleModel *model){
        NSLog(@"轮播点击");
    };
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _datasArr.count;
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTravelWoldTableViewCell *cell = [CYTravelWoldTableViewCell cellWithTableView:tableView reuseIdentifier:@"CYtravelCell"];
    cell.model = self.datasArr[indexPath.section];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%f",[self.tableView cellHeightForIndexPath:indexPath model:self.datasArr[indexPath.section] keyPath:@"model" cellClass:[CYTravelWoldTableViewCell class] contentViewWidth:[self cellContentViewWith]]);
//    return 200;
    return [self.tableView cellHeightForIndexPath:indexPath model:self.datasArr[indexPath.section] keyPath:@"model" cellClass:[CYTravelWoldTableViewCell class] contentViewWidth:[self cellContentViewWith]];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        CYTravelTableHeaderV *head = [[CYTravelTableHeaderV alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        head.midLab.text = @"精品路线";
        head.backgroundColor = RGB(233, 238, 238);
        return head;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
    view.backgroundColor = GetColor(lightGrayColor);
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 30;
    }
    return 0.0000000000001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    CYTravelDetailViewController *detail = [[CYTravelDetailViewController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark--搜索--
-(void)searchBegain{
    NSLog(@"点击搜索");
}
#pragma mark--定制--
-(void)startMyOrder{
    NSLog(@"开始定制");
}
#pragma mark--选择球类--
-(void)chooseTypeOfBall:(NSInteger)tag{
    CYTravelTypeViewController *typeVc = [[CYTravelTypeViewController alloc]init];
    if (tag == 0) {
        typeVc.urlString = @"足球";
    }else if (tag == 1){
        typeVc.urlString = @"篮球";
        
    }else if (tag == 2){
        typeVc.urlString = @"网球";
        
    }else if (tag == 3){
        typeVc.urlString = @"马拉松";
        
    }else if (tag == 4){
        typeVc.urlString = @"游学";
        
    }else if (tag == 5){
        typeVc.urlString = @"其他";
        
    }
    [self.navigationController pushViewController:typeVc animated:YES];
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
