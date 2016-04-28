//
//  CYLoginViewController.m
//  esayou
//
//  Created by ESAY on 16/4/11.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYLoginViewController.h"
#import "CYRegistViewController.h"
#import "CYForgetPasswdViewController.h"
@interface CYLoginViewController ()<UMSocialUIDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UITextField *phoneTextFiled;
@property(nonatomic,strong)UITextField *passwordTextFiled;
@property(nonatomic,strong)UIButton *loginBtn;

@property(nonatomic,strong)UIButton *qqBtn;
@property(nonatomic,strong)UIButton *sinaBtn;
@property(nonatomic,strong)UIButton *weChatBtn;
@property(nonatomic,strong)UIButton *forgetPasswordBtn;
@property(nonatomic,strong)UIButton *registBtn;



@end

@implementation CYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.hidesBottomBarWhenPushed = YES;
    self.view.backgroundColor = GetColor(whiteColor);
    //    [self creatUI];
    [self setUI];
    // Do any additional setup after loading the view.
}
-(void)setUI{
    [self.wifiView removeFromSuperview];
    [self addTitleViewWithTitle:self.titleString];

    //手机号
    self.phoneTextFiled = [UITextField new];
    _phoneTextFiled.placeholder = @"手机号";
    _phoneTextFiled.borderStyle =UITextBorderStyleRoundedRect;
    _phoneTextFiled.delegate =self;
    _phoneTextFiled.returnKeyType =UIReturnKeyDone;
    _phoneTextFiled.clearButtonMode =UITextFieldViewModeWhileEditing;
    _phoneTextFiled.textAlignment =NSTextAlignmentLeft;
    _phoneTextFiled.keyboardType =UIKeyboardTypeNumberPad;
    _phoneTextFiled.secureTextEntry =NO;
    _phoneTextFiled.backgroundColor = GetColor(whiteColor);
    [self.view addSubview:_phoneTextFiled];
    
    //密码
    self.passwordTextFiled = [UITextField new];
    _passwordTextFiled.placeholder = @"密码";
    _passwordTextFiled.borderStyle =UITextBorderStyleRoundedRect;
    _passwordTextFiled.delegate =self;
    _passwordTextFiled.returnKeyType =UIReturnKeyDone;
    _passwordTextFiled.clearButtonMode =UITextFieldViewModeWhileEditing;
    _passwordTextFiled.textAlignment =NSTextAlignmentLeft;
    _passwordTextFiled.keyboardType =UIKeyboardTypeDefault;
    _passwordTextFiled.secureTextEntry =YES;
    _passwordTextFiled.backgroundColor = GetColor(whiteColor);
    [self.view addSubview:_passwordTextFiled];
    
    //登陆按钮
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _loginBtn.backgroundColor = RGB(51, 132, 255);
    [_loginBtn addTarget:self action:@selector(loginNow) forControlEvents:UIControlEventTouchUpInside];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:GetColor(whiteColor) forState:UIControlStateNormal];
    [_loginBtn.layer setMasksToBounds:YES];
    [_loginBtn.layer setCornerRadius:5];
    [self.view addSubview:self.loginBtn];
    
    //忘记密码
    self.forgetPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.forgetPasswordBtn.backgroundColor = GetColor(whiteColor);
    [self.forgetPasswordBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    self.forgetPasswordBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.forgetPasswordBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.forgetPasswordBtn setTitleColor:GetColor(lightGrayColor) forState:UIControlStateNormal];
    [self.forgetPasswordBtn addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.forgetPasswordBtn];
    
    //合作账号登陆
    UIView *leftLine = [UIView new];
    leftLine.backgroundColor = GetColor(lightGrayColor);
    [self.view addSubview:leftLine];
    
    UIView *rightLine = [UIView new];
    rightLine.backgroundColor = GetColor(lightGrayColor);
    [self.view addSubview:rightLine];
    
    UILabel *lable = [UILabel new];
    lable.text = @"合作账号登录";
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = GetColor(lightGrayColor);
    lable.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:lable];
    
    //QQ登陆
    self.qqBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_qqBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_qqBtn addTarget:self action:@selector(thirdLogin:) forControlEvents:UIControlEventTouchUpInside];
    _qqBtn.backgroundColor = GetColor(yellowColor);
    _qqBtn.tag = 3;
    [self.view addSubview:_qqBtn];
    
    //微博登录
    self.sinaBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_sinaBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_sinaBtn addTarget:self action:@selector(thirdLogin:) forControlEvents:UIControlEventTouchUpInside];
    _sinaBtn.backgroundColor = GetColor(redColor);
    _sinaBtn.tag = 2;
    [self.view addSubview:_sinaBtn];
    
    //微信登陆
    self.weChatBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_weChatBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_weChatBtn addTarget:self action:@selector(thirdLogin:) forControlEvents:UIControlEventTouchUpInside];
    _weChatBtn.backgroundColor = GetColor(blueColor);
    _weChatBtn.tag = 1;
    [self.view addSubview:_weChatBtn];
    
    //快速注册
    UILabel *leftLab = [[UILabel alloc]initWithFrame:CGRectMake(self.view.centerX-80, kScreenHeight-50-20, 80, 20)];
    leftLab.text = @"没有账号,";
    leftLab.textAlignment = NSTextAlignmentRight;
    leftLab.adjustsFontSizeToFitWidth = YES;
    leftLab.textColor = GetColor(lightGrayColor);
    [self.view addSubview:leftLab];
    
    self.registBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    [_registBtn setTitle:@"快速注册" forState:UIControlStateNormal];
    [_registBtn addTarget: self action:@selector(registNow) forControlEvents:UIControlEventTouchUpInside];
    [_registBtn setTitleColor:RGB(51, 132, 255) forState:UIControlStateNormal];
    _registBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:_registBtn];
    
    self.phoneTextFiled.sd_layout
    .leftSpaceToView(self.view,40)
    .topSpaceToView(self.navBarView,20)
    .rightSpaceToView(self.view,40)
    .heightIs(LOGIN_REGIST_HEIGHT);
    
    self.passwordTextFiled.sd_layout
    .leftEqualToView(self.phoneTextFiled)
    .rightEqualToView(self.phoneTextFiled)
    .topSpaceToView(self.phoneTextFiled,20)
    .heightIs(LOGIN_REGIST_HEIGHT);
    
    self.loginBtn.sd_layout
    .leftEqualToView(self.phoneTextFiled)
    .rightEqualToView(self.phoneTextFiled)
    .topSpaceToView(self.passwordTextFiled,30)
    .heightIs(LOGIN_REGIST_HEIGHT);
    
    self.forgetPasswordBtn.sd_layout
    .rightEqualToView(self.loginBtn)
    .topSpaceToView(self.loginBtn,5)
    .widthIs(80)
    .heightIs(20);
    
    lable.sd_layout
    .centerXEqualToView(self.loginBtn)
    .topSpaceToView(self.forgetPasswordBtn,50)
    .widthIs(100)
    .heightIs(20);
    
    leftLine.sd_layout
    .leftEqualToView(self.view)
    .rightSpaceToView(lable,1)
    .centerYEqualToView(lable)
    .heightIs(1);
    
    rightLine.sd_layout
    .leftSpaceToView(lable,1)
    .rightEqualToView(self.view)
    .topEqualToView(leftLine)
    .heightIs(1);
    
    self.sinaBtn.sd_layout
    .centerXEqualToView(self.loginBtn)
    .topSpaceToView(lable,30)
    .widthIs(60)
    .heightIs(60);
    
    self.qqBtn.sd_layout
    .topEqualToView(self.sinaBtn)
    .leftEqualToView(self.loginBtn)
    .widthIs(60)
    .heightIs(60);
    
    self.weChatBtn.sd_layout
    .topEqualToView(self.sinaBtn)
    .rightEqualToView(self.loginBtn)
    .widthIs(60)
    .heightIs(60);
    
    self.registBtn.sd_layout
    .leftSpaceToView(leftLab,0)
    .topEqualToView(leftLab)
    .widthIs(80)
    .heightIs(20);
    
    
    
    
}
#pragma mark --登陆按钮--
-(void)loginNow{
    NSLog(@"登陆");
    BOOL isPhone = [self checkTel:_phoneTextFiled.text];
    if ([_phoneTextFiled.text isEqualToString:@""]) {
        [self showInfoView:@"用户名不能为空"];
    }else if (!isPhone){
        [self showInfoView:@"输入的手机号有误,请重新输入"];
    }else if([_passwordTextFiled.text isEqualToString:@""]){
        [self showInfoView:@"请输入密码"];
    }else{
        NSMutableDictionary * dict =[NSMutableDictionary dictionary];
        [dict setObject:_phoneTextFiled.text forKey:@"phone"];
        [dict setObject:_passwordTextFiled.text forKey:@"user_passwd"];
        [dict setObject:@"0" forKey:@"flag"];
        [self request:dict];
    }
}
#pragma mark--忘记密码--
-(void)forgetPassword{
    NSLog(@"忘记密码");
    CYForgetPasswdViewController *forgetPasswdVc = [[CYForgetPasswdViewController alloc]init];
    forgetPasswdVc.titleString = @"忘记密码";
    [self.navigationController pushViewController:forgetPasswdVc animated:YES];
    
}
#pragma mark--第三方登陆授权--
-(void)thirdLogin:(UIButton *)btn{
    if (btn.tag == 3) {
        NSLog(@"QQ登录");
        [self loginThree:UMShareToQQ andTag:btn.tag];
    }else if (btn.tag == 2){
        NSLog(@"新浪登陆");
        [self loginThree:UMShareToSina andTag:btn.tag];
    }else if (btn.tag == 1){
        NSLog(@"微信登陆");
        [self loginThree:UMShareToWechatSession andTag:btn.tag];
    }
}
#pragma mark--注册账号--
-(void)registNow{
    NSLog(@"注册");
    CYRegistViewController *regist = [[CYRegistViewController alloc]init];
    regist.titleString = @"注册";
    [self.navigationController pushViewController:regist animated:YES];
}

#pragma mark--第三方登陆--
-(void)loginThree:(NSString *)nameStr andTag:(NSInteger )tag{
    [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:nameStr];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        NSLog(@"%@",response.data);
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:nameStr];
            //            NSLog(@"--:%@",snsAccount);
            NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId);
            //第三方登陆参数
            NSMutableDictionary *dic = [NSMutableDictionary new];
            [dic setValue:[NSNumber numberWithInteger:tag] forKey:@"flag"];
            if (tag == 1) {
                [dic setValue:snsAccount.unionId forKey:@"auth_id"];
            }else if (tag == 2){
                [dic setValue:snsAccount.unionId forKey:@"auth_id"];
            }else if (tag == 3){
                [dic setValue:snsAccount.usid forKey:@"auth_id"];
            }
            [dic setValue:snsAccount.userName forKey:@"user_name"];
            NSLog(@"dic:%@  %@",dic,snsAccount.userName);
            [self request:dic];
        }
    });
    
    
    
}

-(void)request:(NSMutableDictionary *)dic{
    [self showWaiting:YES];
    NSLog(@"传入的参数:%@",dic);
    [CYHttprequestHelper PostGetDataWithPhpUrl:ESAYOU_LOGIN_URL andParams:dic success:^(AFHTTPRequestOperation *operation, id jsonObj) {
        [self showWaiting:NO];
        //系统登录
        if ([dic[@"flag"] integerValue] == 0) {
            NSLog(@"系统登录成功:%@",jsonObj);
            NSMutableDictionary *dict = jsonObj[@"code"];
            if ([dict[@"error_code"] integerValue] == 1) {
                [self showInfoView:@"登录成功"];
            }else{
                [self showInfoView:@"登陆失败,用户名或密码错误"];
            }
        }else{
            //第三方信息登录
            NSLog(@"第三方登录成功返回:%@",jsonObj);
            NSMutableDictionary *dict = jsonObj[@"item"];
            NSString * str = dict[@"user_name"];
            NSLog(@"第三方:%@",str);
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self showWaiting:NO];
        NSLog(@"失败:%@",error);
        [self showInfoView:@"网络错误,请检查网络"];
    }];
}

//检测是否为手机号
- (BOOL)checkTel:(NSString *)str

{
    
    //    if ([str length] == 0) {
    //
    //        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"data_null_prompt", nil) message:NSLocalizedString(@"tel_no_null", nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //
    //        [alert show];
    //
    //
    //        return NO;
    //
    //    }
    
    //1[0-9]{10}
    
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    
    //    NSString *regex = @"[0-9]{11}";
    
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch) {
        
        return NO;
    }
    
    
    return YES;
    
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"触摸屏");
    [self hideKeyboard];
}

- (void)hideKeyboard
{
    [_phoneTextFiled resignFirstResponder];
    [_passwordTextFiled resignFirstResponder];
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
