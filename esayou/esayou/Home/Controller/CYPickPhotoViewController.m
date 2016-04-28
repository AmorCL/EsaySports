//
//  CYPickPhotoViewController.m
//  esayou
//
//  Created by ESAY on 16/4/20.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYPickPhotoViewController.h"
#import "ZZPhotoDatas.h"
#import "ZZPhotoPickerCell.h"
#import "ZZBrowserPickerViewController.h"
#import "CYPhotoVedioCollectionViewCell.h"
#import "CYWantLiveViewController.h"
#import "ZZCameraController.h"
#import "CYPickVedioViewController.h"

@interface CYPickPhotoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ZZBrowserPickerDelegate,UIImagePickerControllerDelegate>
@property (strong, nonatomic) NSMutableArray *photoArray;
@property (strong, nonatomic) NSMutableArray *selectArray;

@property (strong, nonatomic) UICollectionView *picsCollection;

@property (strong, nonatomic) UIButton *selectBtn;
@property (assign, nonatomic) BOOL isSelect;

@property (strong, nonatomic) UIButton *backBtn;
@property (strong, nonatomic) UIButton *cancelBtn;

@property (strong, nonatomic) UIButton *doneBtn;                       //完成按钮
@property (strong, nonatomic) UIButton *previewBtn;                    //预览按钮

@property (strong, nonatomic) UILabel *totalNumLabel;
@property (strong, nonatomic) ZZPhotoDatas *datas;
@property (strong, nonatomic) ZZBrowserPickerViewController *browserController;
@property (strong, nonatomic) NSArray *browserDataArray;


@end

@implementation CYPickPhotoViewController

#pragma SETUP backButtonUI Method
- (UIButton *)backBtn{
    if (!_backBtn) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 50, 44)];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        [button.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        //        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        _backBtn = button;
        
    }
    return _backBtn;
}

#pragma SETUP cancelButtonUI Method
- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.width-50, 20, 50, 44)];
        [button addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        [button.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        //        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        _cancelBtn = button;
        
    }
    return _cancelBtn;
}

#pragma SETUP doneButtonUI Method

-(UIButton *)doneBtn{
    if (!_doneBtn) {
        _doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.navBarView.width-50, 20, 50, 44)];
        [_doneBtn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
        _doneBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        [_doneBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
        [_doneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_doneBtn setTitle:@"确定" forState:UIControlStateNormal];
        //        [_doneBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
    return _doneBtn;
}

#pragma SETUP previewButtonUI Method

-(UIButton *)previewBtn{
    if (!_previewBtn) {
        _previewBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.centerX-25, 0, 50, 44)];
        [_previewBtn addTarget:self action:@selector(preview) forControlEvents:UIControlEventTouchUpInside];
        _previewBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        [_previewBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
        [_previewBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_previewBtn setTitle:@"预览" forState:UIControlStateNormal];
        //        [_previewBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
    return _previewBtn;
}


-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)cancel{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)done{
    id responseObject = [self.datas GetImageObject:self.selectArray];
    if ([(NSArray *)responseObject count] == 0) {
        [self showInfoView:@"照片或视频不能为空"];
    }else{
        self.PhotoResult(responseObject);
//        CYWantLiveViewController *wantVc = [[CYWantLiveViewController alloc]init];
//        wantVc.picArr = [self.datas GetImageObject:self.selectArray];
//        NSLog(@"拍摄:%@",wantVc.picArr);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)getCamare{
    ZZCameraController *camareVc = [[ZZCameraController alloc]init];
    camareVc.takePhotoOfMax = 6;
    [camareVc showIn:self result:^(id responseObject) {
        self.PhotoResult(responseObject);
    }];
}
-(void)getVedio{
    CYPickVedioViewController *picVedio = [[CYPickVedioViewController alloc]init];
    //    imagePicker.view.frame=s
    picVedio.VedioResult = ^(id response){
        NSLog(@"视频回来了");
        self.VedioResult(response);
    };
    
    [self.navigationController pushViewController:picVedio animated:YES];
//    WechatShortVideoController *wechatShortVideoController = [[WechatShortVideoController alloc] init];
//    wechatShortVideoController.delegate = self;
//    [self.navigationController pushViewController:wechatShortVideoController animated:YES];
}
#pragma mark - WechatShortVideoDelegate
- (void)finishWechatShortVideoCapture:(NSURL *)filePath {
    NSLog(@"filePath is %@", filePath);
}

//预览按钮，弹出图片浏览器
-(void)preview{
    _browserDataArray = self.selectArray;
    
    if (_browserDataArray.count == 0) {
        [self showPhotoPickerAlertView:@"提醒" message:@"您还没有选中图片，不需要预览"];
    }else{
        self.browserController = [[ZZBrowserPickerViewController alloc]init];
        self.browserController.delegate = self;
        [self.browserController reloadData];
        [self.browserController showIn:self animation:ShowAnimationOfPresent];
    }
    
}

#pragma Declaration Array
-(NSMutableArray *)photoArray
{
    if (!_photoArray) {
        _photoArray = [NSMutableArray array];
    }
    return _photoArray;
}

-(NSMutableArray *)selectArray
{
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}

#pragma 懒加载图片数据
-(ZZPhotoDatas *)datas{
    if (!_datas) {
        _datas = [[ZZPhotoDatas alloc]init];
    }
    return _datas;
}

#pragma 总共多少张照片Label

-(UILabel *)totalNumLabel{
    if (!_totalNumLabel) {
        _totalNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, ZZ_VW, 20)];
        _totalNumLabel.textColor = [UIColor blackColor];
        _totalNumLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _totalNumLabel;
}

-(void)stepTabbar
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, ZZ_VH - 44, ZZ_VW, 44)];
    view.backgroundColor = GetColor(whiteColor);
//    [view addSubview:self.doneBtn];
    [view addSubview:self.previewBtn];
    [self.view addSubview:view];
    
    UIView *viewLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZZ_VW, 1)];
    viewLine.backgroundColor = ZZ_RGB(237, 237, 237);
    [view addSubview:viewLine];
}
-(void)setupTopBar{
    [self.navBarView addSubview:self.backBtn];
    [self.navBarView addSubview:self.doneBtn];
}
-(void)setupCollectionViewUI
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    CGFloat photoSize = ([UIScreen mainScreen].bounds.size.width - 3) / 4;
    flowLayout.minimumInteritemSpacing = 1.0;//item 之间的行的距离
    flowLayout.minimumLineSpacing = 1.0;//item 之间竖的距离
    flowLayout.itemSize = (CGSize){photoSize,photoSize};
    //        self.sectionInset = UIEdgeInsetsMake(0, 2, 0, 0);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _picsCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, ZZ_VW, ZZ_VH - 45 -64) collectionViewLayout:flowLayout];
    [_picsCollection registerClass:[ZZPhotoPickerCell class] forCellWithReuseIdentifier:@"PhotoPickerCell"];
    [_picsCollection registerClass:[CYPhotoVedioCollectionViewCell class] forCellWithReuseIdentifier:@"PhotoVedioCell"];
    [_picsCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
    flowLayout.footerReferenceSize = CGSizeMake(ZZ_VW, 70);
    _picsCollection.delegate = self;
    _picsCollection.dataSource = self;
    _picsCollection.backgroundColor = [UIColor whiteColor];
    [_picsCollection setUserInteractionEnabled:YES];
    [self.view addSubview:_picsCollection];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTitleViewWithTitle:self.navTitleString];
    //创建底部工具栏
    [self stepTabbar];
    [self setupTopBar];
    [self setupCollectionViewUI];
    
    //    self.navigationItem.leftBarButtonItem = self.backBtn;
    //    self.navigationItem.rightBarButtonItem = self.cancelBtn;
    
    
    [self loadPhotoData];
}

-(void)loadPhotoData
{
    if (_isAlubSeclect == YES) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            self.photoArray = [self.datas GetPhotoAssets:_fetch];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_picsCollection reloadData];
                [self refreshTotalNumLabelData:_photoArray.count];
                
            });
        });
    }else{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            self.photoArray = [self.datas GetPhotoAssets:[self.datas GetCameraRollFetchResul]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_picsCollection reloadData];
                [self refreshTotalNumLabelData:_photoArray.count];
            });
        });
    }
}

-(void)refreshTotalNumLabelData:(NSInteger)totalNum
{
    self.totalNumLabel.text = [NSString stringWithFormat:Total_Pic_Num,(long)totalNum];
}


#pragma 关键位置，选中的在数组中添加，取消的从数组中减少
-(void)selectPicBtn:(UIButton *)button
{
    NSInteger index = button.tag;
    if (button.selected == NO) {
        if (self.selectArray.count + 1 > _selectNum) {
            [self showSelectPhotoAlertView:_selectNum];
        }else{
            [self.selectArray addObject:[self.photoArray objectAtIndex:index]];
            [button setImage:Pic_Btn_Selected forState:UIControlStateNormal];
            button.selected = YES;
        }
        
    }else{
        [self.selectArray removeObject:[self.photoArray objectAtIndex:index]];
        [button setImage:Pic_btn_UnSelected forState:UIControlStateNormal];
        button.selected = NO;
    }
    
}


#pragma UICollectionView --- Datasource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoArray.count+2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row <2) {
        CYPhotoVedioCollectionViewCell *selecCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoVedioCell" forIndexPath:indexPath];
        selecCell.backgroundColor = GetColor(redColor);
        if (indexPath.row == 0) {
            selecCell.backgroundImg.image = GetImage(@"v.jpg");
        }else{
            selecCell.backgroundImg.image = GetImage(@"123.jpg");
        }
        return selecCell;
    }else{
        ZZPhotoPickerCell *photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoPickerCell" forIndexPath:indexPath];
        
        
        photoCell.selectBtn.tag = indexPath.row-2;
        [photoCell.selectBtn addTarget:self action:@selector(selectPicBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [photoCell loadPhotoData:[self.photoArray objectAtIndex:(indexPath.row-2)]];
        [photoCell selectBtnStage:self.selectArray existence:[self.photoArray objectAtIndex:(indexPath.row-2)]];
        
        return photoCell;
    }
}
#pragma UICollectionView --- Delegate
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath

{
    UICollectionReusableView *footerView = [[UICollectionReusableView alloc]init];
    footerView.backgroundColor = [UIColor redColor];
    if (kind == UICollectionElementKindSectionFooter){
        footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
    }
    
    [footerView addSubview:self.totalNumLabel];
    return footerView;
    
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"被点击");
    if (indexPath.row == 0) {
        NSLog(@"相机");
        [self getCamare];
    }else if (indexPath.row == 1){
        NSLog(@"视频");
        [self getVedio];
    }
}
#pragma mark --- ZZBrowserPickerDelegate
-(NSInteger)zzbrowserPickerPhotoNum:(ZZBrowserPickerViewController *)controller
{
    return _browserDataArray.count;
}

-(NSArray *)zzbrowserPickerPhotoContent:(ZZBrowserPickerViewController *)controller
{
    return _browserDataArray;
}

-(void)showSelectPhotoAlertView:(NSInteger)photoNumOfMax
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:[NSString stringWithFormat:Alert_Max_Selected,(long)photoNumOfMax]preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        
    }];
    
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)showPhotoPickerAlertView:(NSString *)title message:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        
    }];
    
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
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
