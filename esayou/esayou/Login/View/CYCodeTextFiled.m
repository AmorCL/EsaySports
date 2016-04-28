//
//  CYCodeTextFiled.m
//  esayou
//
//  Created by ESAY on 16/4/8.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYCodeTextFiled.h"
@interface CYCodeTextFiled()

@end
@implementation CYCodeTextFiled
-(instancetype)init{
    if (self = [super init]) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    //获取验证码
    self.getCode = [UIButton buttonWithType:UIButtonTypeCustom];
    [_getCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    _getCode.backgroundColor = GetColor(whiteColor);
    [_getCode setTitleColor:GetColor(blueColor) forState:UIControlStateNormal];
    _getCode.titleLabel.textAlignment = NSTextAlignmentCenter;
    _getCode.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_getCode addTarget:self action:@selector(getCodeBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_getCode];
    
    //分割线
    UIView *lineView = [UIView new];
    lineView.backgroundColor = GetColor(lightGrayColor);
    [self addSubview:lineView];
    
    _getCode.sd_layout
    .rightSpaceToView(self,3)
    .topSpaceToView(self,3)
    .bottomSpaceToView(self,3)
    .widthIs(100);
    
    lineView.sd_layout
    .rightSpaceToView(_getCode,5)
    .topSpaceToView(self,3)
    .bottomSpaceToView(self,3)
    .widthIs(1);
    
}
-(void)getCodeBtn{
    
    self.getCodeBtned();
    
//    _currentTime = 60;
//    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
//    _getCode.userInteractionEnabled = NO;

}
- (void)timeFireMethod
{
    _currentTime --;
    [_getCode setTitle:[NSString stringWithFormat:@"%ld s后重新发送",(long)_currentTime] forState:UIControlStateNormal];
    if (_currentTime == 0) {
        [_timer invalidate];
        _currentTime = 60;
        _getCode.userInteractionEnabled =YES;
        [_getCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
