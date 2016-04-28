//
//  CYTravelTypeViewController.m
//  esayou
//
//  Created by ESAY on 16/4/16.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYTravelTypeViewController.h"
#import "CYTravelDetailViewController.h"
#import "CYTravelModel.h"
#import "CYTravelWoldTableViewCell.h"
@interface CYTravelTypeViewController ()
@property(nonatomic,strong)NSMutableArray *datasArr;

@end

@implementation CYTravelTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatData];
    [self creatUI];
    // Do any additional setup after loading the view.
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
    [self addLeftBtnWithTitle:@"返回" imageFile:@"" selector:@selector(back)];
    [self addTitleViewWithTitle:self.urlString];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navBarView.height, kScreenWidth, kScreenHeight-self.navBarView.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource  =self;
    [self.view addSubview:self.tableView];

    
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

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
    view.backgroundColor = GetColor(lightGrayColor);
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    CYTravelDetailViewController *detail = [[CYTravelDetailViewController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
}



-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
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
