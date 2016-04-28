//
//  CYMineHeaderView.m
//  esayou
//
//  Created by ESAY on 16/3/24.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYMineHeaderView.h"

@implementation CYMineHeaderView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    //我的消息
    _mesageBtn = [UIButton new];
    [_mesageBtn setImage:GetImage(@"v.jpg") forState:UIControlStateNormal];
    [_mesageBtn addTarget:self action:@selector(mesageSender) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_mesageBtn];
    
    //设置
    _settingBtn = [UIButton new];
    [_settingBtn setImage:GetImage(@"v.jpg") forState:UIControlStateNormal];
    [_settingBtn addTarget:self action:@selector(settingSender) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_settingBtn];


    
    //头像
    _headImageView = [UIImageView new];
    UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headtap)];
    _headImageView.image = GetImage(@"v.jpg");
    _headImageView.userInteractionEnabled = YES;
    [_headImageView addGestureRecognizer:headTap];
    _headImageView.backgroundColor = GetColor(clearColor);
    _headImageView.layer.cornerRadius = 30;
    _headImageView.clipsToBounds = YES;
    [self addSubview:_headImageView];
    //名字
    _nameLab = [UILabel new];
    _nameLab.textAlignment = NSTextAlignmentLeft;
    _nameLab.font = GetFont(15);
    _nameLab.text = @"三文鱼啊啊啊";
    _nameLab.textColor = GetColor(whiteColor);
    _nameLab.backgroundColor = GetColor(clearColor);
    [self addSubview:_nameLab];
    
    //关注
    _focusBtn = [UILabel new];
    _focusBtn.backgroundColor = GetColor(clearColor);
    _focusBtn.textAlignment = NSTextAlignmentLeft;
    _focusBtn.font = GetFont(15);
    _focusBtn.text = @"关注";
    _focusBtn.textColor = GetColor(whiteColor);
    _focusBtn.userInteractionEnabled = YES;
    UITapGestureRecognizer *focusTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myfocus)];
    [_focusBtn addGestureRecognizer:focusTap];
    [self addSubview:_focusBtn];
    //关注数量
    _focusNum = [UILabel new];
    _focusNum.textAlignment  =NSTextAlignmentLeft;
    _focusNum.font = GetFont(15);
    _focusNum.text = @"5666";
    _focusNum.textColor = GetColor(whiteColor);
//    _focusNum.backgroundColor = GetColor(yellowColor);
    [self addSubview:_focusNum];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = GetColor(lightGrayColor);
    [self addSubview:lineView];
    //粉丝
    _fansBtn = [UILabel new];
    _fansBtn.textAlignment = NSTextAlignmentLeft;
    _fansBtn.backgroundColor = GetColor(clearColor);
    _fansBtn.text = @"粉丝";
    _fansBtn.font = GetFont(15);
    _fansBtn.textColor = GetColor(whiteColor);
    _fansBtn.userInteractionEnabled = YES;
    UITapGestureRecognizer *fansTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myfans)];
    [_fansBtn addGestureRecognizer:fansTap];
    [self addSubview:_fansBtn];
    //粉丝数
    _fansNum = [UILabel new];
    _fansNum.textAlignment  =NSTextAlignmentLeft;
    _fansNum.font = GetFont(15);
    _fansNum.text = @"24888";
    _fansNum.textColor = GetColor(whiteColor);
    _fansNum.backgroundColor = GetColor(clearColor);
    [self addSubview:_fansNum];
    //个人主页
    _personalBtn = [UILabel new];
    _personalBtn.backgroundColor = GetColor(clearColor);
    _personalBtn.text = @"个人主页";
    _personalBtn.textColor = GetColor(whiteColor);
    _personalBtn.textAlignment = NSTextAlignmentRight;
    _personalBtn.font = GetFont(12);
    _personalBtn.userInteractionEnabled = YES;
    UITapGestureRecognizer *personTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(personalSender)];
    [_personalBtn addGestureRecognizer:personTap];

    [self addSubview:_personalBtn];
    _imageBtn = [UIButton new];
    _imageBtn.backgroundColor = GetColor(clearColor);
    [_imageBtn setImage:GetImage(@"my_btn_arrow_right_white") forState:UIControlStateNormal];
    [_imageBtn addTarget:self action:@selector(personalSender) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_imageBtn];
    
    
    
    _mesageBtn.sd_layout
    .leftSpaceToView(self,20)
    .topSpaceToView(self,24)
    .widthIs(44)
    .heightIs(44);
    
    _settingBtn.sd_layout
    .rightSpaceToView(self,20)
    .topEqualToView(_mesageBtn)
    .widthIs(44)
    .heightIs(44);
    
    _headImageView.sd_layout
    .leftSpaceToView(self,10)
    .bottomSpaceToView(self,20)
    .heightIs(60)
    .widthIs(60);
    
    _nameLab.sd_layout
    .leftSpaceToView(_headImageView,10)
    .topEqualToView(_headImageView)
    .heightIs(30);
    
    _focusBtn.sd_layout
    .leftEqualToView(_nameLab)
    .topSpaceToView(_nameLab,0)
    .heightIs(30)
    .widthIs(40);
    
    _focusNum.sd_layout
    .leftSpaceToView(_focusBtn,5)
    .topEqualToView(_focusBtn)
    .heightIs(30);
    
    lineView.sd_layout
    .leftSpaceToView(_focusNum,5)
    .topEqualToView(_focusNum)
    .heightIs(30)
    .widthIs(1);
    
    _fansBtn.sd_layout
    .leftSpaceToView(lineView,5)
    .topEqualToView(lineView)
    .heightIs(30)
    .widthIs(40);
    
    _fansNum.sd_layout
    .leftSpaceToView(_fansBtn,5)
    .topEqualToView(_fansBtn)
    .heightIs(30);
    
    _imageBtn.sd_layout
    .rightSpaceToView(self,0)
    .leftSpaceToView(_personalBtn,0)
    .centerYEqualToView(_headImageView)
    .heightIs(20)
    .widthIs(20);
    
    _personalBtn.sd_layout
    .rightSpaceToView(_imageBtn,0)
    .centerYEqualToView(_headImageView)
    .leftSpaceToView(_fansNum,0)
    .heightIs(30);
    [_nameLab setSingleLineAutoResizeWithMaxWidth:100];
    [_focusNum setSingleLineAutoResizeWithMaxWidth:80];
    [_fansNum setSingleLineAutoResizeWithMaxWidth:80];
    [_fansBtn setSingleLineAutoResizeWithMaxWidth:40];
    [_focusBtn setSingleLineAutoResizeWithMaxWidth:40];
    [_personalBtn setSingleLineAutoResizeWithMaxWidth:80];

}
//我的消息
-(void)mesageSender{
    NSLog(@"消息");
    if ([self.delegate respondsToSelector:@selector(mesageBtned)]) {
        [self.delegate mesageBtned];
    }

}
//设置
-(void)settingSender{
    NSLog(@"设置");
    if ([self.delegate respondsToSelector:@selector(settingBtned)]) {
        [self.delegate settingBtned];
    }


}
//个人主页
-(void)personalSender{
    NSLog(@"个人主页");
    if ([self.delegate respondsToSelector:@selector(myPersonalBtned)]) {
        [self.delegate myPersonalBtned];
    }

}
//我的关注
-(void)myfocus{
    NSLog(@"我的关注");
    if ([self.delegate respondsToSelector:@selector(myFocusBtned)]) {
        [self.delegate myFocusBtned];
    }


}
//我的粉丝
-(void)myfans{
    NSLog(@"我的粉丝");
    if ([self.delegate respondsToSelector:@selector(myFansBtned)]) {
        [self.delegate myFansBtned];
    }


}
//头像点击事件
-(void)headtap{
    NSLog(@"头像呗点击");
    if ([self.delegate respondsToSelector:@selector(headImageBtned)]) {
        [self.delegate headImageBtned];
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
