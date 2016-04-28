//
//  CYTravelHeadView.m
//  esayou
//
//  Created by ESAY on 16/4/15.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYTravelHeadView.h"
@implementation CYTravelHeadView
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

    for (int i = 0; i < 6; i++) {
        _buttonLab = [[CYButtonLaab alloc]initWithFrame:CGRectMake(5+(10+marinWith)*i, self.frame.size.height-marinWith-20, marinWith, marinWith+20)];
        _buttonLab.delegate = self;
        NSMutableDictionary *dic = _datasArray[i];
        _buttonLab.bottomLab.text = dic[@"name"];
        _buttonLab.bottomLab.textColor = GetColor(redColor);
        _buttonLab.topImageView.image = GetImage(dic[@"pic"]);
        _buttonLab.tag = i;
        [self addSubview:_buttonLab];
    }
    _adsCycleView = [[PictureCycleView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.frame.size.height-90)];
    _adsCycleView.backgroundColor = GetColor(yellowColor);
    [self addSubview:_adsCycleView];
    
    _searchBtn = [[CYSearchBar alloc]initWithFrame:CGRectMake(30, 64-30, self.width-60, 44)];
    _searchBtn.borderStyle = UITextBorderStyleRoundedRect;
    _searchBtn.backgroundColor = GetColor(clearColor);
    _searchBtn.delegate = self;
    [self addSubview:_searchBtn];
    
    _titleLab = [UILabel new];
    _titleLab.text = @"开启全新旅游方式";
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.textColor = GetColor(whiteColor);
    _titleLab.font = GetFont(18);
    [self addSubview:_titleLab];
    
    _startBtn = [UIButton new];
    [_startBtn setTitle:@"开始定制" forState:UIControlStateNormal];
    [_startBtn setBackgroundImage:GetImage(@"") forState:UIControlStateNormal];
    _startBtn.backgroundColor = GetColor(redColor);
    [_startBtn addTarget:self action:@selector(begainOrder) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_startBtn];
    
    _adsCycleView.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topEqualToView(self)
    .bottomSpaceToView(_buttonLab,5);
    
    _titleLab.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topSpaceToView(_searchBtn,20)
    .autoHeightRatio(0);
    
    _startBtn.sd_layout
    .centerXEqualToView(self)
    .topSpaceToView(_titleLab,5)
    .widthIs(100)
    .heightIs(30);
    

}
-(void)begainOrder{
    if ([self.delegate respondsToSelector:@selector(startMyOrder)]) {
        [self.delegate startMyOrder];
    }
}
-(void)buttonIsBtned:(NSInteger)tag{
    if ([self.delegate respondsToSelector:@selector(chooseTypeOfBall:)]) {
        [self.delegate chooseTypeOfBall:tag];
    }

}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [_searchBtn resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(searchBegain)]) {
        [self.delegate searchBegain];
    }
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
