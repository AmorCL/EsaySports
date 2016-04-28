//
//  CYWantLiveViewController.m
//  esayou
//
//  Created by ESAY on 16/4/20.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYWantLiveViewController.h"
#import "CYPickPhotoViewController.h"
#import "CYChooseAdressView.h"
#import "CYSearchAdressController.h"
@interface CYWantLiveViewController ()<CYChooseAdressViewDelegate>
@property(nonatomic,assign)NSInteger imageOrVedio;
@property(nonatomic,strong)CYChooseAdressView *chooseAdressView;

@end

@implementation CYWantLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    // Do any additional setup after loading the view.
}
-(void)creatUI{
    [self.wifiView removeFromSuperview];
    self.view.backgroundColor = GetColor(lightGrayColor);
    [self addTitleViewWithTitle:@"直播"];
    self.titleLable.textColor = GetColor(blackColor);
    [self addLeftBtnWithTitle:@"取消" imageFile:@"" selector:@selector(cancle)];
    [self.navLeftBtn setTitleColor:GetColor(blueColor) forState:UIControlStateNormal];
    
    [self addRightBtnWithTitle:@"发布" imageFile:@"" selector:@selector(sendNow)];
    self.navRightBtn.titleLabel.textColor = GetColor(blueColor);
    [self.navRightBtn setTitleColor:GetColor(blueColor) forState:UIControlStateNormal];

    _editTextView = [[CYTextView alloc]initWithFrame:CGRectMake(0, self.navBarView.height, kScreenWidth, 100)];
    _editTextView.delegate = self;
    _editTextView.font = GetFont(18);
    _editTextView.textColor = RGBAlpha(0, 0, 0, 0.7);
    _editTextView.backgroundColor = GetColor(whiteColor);
    _editTextView.lable.text = @"记录精彩一刻...";
    [self.view addSubview:_editTextView];
    
    _showImgView = [[CYShowImgView alloc]initWithFrame:CGRectMake(0, _editTextView.y+_editTextView.height, kScreenWidth, (kScreenWidth-60)/5+20)];
    _showImgView.backgroundColor = GetColor(redColor);
    _showImgView.delegate = self;
    _showImgView.isImage = YES;
//    _showImgView.collectionView.backgroundColor = GetColor(lightGrayColor);
    [self.view addSubview:_showImgView];
    
    _chooseAdressView = [[CYChooseAdressView alloc]initWithFrame:CGRectMake(0, _showImgView.y+_showImgView.height+5, _showImgView.width, 60)];
    _chooseAdressView.delegate = self;
    [self.view addSubview:_chooseAdressView];

}
#pragma mark --输入文字时--
-(void)textViewDidChange:(UITextView *)textView{
    NSLog(@"%@",textView.text);
    if (textView == _editTextView) {
        if (textView.text.length > 0) {
            _editTextView.lable.text = @"";
        }else{
            _editTextView.lable.text = @"记录精彩一刻...";
        }
    }
}
#pragma mark--选择图片或者视频--
-(void)addImageOrVedioOrText{
    NSLog(@"选择图片或者视频");
    CYPickPhotoViewController *photoVc = [[CYPickPhotoViewController alloc]init];
    photoVc.selectNum = 6;
    photoVc.navTitleString = @"选择照片";
    photoVc.PhotoResult = ^(id response){
        NSLog(@"zhaopian确定:%@",response);
        _showImgView.dataArray = (NSMutableArray *)response;
        _showImgView.isImage = YES;
        _imageOrVedio = 0;
    };
    photoVc.VedioResult = ^(id response){
        NSLog(@"发布页:%@",response);
        _showImgView.isImage = NO;
        _showImgView.fileUrl = (NSURL *)response;
        _showImgView.vedioCount = 1;
        _imageOrVedio = 1;
        [self.view reloadInputViews];
    };
    [self.navigationController pushViewController:photoVc animated:YES];
}
#pragma mark --播放视频--
-(void)playVedio:(NSURL *)url{
    NSLog(@"播放视频:%@",url);
}
#pragma mark --选择位置--
-(void)chooseAdressNow{
    NSLog(@"选择位置");
    CYSearchAdressController *search = [[CYSearchAdressController alloc]init];
    [self.navigationController pushViewController:search animated:YES];
}
#pragma mark--发送直播--
-(void)sendNow{
    NSLog(@"发布");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@"122" forKey:@"user_id"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)_imageOrVedio] forKey:@"type"];
    [dic setObject:_editTextView.text forKey:@"content"];
//    [dic setObject:@"be96dbce8ea429538a88342edbcd0db5ae4c81e6" forKey:@"token"];
    [dic setObject:@"北京" forKey:@"country"];
//    [dic setObject:@"122" forKey:@"img"];
//    [dic setObject:@"122" forKey:@"vedio"];
    [dic setObject:@"122" forKey:@"lal"];

    NSMutableArray *imageDatasArr = [NSMutableArray array];
    for (UIImage *image in _showImgView.dataArray) {
//        NSLog(@"压缩前:%f  %f",image.size.width,image.size.height);
//        CGFloat scale = image.size.height/image.size.width;
//      UIImage *tempImg =  [self drawRect:image];
//        NSLog(@"压缩后:%f  %f",tempImg.size.width,tempImg.size.height);

        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        [imageDatasArr addObject:imageData];
    }
//    NSLog(@"发表%@",imageDatasArr);
    [self showWaiting:YES];
    [CYHttprequestHelper post:ESAYOU_HOME_LIVE_ADD_URL typeCount:_imageOrVedio andPath:_showImgView.fileUrl orImages:imageDatasArr andParams:dic success:^(AFHTTPRequestOperation *operation, id jsonObj) {
        [self showWaiting:NO];

        self.PhotoResult();
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self showWaiting:NO];
    }];
}

//- (UIImage *)drawRect:(UIImage *)image {
//    
//    CGSize newSize;
//    CGImageRef imageRef = nil;
//    
//    //以宽为标准进行裁剪图片
//    newSize.width = image.size.width;
//    newSize.height = image.size.width * 9 / 16;
//    
//    imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
//    
//    return [UIImage imageWithCGImage:imageRef];
//}


- (UIImage *)cutImage:(UIImage *)image scale:(CGFloat)scale{
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    if (image.size.width > image.size.height) {
        newSize.width = 16 / 9 * image.size.height;
        newSize.height = image.size.height;
//        newSize.width = image.size.width;
//        newSize.height = 9 / 16 * image.size.width;
        
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else {
        newSize.width = image.size.width;
        newSize.height = 9 / 16 * image.size.width;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        
    }
    
    return [UIImage imageWithCGImage:imageRef];
}

-(void)cancle{
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
