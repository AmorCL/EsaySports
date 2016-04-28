//
//  CYWriteTableHeadView.m
//  esayou
//
//  Created by ESAY on 16/4/15.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYWriteTableHeadView.h"

@implementation CYWriteTableHeadView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    
    if (_datasArray == nil) {
        _datasArray = [NSMutableArray new];
        _datasArray = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"youjiTypeList.plist" ofType:nil]];
    }

    
    CGFloat marinWith = (kScreenWidth-10*5-5*2)/6;
    
    _bagroundImageView = [[UIImageView alloc]initWithFrame:self.frame];
    _bagroundImageView.userInteractionEnabled = YES;
    [self addSubview:_bagroundImageView];
    
    for (int i = 0; i < 6; i++) {
        _buttonLab = [[CYButtonLaab alloc]initWithFrame:CGRectMake(5+(10+marinWith)*i, _bagroundImageView.height-marinWith-20, marinWith, marinWith+20)];
        _buttonLab.delegate = self;
        NSMutableDictionary *dic = _datasArray[i];
        _buttonLab.bottomLab.text = dic[@"name"];
        _buttonLab.topImageView.image = GetImage(dic[@"pic"]);
        _buttonLab.tag = i;
        [_bagroundImageView addSubview:_buttonLab];
    }
    
    _writeBtn = [UIButton new];
    _writeBtn.backgroundColor = GetColor(redColor);
    [_writeBtn setBackgroundImage:GetImage(@"") forState:UIControlStateNormal];
    [_writeBtn addTarget:self action:@selector(writeBtnisSeleted) forControlEvents:UIControlEventTouchUpInside];
    [_bagroundImageView addSubview:_writeBtn];
    
    _topBigLab = [UILabel new];
    _topBigLab.text = @"分享你的体育游记";
    _topBigLab.textAlignment = NSTextAlignmentCenter;
    _topBigLab.textColor = GetColor(whiteColor);
    _topBigLab.font = GetFont(18);
    [_bagroundImageView addSubview:_topBigLab];
    
    _writeBtn.sd_layout
    .bottomSpaceToView(_buttonLab,10)
    .centerXEqualToView(_bagroundImageView)
    .widthIs(100)
    .heightIs(30);
    
    _topBigLab.sd_layout
    .bottomSpaceToView(_writeBtn,5)
    .centerXEqualToView(_writeBtn)
    .widthIs(100)
    .heightIs(30);
    [_topBigLab setSingleLineAutoResizeWithMaxWidth:200];
    
}
-(void)writeBtnisSeleted{
    NSLog(@"写游记");
    if ([self.delegate respondsToSelector:@selector(writeTravelNotsNow)]) {
        [self.delegate writeTravelNotsNow];
    }
}
-(void)buttonIsBtned:(NSInteger)tag{
    NSLog(@"%ld点击了",tag);
    if ([self.delegate respondsToSelector:@selector(chooseType:)]) {
        [self.delegate chooseType:tag];
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
