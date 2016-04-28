//
//  CYDestinationViewController.m
//  esayou
//
//  Created by ESAY on 16/3/4.
//  Copyright (c) 2016年 ESAY. All rights reserved.
//

#import "CYDestinationViewController.h"
#import "CYWriteTravelNoteController.h"
#import "CYTravelTableHeaderV.h"
#import "CYWriteTableCell.h"
#import "CYWriteModel.h"
#import "CYWriteTableHeadView.h"
#import "CYTravelNoteDetailController.h"
#import "CYTypeViewController.h"

#import "CYTravelNotsModel.h"
@interface CYDestinationViewController ()<CYWriteTableHeadViewDelegate>
@property(nonatomic,strong)NSMutableArray *datasArr;
@property(nonatomic,strong)CYWriteTableHeadView *tableheadView;

@end

@implementation CYDestinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
//    [self creatData];
    [self creatUI];
    // Do any additional setup after loading the view.
}
-(void)getData{
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:@"122" forKey:@"uid"];
    [dic setValue:@"1" forKey:@"p"];
    [dic setValue:@"1" forKey:@"type"];
    [dic setValue:@"" forKey:@""];

    
    [CYHttprequestHelper GetDataWithPhpUrl:@"http://ceshi.6tennis.com/Travel/travel_list/" andParams:dic success:^(AFHTTPRequestOperation *operation, id jsonObj) {
        NSDictionary *dict = [XYString getObjectFromJsonString:operation.responseString];
        NSLog(@"%@",dict);
        NSMutableDictionary *returnDic = [dict objectForKey:@"code"];
        NSNumber *error_code = [returnDic objectForKey:@"error_code"];
        NSLog(@"%@ %@",error_code,returnDic);
        if ([error_code intValue] == 0) {
            NSMutableArray *dataArr = dict[@"item"];
            if (dataArr != nil && ![dataArr isKindOfClass:[NSNull class]] && dataArr.count != 0) {
                self.datasArr = [NSMutableArray arrayWithArray:[CYTravelNotsModel mj_objectArrayWithKeyValuesArray:dataArr]];
            }
            [self.tableView reloadData];
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
    NSArray *personImageNamesArray = @[@"icon0.jpg",
                                     @"icon1.jpg",
                                     @"icon2.jpg",
                                     @"icon3.jpg",
                                     @"icon4.jpg",
                                     ];
    
    NSArray *personNamesArray = @[@"gtz阿然啊啊啊啊啊啊啊啊啊啊啊啊啊",
                            @"琴麻岛",
                            @"桦木垒",
                            @"我叫郭德纲",
                            @"Hello Kitty"];

    NSArray *bigImageArray = @[@"pic0.jpg",
                                     @"pic1.jpg",
                                     @"pic2.jpg",
                                     @"pic3.jpg",
                                     @"pic4.jpg",
                                     @"pic5.jpg",
                                     @"pic6.jpg"                               ];
    NSArray *typeArray = @[@"足球",
                           @"篮球",
                           @"网球",
                           @"马拉松",
                           @"高尔夫"];
    
    NSArray *titleArray = @[@"英国8日经典行程",
                            @"琴麻岛",
                            @"桦木垒",
                            @"我叫郭德纲",
                            @"Hello Kitty"];
    NSArray *timeArray = @[@"2016/03/20-03/26",@"2016/03/20-03/26",@"2016/03/20-03/26",@"2016/03/20-03/26",@"2016/03/20-03/26"];
    
    NSArray *adressArray = @[@"伦敦·大本钟·伦敦眼·维斯姆斯特教堂",
                             @"唐人街·温哥华水族馆",
                             @"当你的时",
                             @"卡皮拉罗吊桥公园·斯坦利公园",
                             @"唐人街·温哥华水族馆·卡皮拉罗吊桥公园·斯坦利公园"
                             ];
    NSArray *adressImageNamesArray = @[@"icon0.jpg",
                                       @"icon1.jpg",
                                       @"icon2.jpg",
                                       @"icon3.jpg",
                                       @"icon4.jpg",
                                       ];

    
    NSArray *commentArray = @[ @"1230 浏览 / 1123 喜欢 / 1178 评论",
                             @"230 浏览 / 23 喜欢 / 578 评论",@"230 浏览 / 23 喜欢 / 578 评论",@"230 浏览 / 23 喜欢 / 578 评论",@"230 浏览 / 23 喜欢 / 578 评论"];
    
    for (int i = 0; i < 10; i++) {
        int imgRandomIndex = arc4random_uniform(5);
        int typeRandomIndex = arc4random_uniform(5);
        int timeRandomIndex = arc4random_uniform(5);
        int personImgRandomIndex = arc4random_uniform(5);
        int personNameRandomIndex = arc4random_uniform(5);
        int titleRandomIndex = arc4random_uniform(5);
        int adressImgRandomIndex = arc4random_uniform(5);
        int adressRandomIndex = arc4random_uniform(5);
        int commentRandomIndex = arc4random_uniform(5);
        
        CYWriteModel *model = [CYWriteModel new];
        model.bigImage = bigImageArray[imgRandomIndex];
        model.type = typeArray[typeRandomIndex];
        model.time = timeArray[timeRandomIndex];
        model.personImag = personImageNamesArray[personImgRandomIndex];
        model.personName = personNamesArray[personNameRandomIndex];
        model.title = titleArray[titleRandomIndex];
        model.adress = adressArray[adressRandomIndex];
        model.adressImage = adressImageNamesArray[adressImgRandomIndex];
        model.coment = commentArray[commentRandomIndex];
        [_datasArr addObject:model];
    }
}

-(void)creatUI{
    self.navBarView.hidden = YES;
    //列表
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight-50)];
    self.tableView.delegate = self;
    self.tableView.dataSource  =self;
    [self.view addSubview:self.tableView];
    
    //头部控件
    _tableheadView = [[CYWriteTableHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    //设置背景图
    _tableheadView.bagroundImageView.image = GetImage(@"pic1.jpg");
    _tableheadView.delegate = self;
    self.tableView.tableHeaderView = _tableheadView;
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _datasArr.count;
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYWriteTableCell *cell = [CYWriteTableCell cellWithTableView:tableView reuseIdentifier:@"CYWriteTableCell"];
    cell.model = self.datasArr[indexPath.section];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        CYTravelTableHeaderV *head = [[CYTravelTableHeaderV alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        head.midLab.text = @"精品游记";
        return head;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.tableView cellHeightForIndexPath:indexPath model:self.datasArr[indexPath.section] keyPath:@"model" cellClass:[CYWriteTableCell class] contentViewWidth:[self cellContentViewWith]];
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
    CYTravelNoteDetailController *detail = [[CYTravelNoteDetailController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark--写游记--
-(void)writeTravelNotsNow{
    CYWriteTravelNoteController *vc = [[CYWriteTravelNoteController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark--选择种类--
-(void)chooseType:(NSInteger)tag{
    NSLog(@"选择了：%ld球类",tag);
    CYTypeViewController *typeVc = [[CYTypeViewController alloc]init];

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
