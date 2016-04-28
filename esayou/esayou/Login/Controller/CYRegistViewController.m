//
//  CYRegistViewController.m
//  esayou
//
//  Created by ESAY on 16/4/12.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYRegistViewController.h"
#import "CYCodeTextFiled.h"

@interface CYRegistViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *nameTextFiled;
@property(nonatomic,strong)UITextField *phoneTextFiled;
@property(nonatomic,strong)UITextField *passwdTextFiled;
@property(nonatomic,strong)UIButton *registBtn;
@property(nonatomic,strong)CYCodeTextFiled *getCodeTextFiled;
@property(nonatomic,copy)NSString *smsCode;
@property(nonatomic,copy)NSString *erroCode;
@property(nonatomic,copy)NSString *phoneNum;
@end

@implementation CYRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    // Do any additional setup after loading the view.
}
-(void)setUI{
    [self.wifiView removeFromSuperview];
    [self addTitleViewWithTitle:self.titleString];

    self.view.backgroundColor = GetColor(whiteColor);
    //昵称
    self.nameTextFiled = [UITextField new];
    _nameTextFiled.placeholder = @"昵称";
    _nameTextFiled.borderStyle =UITextBorderStyleRoundedRect;
    _nameTextFiled.delegate =self;
    _nameTextFiled.returnKeyType =UIReturnKeyDone;
    _nameTextFiled.clearButtonMode =UITextFieldViewModeWhileEditing;
    _nameTextFiled.textAlignment =NSTextAlignmentLeft;
    _nameTextFiled.keyboardType =UIKeyboardTypeDefault;
    _nameTextFiled.secureTextEntry =NO;
    _nameTextFiled.backgroundColor = GetColor(whiteColor);
    [self.view addSubview:_nameTextFiled];
    
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
    
    //验证码
    self.getCodeTextFiled = [[CYCodeTextFiled alloc]init];
    _getCodeTextFiled.placeholder = @"验证码";
    _getCodeTextFiled.borderStyle =UITextBorderStyleRoundedRect;
    _getCodeTextFiled.delegate =self;
    _getCodeTextFiled.returnKeyType =UIReturnKeyDone;
    _getCodeTextFiled.clearButtonMode =UITextFieldViewModeNever;
    _getCodeTextFiled.textAlignment =NSTextAlignmentLeft;
    _getCodeTextFiled.keyboardType =UIKeyboardTypeNumberPad;
    _getCodeTextFiled.secureTextEntry =NO;
    _getCodeTextFiled.backgroundColor = GetColor(whiteColor);
    __block typeof (self) Self = self;
    
    _getCodeTextFiled.getCodeBtned = ^{
        NSLog(@"点击获取验证码");
        [Self hideKeyboard];
        [Self getPhoneNumber];
        
    };
    [self.view addSubview:_getCodeTextFiled];
    
    //密码
    self.passwdTextFiled = [UITextField new];
    _passwdTextFiled.placeholder = @"密码";
    _passwdTextFiled.borderStyle =UITextBorderStyleRoundedRect;
    _passwdTextFiled.delegate =self;
    _passwdTextFiled.returnKeyType =UIReturnKeyDone;
    _passwdTextFiled.clearButtonMode =UITextFieldViewModeWhileEditing;
    _passwdTextFiled.textAlignment =NSTextAlignmentLeft;
    _passwdTextFiled.keyboardType =UIKeyboardTypeDefault;
    _passwdTextFiled.secureTextEntry =YES;
    _passwdTextFiled.backgroundColor = GetColor(whiteColor);
    [self.view addSubview:_passwdTextFiled];
    
    //注册按钮
    self.registBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _registBtn.backgroundColor = RGB(51, 132, 255);
    [_registBtn addTarget:self action:@selector(registNow) forControlEvents:UIControlEventTouchUpInside];
    [_registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_registBtn setTitleColor:GetColor(whiteColor) forState:UIControlStateNormal];
    [_registBtn.layer setMasksToBounds:YES];
    [_registBtn.layer setCornerRadius:5];
    [self.view addSubview:self.registBtn];
    
    
    
    self.nameTextFiled.sd_layout
    .leftSpaceToView(self.view,40)
    .topSpaceToView(self.navBarView,20)
    .rightSpaceToView(self.view,40)
    .heightIs(LOGIN_REGIST_HEIGHT);
    
    self.phoneTextFiled.sd_layout
    .leftEqualToView(self.nameTextFiled)
    .rightEqualToView(self.nameTextFiled)
    .topSpaceToView(self.nameTextFiled,20)
    .heightIs(LOGIN_REGIST_HEIGHT);
    
    self.getCodeTextFiled.sd_layout
    .leftEqualToView(self.phoneTextFiled)
    .rightEqualToView(self.phoneTextFiled)
    .topSpaceToView(self.phoneTextFiled,20)
    .heightIs(LOGIN_REGIST_HEIGHT);
    
    self.passwdTextFiled.sd_layout
    .leftEqualToView(self.getCodeTextFiled)
    .rightEqualToView(self.getCodeTextFiled)
    .topSpaceToView(self.getCodeTextFiled,20)
    .heightIs(LOGIN_REGIST_HEIGHT);
    
    self.registBtn.sd_layout
    .leftEqualToView(self.passwdTextFiled)
    .rightEqualToView(self.passwdTextFiled)
    .topSpaceToView(self.passwdTextFiled,30)
    .heightIs(LOGIN_REGIST_HEIGHT);
    
}
#pragma mark --注册按钮--
-(void)registNow{
    NSLog(@"注册");
    [self hideKeyboard];
    [self registUser];
    
}
-(void)registUser{
    //判断
    if ([_nameTextFiled.text isEqualToString:@""]) {
        [self showInfoView:@"昵称不能为空"];
    }else if([_passwdTextFiled.text length] < 6){
        [self showInfoView:@"密码不能少于6位"];
    }else if([_getCodeTextFiled.text isEqualToString:@""]){
        [self showInfoView:@"请输入手机验证码"];
    }else{
        if ([_getCodeTextFiled.text intValue] == [_smsCode                                            intValue]){
            NSMutableDictionary * dict =[NSMutableDictionary new];
            [dict setObject:_nameTextFiled.text forKey:@"use_rname"];
            [dict setObject:_passwdTextFiled.text forKey:@"user_passwd"];
            [dict setObject:self.phoneNum forKey:@"phone"];
            NSLog(@"参数:%@",dict);
            [self showWaiting:YES];
            [CYHttprequestHelper PostGetDataWithPhpUrl:ESAYOU_REGISTER_URL andParams:dict success:^(AFHTTPRequestOperation *operation, id jsonObj) {
                [self showWaiting:NO];
                NSMutableDictionary *dic = jsonObj[@"code"];
                NSLog(@"成功：%@",jsonObj);
                if ([dic[@"error_code"] integerValue] == 0) {
                    [self showInfoView:@"注册成功"];
                    NSLog(@"成功：%@",jsonObj);
                    //返回登录页面
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }else{
                    [self showInfoView:@"该手机号已注册，请直接登录"];
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"失败");
            }];
            
        }else{
            [self showInfoView:@"验证码输入有误"];
        }
        
    }
}






/**
 *  获取验证码
 */
-(void)getPhoneNumber{
    BOOL isMobileNum = [self isMobileNumberClassification:_phoneTextFiled.text];
    if (isMobileNum==NO) {
        [self showInfoView:@"号码不符合规范"];
    }else{
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
        [dic setValue:_phoneTextFiled.text forKey:@"phone"];
        NSLog(@"json:%@  %@",_phoneTextFiled.text,dic);
        [self showWaiting:YES];
        [CYHttprequestHelper PostGetDataWithPhpUrl:ESAYOU_SMS_URL andParams:dic success:^(AFHTTPRequestOperation *operation, id jsonObj) {
            [self showWaiting:NO];
            NSMutableDictionary *numDic = jsonObj[@"code"];
            self.erroCode = numDic[@"error_code"];
            NSMutableDictionary *dic = jsonObj[@"item"];
            self.smsCode = dic[@"codes"];
            self.phoneNum = _phoneTextFiled.text;
            NSLog(@"json:%@",jsonObj);
            if ([self.erroCode integerValue] == 0) {
                [self showInfoView:@"发送成功"];
                self.getCodeTextFiled.currentTime = 10;
                self.getCodeTextFiled.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
                self.getCodeTextFiled.getCode.userInteractionEnabled = NO;
            }else{
                [self showInfoView:@"验证码发送失败"];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self showInfoView:@"网络繁忙，请稍后再试"];
        }];
    }
}
- (BOOL)isMobileNumberClassification:(NSString *)mobileNumber
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,1705
     * 联通：130,131,132,152,155,156,185,186,1709
     * 电信：133,1349,153,180,189,1700
     */
    //    NSString * MOBILE = @"^1((3//d|5[0-35-9]|8[025-9])//d|70[059])\\d{7}$";//总况
    
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188，1705
     */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d|705)\\d{7}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,152,155,156,185,186,1709
     */
    NSString * CU = @"^1((3[0-2]|5[256]|8[56])\\d|709)\\d{7}$";
    /**
     * 中国电信：China Telecom
     * 133,1349,153,180,189,1700
     */
    NSString * CT = @"^1((33|53|8[09])\\d|349|700)\\d{7}$";
    
    
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    
    //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",PHS];
    
    if (([regextestcm evaluateWithObject:mobileNumber] == YES)
        || ([regextestct evaluateWithObject:mobileNumber] == YES)
        || ([regextestcu evaluateWithObject:mobileNumber] == YES)
        || ([regextestphs evaluateWithObject:mobileNumber] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([textField isKindOfClass:[CYCodeTextFiled class]]) {
        NSLog(@"111");
        if (range.length + range.location > textField.text.length) {
            return NO;
        }
        NSInteger newLength = [textField.text length] + [string length] - range.length;
        return newLength <= 6;
    }
    return YES;
}

- (void)timeFireMethod
{
    self.getCodeTextFiled.currentTime --;
    [self.getCodeTextFiled.getCode setTitle:[NSString stringWithFormat:@"%ld s后重新发送",(long)self.getCodeTextFiled.currentTime] forState:UIControlStateNormal];
    if (self.getCodeTextFiled.currentTime == 0) {
        [self.getCodeTextFiled.timer invalidate];
        //        self.getCodeTextFiled.currentTime = 60;
        self.getCodeTextFiled.getCode.userInteractionEnabled =YES;
        [self.getCodeTextFiled.getCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.getCodeTextFiled.getCode resignFirstResponder];
    }
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
    [_nameTextFiled resignFirstResponder];
    [_phoneTextFiled resignFirstResponder];
    [_passwdTextFiled resignFirstResponder];
    [_getCodeTextFiled resignFirstResponder];
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
