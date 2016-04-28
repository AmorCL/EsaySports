//
//  CYChooseAdressView.m
//  esayou
//
//  Created by ESAY on 16/4/25.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYChooseAdressView.h"

@implementation CYChooseAdressView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    self.userInteractionEnabled  = YES;
    self.backgroundColor = GetColor(whiteColor);
    
    _leftImgView = [UIImageView new];
    _leftImgView.backgroundColor = GetColor(redColor);
    [self addSubview:_leftImgView];
    
    _textFiled = [UITextField new];
    _textFiled.userInteractionEnabled = NO;
    _textFiled.placeholder = @"目的地";
    [self addSubview:_textFiled];
    
    _rightImgView = [UIImageView new];
    _rightImgView.backgroundColor = GetColor(redColor);
    [self addSubview:_rightImgView];
    
    _leftImgView.sd_layout
    .centerYEqualToView(self)
    .leftSpaceToView(self,10)
    .widthIs(20)
    .heightIs(20);
    
    _rightImgView.sd_layout
    .rightSpaceToView(self,10)
    .centerYEqualToView(self)
    .widthIs(20)
    .heightIs(20);
    
    _textFiled.sd_layout
    .leftSpaceToView(_leftImgView,10)
    .centerYEqualToView(self)
    .rightSpaceToView(_rightImgView,10)
    .heightIs(20);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseAdress)];
    [self addGestureRecognizer:tap];
}
-(void)chooseAdress{
    if ([self.delegate respondsToSelector:@selector(chooseAdressNow)]) {
        [self.delegate chooseAdressNow];
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
