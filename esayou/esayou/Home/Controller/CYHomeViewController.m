//
//  CYHomeViewController.m
//  esayou
//
//  Created by ESAY on 16/3/4.
//  Copyright (c) 2016年 ESAY. All rights reserved.
//

#import "CYHomeViewController.h"
#import "CYNavTabView.h"
#import "CAPSPageMenu.h"
#import "UMSocial.h"
#import "CYTitleLabView.h"
#import "CYHomeBaseViewController.h"

@interface CYHomeViewController ()<UMSocialUIDelegate>
@property(nonatomic,strong)CYNavTabView *topNavTabView;
@property(nonatomic,strong)CAPSPageMenu *topPageMenu;
/** 新闻接口的数组 */
@property(nonatomic,strong) NSArray *arrayLists;


@end

@implementation CYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatSmallScrollView];

    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 100, 100, 100);
    btn.backgroundColor = GetColor(redColor);
    [btn addTarget:self action:@selector(btn) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
    // Do any additional setup after loading the view.
}
//懒加载新闻数据
- (NSArray *)arrayLists
{
    if (_arrayLists == nil) {
        _arrayLists = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"NewsURLs.plist" ofType:nil]];
    }
    return _arrayLists;
}

-(void)creatSmallScrollView{
    //1.添加小的滚动菜单栏
    UIScrollView *smallScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    [self.view addSubview:smallScroll];
    smallScroll.showsHorizontalScrollIndicator=NO;
    smallScroll.showsVerticalScrollIndicator=NO;
    self.smallScroll=smallScroll;
    
    smallScroll.backgroundColor = GetColor(whiteColor);
    
    //2. 添加大的滚动菜单栏
    UIScrollView *bigScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, (kScreenHeight-64))];
    bigScroll.showsHorizontalScrollIndicator=NO;
    bigScroll.delegate=self;
    [self.view addSubview:bigScroll];
    self.bigScroll=bigScroll;
    bigScroll.backgroundColor = GetColor(whiteColor);

    //3.添加子控制器
    [self addController];
    //4.添加标题栏
    [self addLabel];

    //5.设置大的scrollview的滚动范围
    CGFloat contentX = self.childViewControllers.count * [UIScreen mainScreen].bounds.size.width;
    self.bigScroll.contentSize = CGSizeMake(contentX, 0);
    self.bigScroll.pagingEnabled = YES;

    
    //6.添加默认子控制器 (也就是第一个)
    UIViewController *vc = [self.childViewControllers firstObject];
    vc.view.frame = self.bigScroll.bounds;
    [self.bigScroll addSubview:vc.view];
    CYTitleLabView *lable = [self.smallScroll.subviews firstObject];
    lable.scale = 1.0;



}
#pragma mark 添加子控制器
-(void)addController
{
    for (int i=0 ; i<self.arrayLists.count ;i++){
        CYHomeBaseViewController *vc = [[CYHomeBaseViewController alloc]init];
        
        vc.title = self.arrayLists[i][@"title"];
        vc.urlString = self.arrayLists[i][@"urlString"];
        vc.size = self.bigScroll.size;
        [self addChildViewController:vc];
    }
}

#pragma mark 添加标题栏
-(void)addLabel
{
    CGFloat lblW = 70;
    CGFloat lblH = 40;
    CGFloat lblY = 24;
    CGFloat lblX =0;
    for (int i=0 ; i<self.arrayLists.count ;i++){
        lblX = i * lblW;
        CYTitleLabView *lbl1 = [[CYTitleLabView alloc]initWithFrame:CGRectMake(lblX, lblY, lblW, lblH)];
//        lbl1.frame = CGRectMake(lblX, lblY, lblW, lblH);

        UIViewController *vc = self.childViewControllers[i];
        lbl1.titleLab.text =vc.title;

        lbl1.titleLab.font = [UIFont fontWithName:@"HYQiHei" size:19];
        [self.smallScroll addSubview:lbl1];
        lbl1.tag = i;
        lbl1.userInteractionEnabled = YES;
        
        [lbl1 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lblClick:)]];
    }
    //设置小scroll滚动的范围
    self.smallScroll.contentSize=CGSizeMake(lblW*self.arrayLists.count, 0);
}

#pragma mark 标签栏的点击事件
-(void)lblClick:(UITapGestureRecognizer *)recognizer
{
    CYTitleLabView *titlelable = (CYTitleLabView *)recognizer.view;
    
    CGFloat offsetX = titlelable.tag * self.bigScroll.frame.size.width;
    
    CGFloat offsetY = self.bigScroll.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    
    [self.bigScroll setContentOffset:offset animated:YES];
}


#pragma mark - ******************** scrollView代理方法
/** 滚动结束（手势导致） */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/** 滚动结束后调用（代码导致） */
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView

{
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / self.bigScroll.frame.size.width;
    
    // 滚动标题栏
    CYTitleLabView *titleLable = (CYTitleLabView *)self.smallScroll.subviews[index];
    
    CGFloat offsetx = titleLable.center.x - self.smallScroll.frame.size.width * 0.5;
    
    CGFloat offsetMax = self.smallScroll.contentSize.width - self.smallScroll.frame.size.width;
    
    if (offsetx < 0) {
        offsetx = 0;
    }else if (offsetx > offsetMax){
        offsetx = offsetMax;
    }
    
    CGPoint offset = CGPointMake(offsetx, self.smallScroll.contentOffset.y);
    //  NSLog(@"%@",NSStringFromCGPoint(offset));
    [self.smallScroll setContentOffset:offset animated:YES];
    // 添加控制器
    CYHomeBaseViewController *newsVc = self.childViewControllers[index];
    newsVc.index = index;
    
    
    
    
    [self.smallScroll.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx != index) {
            CYTitleLabView *temlabel = self.smallScroll.subviews[idx];
            temlabel.scale = 0.0;
        }
    }];
    
    if (newsVc.view.superview) return;
    
    newsVc.view.frame = scrollView.bounds;
    [self.bigScroll addSubview:newsVc.view];
}



/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 取出绝对值 避免最左边往右拉时形变超过1
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    CYTitleLabView *labelLeft = self.smallScroll.subviews[leftIndex];
    labelLeft.scale = scaleLeft;
    // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
    if (rightIndex < self.smallScroll.subviews.count) {
        
        CYTitleLabView *labelRight = self.smallScroll.subviews[rightIndex];
        
        labelRight.scale = scaleRight;
    }
    
}



//友盟分享测试
-(void)btn{
    
    [self shareTest];

}
-(void)shareTest{
    //    [UMSocialSnsService presentSnsIconSheetView:self
    //                                         appKey:@"56de74cee0f55a6d980004dd"
    //                                      shareText:@"我是测试数据"
    //                                     shareImage:[UIImage imageNamed:@"icon.png"]
    //                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,nil]
    //                                       delegate:self];
    [UMSocialSnsService presentSnsIconSheetView:self appKey:UMeng_AppKey shareText:@"hahahaha" shareImage:nil shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,nil] delegate:self];
}
//弹出列表方法presentSnsIconSheetView需要设置delegate为self
//点击后直接分享
-(BOOL)isDirectShareInIconActionSheet
{
    return YES;
}
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
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
