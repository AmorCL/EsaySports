//
//  CYHomeBaseViewController.m
//  esayou
//
//  Created by ESAY on 16/4/27.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYHomeBaseViewController.h"
#import "PictureCycleView.h"
#import "CYLiveBtnView.h"
#import "XYString.h"
#import "CYHomeLiveListModel.h"
#import "CYTravelTableHeaderV.h"

#import "CYWantLiveViewController.h"
#import "CYHomeBaseImageTableCell.h"
#import "CYHomeBaseVedioTableCell.h"
#import "WMPlayer.h"
#import "GGPlayView.h"
#define Live_backView_height 52
#define Live_livebtn_width 42

@interface CYHomeBaseViewController ()<CYLiveBtnViewDelagete>

@property(nonatomic ,strong) NSMutableArray *listArry;
@property (nonatomic, strong) NSMutableArray *modelsArray;
@property(nonatomic,strong)PictureCycleView *pictureCycleView;
@property(nonatomic,strong)CYLiveBtnView *seeLive;
@property(nonatomic,strong)CYLiveBtnView *liveNow;
@property(nonatomic,assign)CGFloat oldOffset;
@property (nonatomic, assign) BOOL hidden;
@property (nonatomic, assign) BOOL scrollUporDown;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSIndexPath *currentIndexPath;
@property(nonatomic,retain)CYHomeBaseImageTableCell *currentCell;
@property(nonatomic,strong)WMPlayer *wmPlayer;


@property (nonatomic , retain) NSMutableArray *pictureArray;//图片数据数组

@property (nonatomic, strong) MJRefreshComponent *myRefreshView;

@property(nonatomic,assign)CATransform3D myTransform;
@property (nonatomic ,strong)AVPlayer *player;
@property (nonatomic ,strong) AVPlayerItem *playerItem;
@property (nonatomic ,strong) GGPlayView *playerView;


@end

@implementation CYHomeBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [self getData];

    [self creatTableView];

    // Do any additional setup after loading the view.
}

-(void)getData{
    _page = 1;
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:@"122" forKey:@"user_id"];
    //    [dic setValue:@"" forKey:@"type"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)_page] forKey:@"p"];
    //    [dic setValue:@"" forKey:@""];
    //    [dic setValue:@"" forKey:@""];
    NSLog(@"%@",dic);
    [self showWaiting:YES];
    [CYHttprequestHelper GetDataWithPhpUrl:ESAYOU_HOME_LIVE_LIST_URL andParams:dic success:^(AFHTTPRequestOperation *operation, id jsonObj) {
//        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonObj options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"成功");
        [self showWaiting:NO];
        if (_currentIndexPath.row>_modelsArray.count) {
            [self releaseWMPlayer];
        }

        [self doneWithView:self.myRefreshView];
        NSDictionary *dict = [XYString getObjectFromJsonString:operation.responseString];
        NSLog(@"responce:%@  %@",dict,dic);
        //
        //        NSString *key = [dict.keyEnumerator nextObject];//.取键值
        //        NSArray *temArray = dict[key];
        
        //        // 数组>>model数组
        //        NSMutableArray *arrayM = [NSMutableArray arrayWithArray:[CYLiveListModel mj_objectArrayWithKeyValuesArray:temArray]];
        //        NSLog(@"arr:%@",arrayM);
        
        NSMutableDictionary *returnDic = [dict objectForKey:@"code"];
        NSNumber *error_code = [returnDic objectForKey:@"error_code"];
        NSLog(@"%@ %@",error_code,returnDic);
        if ([error_code intValue] == 0) {
            NSMutableDictionary *dataDic = dict[@"item"];
            NSMutableArray *dataArray = dataDic[@"livelist"];
            NSMutableArray *adsArray = dataDic[@"scroll"];
            //列表数据
            if (dataArray != nil && ![dataArray isKindOfClass:[NSNull class]] && dataArray.count != 0) {
                // 数组>>model数组
                NSMutableArray *arrayM = [NSMutableArray arrayWithArray:[CYHomeLiveListModel mj_objectArrayWithKeyValuesArray:dataArray]];
                
                CYHomeLiveListModel *model = arrayM[0];
                NSLog(@"arr:%@",model.img_path);
                self.modelsArray = arrayM;
                //                NSLog(@"%@",dataArray);
            }
            //轮播数据
            if (adsArray != nil && ![adsArray isKindOfClass:[NSNull class]] && adsArray.count != 0) {
                // 数组>>model数组
                NSMutableArray *arrayM = [NSMutableArray arrayWithArray:[ImagePath mj_objectArrayWithKeyValuesArray:adsArray]];
                ImagePath *model = arrayM[0];
                NSLog(@"arr:%@",model.id);
                //                NSLog(@"%@",adsArray);
                self.pictureCycleView.dataArray = arrayM;
            }
            
            //..下拉刷新
            if (self.myRefreshView == self.tableView.mj_header) {
                //                self.listArry = arrayM;
                self.tableView.mj_footer.hidden = self.listArry.count==0?YES:NO;
                
            }else if(self.myRefreshView == self.tableView.mj_footer){
                //                [self.listArry addObjectsFromArray:arrayM];
            }
            
        }else{
            [self showInfoView:returnDic[return_error_nessage]];
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败");
        [self showWaiting:NO];
        [self showInfoView:@"网络加载失败，请检查网络后重试"];
        
    }];
    
}


-(void)creatTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.userInteractionEnabled = YES;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.bounces = YES;
    self.tableView.backgroundColor = GetColor(redColor);
    __weak typeof(self) weakSelf = self;
    //..下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.myRefreshView = weakSelf.tableView.mj_header;
        weakSelf.page = 0;
        [self getData];
    }];
    
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    
    //..上拉刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.myRefreshView = weakSelf.tableView.mj_footer;
        weakSelf.page = weakSelf.page + 10;
    }];
    
    self.tableView.mj_footer.hidden = YES;

    
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 50, 0));
    
    _oldOffset =  self.tableView.contentOffset.y;
    [self.view addSubview:self.tableView];
    
    
    //初始化图片轮播视图
    
    _pictureCycleView = [[PictureCycleView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), CGRectGetWidth(self.tableView.frame) / 7 * 4)];
    _pictureCycleView.backgroundColor = GetColor(lightGrayColor);
    
    _pictureCycleView.timeInterval = 3.0f;
    
    _pictureCycleView.isPicturePlay = YES;
    
    _pictureCycleView.selectedPictureBlock = ^(PictureCycleModel *model){
        
        //跳转相应的详情页面
        
        //        self.detailsBlock(model.pid , nil);
        
    };
    
    self.tableView.tableHeaderView = self.pictureCycleView;
    //为图片轮播视图添加数据数组
    
    //    self.pictureCycleView.dataArray = self.pictureArray;
    
    //发送通知 传递轮播图数据
    
//    NSDictionary * dic = @{@"pictureArray":self.pictureArray};
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"PictureDataArray" object:self userInfo:dic];
//    NSLog(@"%f",self.tableView.tableHeaderView.centerY);
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, Live_backView_height)];
    backView.backgroundColor = GetColor(whiteColor);
    backView.alpha = 0.7;
    [self.view addSubview:backView];
    
    _seeLive = [[CYLiveBtnView alloc]initWithFrame:CGRectMake(80,5, Live_livebtn_width+50, Live_livebtn_width)];
    //    _seeLive.backgroundColor = GetColor(redColor);
    self.seeLive.lable.text = @"看直播";
    self.seeLive.lable.textColor = RGB(0, 0, 0);
    _seeLive.delegate = self;
    _seeLive.tag = 100;
    self.seeLive.imageView.image = GetImage(@"live_btn_watchinglive");
    [backView addSubview:_seeLive];
    
    _liveNow = [[CYLiveBtnView alloc]initWithFrame:CGRectMake(backView.width-80-Live_livebtn_width-50,5, Live_livebtn_width+50, Live_livebtn_width)];
    self.liveNow.lable.text = @"我要播";
    self.liveNow.lable.textColor = RGB(0, 0, 0);
    _liveNow.delegate =self;
    _liveNow.tag = 101;
    self.liveNow.imageView.image = GetImage(@"live_btn_i-want-to-play-");
    [backView addSubview:_liveNow];
    _page = 1;
}


#pragma mark --UITableViewDelegate--
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.modelsArray.count;
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYHomeLiveListModel *model = self.modelsArray[indexPath.section];
    NSLog(@"length:%lu",(unsigned long)[model.img_path[0] length]);
    
    CYHomeBaseImageTableCell *cell = [CYHomeBaseImageTableCell cellWithTableView:tableView reuseIdentifier:@"ImageCell"];
    cell.model = model;
    cell.playBtn.hidden = YES;
    cell.indexPath = indexPath;
    __weak typeof(self) weakSelf = self;
    if (!cell.moreButtonClickedBlock) {
        [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
            model.isOpening = !model.isOpening;
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }

    if([model.img_path[0] length] == 0){
        cell.playBtn.hidden = NO;
        cell.playButtonClickedBlock = ^(NSIndexPath *indexPath){
            NSLog(@"播放");
        cell.playBtn.tag = indexPath.section;
//            _playerView=[[GGPlayView alloc]initWithFrame:cell.bigImgView.frame];
//            _myTransform = _playerView.layer.transform;
//            [cell addSubview:_playerView];
//            [self playVideo:model.video_path];
        [self startPlayVideo:cell.playBtn];
    };
    }
    if (_wmPlayer&&_wmPlayer.superview) {
        if (indexPath==_currentIndexPath) {
            [cell.playBtn.superview sendSubviewToBack:cell.playBtn];
        }else{
            [cell.playBtn.superview bringSubviewToFront:cell.playBtn];
        }
        NSArray *indexpaths = [tableView indexPathsForVisibleRows];
        if (![indexpaths containsObject:_currentIndexPath]) {//复用
            
            if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:_wmPlayer]) {
                _wmPlayer.hidden = NO;
                
            }else{
                _wmPlayer.hidden = YES;
                [cell.playBtn.superview bringSubviewToFront:cell.playBtn];
            }
        }else{
            if ([cell.bigImgView.subviews containsObject:_wmPlayer]) {
                [cell.bigImgView addSubview:_wmPlayer];
                
                [_wmPlayer.player play];
                _wmPlayer.playOrPauseBtn.selected = NO;
                _wmPlayer.hidden = NO;
            }
            
        }
    }

    
//    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];

    return cell;
}
-(void)reloadTableViewDataAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark -添加播放器
- (void)createBasicConfig{
    _playerView=[[GGPlayView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenWidth*9/16)];
    _myTransform = _playerView.layer.transform;
    [self.view addSubview:_playerView];
}

#pragma mark -调入播放网址
- (void)playVideo:(NSString *)url{
    NSMutableString * filePath = [[NSMutableString alloc]initWithString:url];
    NSLog(@"%@",url);
    NSString *str = [filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *videoUrl = [NSURL URLWithString: str ];
    
    self.playerItem = [AVPlayerItem playerItemWithURL:videoUrl];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerView.player = _player;
    [self.playerView.player play];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.tableView cellHeightForIndexPath:indexPath model:self.modelsArray[indexPath.section] keyPath:@"model" cellClass:[CYHomeBaseImageTableCell class] contentViewWidth:[self cellContentViewWith]];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
    CYTravelTableHeaderV *headView = [[CYTravelTableHeaderV alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    headView.backgroundColor = GetColor(whiteColor);
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, headView.height-1, headView.width, 1)];
    lineView.backgroundColor = GetColor(lightGrayColor);
    headView.midLab.text = @"最热播";
    [headView addSubview:lineView];
    return headView;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
    return 40;
    }
    return 0.00000000001;
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
    
}



-(void)startPlayVideo:(UIButton *)sender{
    _currentIndexPath = [NSIndexPath indexPathForRow:0 inSection:sender.tag];
    NSLog(@"currentIndexPath.row = %ld",_currentIndexPath.row);
    if ([UIDevice currentDevice].systemVersion.floatValue>=8||[UIDevice currentDevice].systemVersion.floatValue<7) {
        self.currentCell = (CYHomeBaseImageTableCell *)sender.superview.superview;
        
    }else{//ios7系统 UITableViewCell上多了一个层级UITableViewCellScrollView
        self.currentCell = (CYHomeBaseImageTableCell *)sender.superview.superview.subviews;
        
    }
    CYHomeLiveListModel *model = [_modelsArray objectAtIndex:sender.tag];
    //    isSmallScreen = NO;
    
    if (_wmPlayer) {
        [_wmPlayer removeFromSuperview];
        [_wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
        [_wmPlayer setVideoURLStr:model.video_path];
        [_wmPlayer.player play];
        
    }else{
        _wmPlayer = [[WMPlayer alloc]initWithFrame:self.currentCell.bigImgView.bounds videoURLStr:model.video_path];
        [_wmPlayer.player play];
        
    }
    [self.currentCell.bigImgView addSubview:_wmPlayer];
    [self.currentCell.bigImgView bringSubviewToFront:_wmPlayer];
    [self.currentCell.playBtn.superview sendSubviewToBack:self.currentCell.playBtn];
    [self.tableView reloadData];
}
-(void)videoDidFinished:(NSNotification *)notice{
    CYHomeBaseImageTableCell *currentCell = (CYHomeBaseImageTableCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_currentIndexPath.row]];
    [currentCell.playBtn.superview bringSubviewToFront:currentCell.playBtn];
    [_wmPlayer removeFromSuperview];
    
}

#pragma  mark --看直播,我要播--
-(void)liveBtned:(NSInteger)tag{
    if (tag == 100) {
        NSLog(@"看直播");
        [self getData];
        [[SDImageCache sharedImageCache] clearMemory];
        
    }else{
        NSLog(@"我要播");
        CYWantLiveViewController *wantVc = [[CYWantLiveViewController alloc]init];
        wantVc.PhotoResult = ^(){
            [self.myRefreshView beginRefreshing];
        };
        [self.navigationController pushViewController:wantVc animated:YES];
    }
}

#pragma mark scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView ==self.tableView){
        if (_wmPlayer==nil) {
            return;
        }
        
        if (_wmPlayer.superview) {
            CGRect rectInTableView = [self.tableView rectForRowAtIndexPath:_currentIndexPath];
            CGRect rectInSuperview = [self.tableView convertRect:rectInTableView toView:[self.tableView superview]];
            
            NSLog(@"rectInSuperview = %@",NSStringFromCGRect(rectInSuperview));
            
            
            
            if (rectInSuperview.origin.y<-self.currentCell.bigImgView.frame.size.height||rectInSuperview.origin.y>self.view.frame.size.height-64-50) {//往上拖动
                
//                if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:_wmPlayer]&&isSmallScreen) {
//                    isSmallScreen = YES;
//                }else{
//                    //放widow上,小屏显示
//                    [self toSmallScreen];
//                }
                
                
                
            }else{
//                if ([self.currentCell.backgroundIV.subviews containsObject:wmPlayer]) {
//                    
//                }else{
//                    [self toCell];
//                }
            }
        }
        
    }
}

#pragma mark -  回调刷新
-(void)doneWithView:(MJRefreshComponent*)refreshView{
    [_myRefreshView  endRefreshing];
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
-(NSMutableArray *)listArry{
    
    if (!_listArry) {
        _listArry = [[NSMutableArray alloc] init];
    }
    return _listArry;
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

/**
 *  释放WMPlayer
 */
-(void)releaseWMPlayer{
    [_wmPlayer.player.currentItem cancelPendingSeeks];
    [_wmPlayer.player.currentItem.asset cancelLoading];
    [_wmPlayer.player pause];
    
    //移除观察者
    [_wmPlayer.currentItem removeObserver:_wmPlayer forKeyPath:@"status"];
    
    [_wmPlayer removeFromSuperview];
    [_wmPlayer.playerLayer removeFromSuperlayer];
    [_wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
    _wmPlayer.player = nil;
    _wmPlayer.currentItem = nil;
    //释放定时器，否侧不会调用WMPlayer中的dealloc方法
    [_wmPlayer.autoDismissTimer invalidate];
    _wmPlayer.autoDismissTimer = nil;
    [_wmPlayer.durationTimer invalidate];
    _wmPlayer.durationTimer = nil;
    
    
    _wmPlayer.playOrPauseBtn = nil;
    _wmPlayer.playerLayer = nil;
    _wmPlayer = nil;
    
    _currentIndexPath = nil;
}
-(void)dealloc{
    NSLog(@"%@ dealloc",[self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self releaseWMPlayer];
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
